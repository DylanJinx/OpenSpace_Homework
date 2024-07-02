use sha2::{Sha256, Digest};
use std::time::Instant;

fn main() {
    let nickname = "dylan";
    let mut nonce = 0;
    let mut hash = String::new();
    
    // 找到满足4个0开头的哈希值
    let start = Instant::now();
    loop {
        let input = format!("{}{}", nickname, nonce);
        let mut hasher = Sha256::new();
        hasher.update(input.as_bytes());
        let result = hasher.finalize();
        hash = format!("{:x}", result);
        
        if hash.starts_with("0000") {
            let duration = start.elapsed();
            println!("4 leading zeros found!");
            println!("Time taken: {:?}", duration);
            println!("Hash: {}", hash);
            println!("Nonce: {}", nonce);
            break;
        }
        nonce += 1;
    }
    
    // 继续寻找满足5个0开头的哈希值
    nonce = 0;  // 重置 nonce
    let start = Instant::now();
    loop {
        let input = format!("{}{}", nickname, nonce);
        let mut hasher = Sha256::new();
        hasher.update(input.as_bytes());
        let result = hasher.finalize();
        hash = format!("{:x}", result);
        
        if hash.starts_with("00000") {
            let duration = start.elapsed();
            println!("5 leading zeros found!");
            println!("Time taken: {:?}", duration);
            println!("Hash: {}", hash);
            println!("Nonce: {}", nonce);
            break;
        }
        nonce += 1;
    }
}
