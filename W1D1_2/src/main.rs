use rsa::{RsaPrivateKey, RsaPublicKey, PaddingScheme, PublicKey};
use rand::rngs::OsRng;
use sha2::{Sha256, Digest};
use hex::encode;

fn main() {
    // 生成RSA密钥对
    let mut rng = OsRng;
    let bits = 2048;
    let private_key = RsaPrivateKey::new(&mut rng, bits).expect("Failed to generate a key");
    let public_key = RsaPublicKey::from(&private_key);

    // println!("Private key: {:?}", private_key);
    // println!("Public key: {:?}", public_key);

    let nickname = "dylan";
    let nonce = 75504;

    // 创建待签名的数据
    let data = format!("{}{}", nickname, nonce);
    let hash = Sha256::digest(data.as_bytes());

    // println!("Data: {}", data);
    // println!("Hash: {}", encode(&hash));

    // 对数据进行签名
    let signature = {
        let padding = PaddingScheme::new_pkcs1v15_sign(Some(rsa::hash::Hash::SHA2_256));
        private_key.sign(padding, &hash).expect("Failed to sign data")
    };
    println!("Signature: {}", encode(&signature));

    // 使用公钥验证签名
    let is_valid = {
        let padding = PaddingScheme::new_pkcs1v15_sign(Some(rsa::hash::Hash::SHA2_256));
        public_key.verify(padding, &hash, &signature).is_ok()
    };
    println!("Signature is valid: {}", is_valid);
}
