// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SchoolOptimizedList {
    mapping(address => uint256) public scores;
    mapping(address => address) _nextStudents;
    uint256 public listSize;
    address constant GUARD = address(1);

    constructor() {
        _nextStudents[GUARD] = GUARD;
    }

    function addStudent(
        address _student, // 要添加的学生地址
        uint256 _score,  // 学生的分数
        address _prevStudent // 候选位置的学生，新学生插入在这个学生之后
    ) public {
        require(_nextStudents[_student] == address(0), "student not exists");
        // 检查候选学生必须已经在链表中（即其地址应有后继节点），以便在其后插入新学生
        require(_nextStudents[_prevStudent] != address(0), "_prevStudent not exists");
        require(_verifyIndex(_prevStudent, _score, _nextStudents[_prevStudent]), "invalid index");

        scores[_student] = _score;
        _nextStudents[_student] = _nextStudents[_prevStudent]; // 新学生指向候选学生原来指向的学生
        _nextStudents[_prevStudent] = _student; // 候选学生现在指向新学生
        listSize++;
    }

    function removeStudent(
        address _student, // 要删除的学生
        address _prevStudent // 前一个学生
    ) public {
        require(_nextStudents[_student] != address(0), "student not exists");
        require(_isPrevStudent(_student, _prevStudent), "invalid index");

        _nextStudents[_prevStudent] = _nextStudents[_student]; // 被移除学生的前一个学生的后继节点更新为被移除学生的后继节点
        _nextStudents[_student] = address(0); // 被移除学生的后继节点置为0
        scores[_student] = 0;
        listSize--;
    }

    function increaseScore(
        address _student,
        uint256 _score,
        address _oldPrevStudent,
        address _newPrevStudent
    ) public {
        updateScore(_student, scores[_student] + _score, _oldPrevStudent, _newPrevStudent);
    }

    function reduceScore(
        address _student,
        uint256 _score,
        address _oldPrevStudent,
        address _newPrevStudent
    ) public {
        updateScore(_student, scores[_student] - _score, _oldPrevStudent, _newPrevStudent);
    }

    function updateScore(
        address _student,
        uint256 _newScore,
        address _oldPrevStudent,
        address _newPrevStudent
    ) public {
        require(_nextStudents[_student] != address(0), "student not exists");
        require(_nextStudents[_oldPrevStudent] != address(0), "oldCandidateStudent not exists");
        require(_nextStudents[_newPrevStudent] != address(0), "newCandidateStudent not exists");

        if (_oldPrevStudent == _newPrevStudent) {
            require(_isPrevStudent(_student, _oldPrevStudent), "invalid index");
            require(_verifyIndex(_newPrevStudent, _newScore, _nextStudents[_student]), "invalid index");
            scores[_student] = _newScore;
        } else {
            removeStudent(_student, _oldPrevStudent);
            addStudent(_student, _newScore, _newPrevStudent);
        }
    }

    function getTop(uint256 k) public view returns(address[] memory) {
        require(k <= listSize, "k is too large");

        address[] memory studentLists = new address[](k);
        address currentAddress = _nextStudents[GUARD];

        for(uint i = 0; i < k; i++) {
            studentLists[i] = currentAddress;
            currentAddress = _nextStudents[currentAddress];
        }

        return studentLists;
    }

    function _verifyIndex(
        address prevStudent, // 前一个学生
        uint256 newValue,    // 新插入的学生的分数
        address nextStudent  // 后一个学生
    ) internal view returns (bool) {
        return (prevStudent == GUARD || scores[prevStudent] >= newValue) && 
                (nextStudent == GUARD || newValue > scores[nextStudent]);
    }

    function _isPrevStudent(
        address student,
        address prevStudent
    ) internal view returns(bool) {
        return _nextStudents[prevStudent] == student;
    }
}