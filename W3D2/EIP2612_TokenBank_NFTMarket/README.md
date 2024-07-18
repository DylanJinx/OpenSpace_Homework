在`test/SignWLVerify.sol`中，一直验证白名单签名一直都通不过，原因是在测试中，模拟签名时，计算`structHash`时，直接将表头(`WL_TYPEHASH`)通过`marketContract.WL_TYPEHASH`直接调用过来使用，这里是错误的。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract test {
    bytes32 public constant WL_TYPEHASH = keccak256("BuyWithWL(address user)");
}

contract test2 {
    test public test1;

    constructor(test _test1) {
        test1 = _test1;
    }
    
//     TypeError: Return argument type function () view external returns (bytes32) is not implicitly convertible to expected type (type of first return variable) bytes32.
//   --> contracts/testWL_TYPEHASH.sol:22:16:
//    |
// 22 |         return test1.WL_TYPEHASH;
//    |                ^^^^^^^^^^^^^^^^^

    function watch_WL_TYPEHASH() public view returns(bytes32) {
        return test1.WL_TYPEHASH;
    }

}
```

直接查看会报错，在Solidity中，对于合约中定义的任何公共状态变量，编译器都会自动创建一个getter函数。这个自动生成的getter函数允许其他合约或外部调用者读取这些变量的值。自动生成的getter函数的特点如下：

- 返回类型：Getter函数的返回类型与状态变量的类型相匹配。例如，如果状态变量是bytes32类型，那么getter函数也会返回bytes32。

- 访问修饰符：这些函数是公共的（public），意味着它们可以在合约内部被调用，也可以通过外部交易或从其他合约被调用。

- 函数名：Getter函数的名称与状态变量的名称相同。例如，如果你有一个公共状态变量bytes32 public WL_TYPEHASH，那么getter函数的名称也是WL_TYPEHASH。

- 参数：如果状态变量是一个数组或者映射，getter函数将包含必要的参数以便访问特定的元素或键值。例如，对于mapping(uint => address) public accounts;，自动生成的getter函数将是function accounts(uint index) public view returns (address)。

- 纯度：Getter函数通常是view类型，因为它们不会修改状态，只是读取状态。

解决方法有两个：
方法一：在后面加括号，这里就是调用getter函数
```solidity
function watch_WL_TYPEHASH() public view returns(bytes32) {
        return test1.WL_TYPEHASH();
    }
```

方法二：自己写一个get函数
```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract test {
    bytes32 public constant WL_TYPEHASH = keccak256("BuyWithWL(address user)");

    function get_WL_TYPEHASH() public pure returns (bytes32) {
        return WL_TYPEHASH;
    }
}

contract test2 {
    test public test1;

    constructor(test _test1) {
        test1 = _test1;
    }

    function watch_WL_TYPEHASH() public view returns(bytes32) {
        return test1.get_WL_TYPEHASH();
    }

}
```

