/*
    Checks the executable has been renamed to its md5, sha1 or sha256 hash, Rust
    Module written by Sam Brown
    Website: https://samdb.xyz
    Twitter: @_samdb_
	As seen in https://www.proofpoint.com/us/threat-insight/post/ursnif-banking-trojan-campaign-sandbox-evasion-techniques
*/
extern crate crypto;

use crypto::md5::Md5;
use crypto::sha2::Sha256;
use crypto::sha1::Sha1;
use crypto::digest::Digest;


use std::env;
use std::io::prelude::*;
use std::fs::File;

fn main() {
    let path = env::current_exe().expect("Failed to get current exe path");
	let mut md5 = Md5::new();
	let mut sha256 = Sha256::new();
	let mut sha1 = Sha1::new();
	let mut f = File::open(&path).expect("Failed to open self");
	let mut buffer = Vec::new();
	f.read_to_end(&mut buffer).expect("Failed to read self");
	md5.input(&buffer);
	sha256.input(&buffer);
	sha1.input(&buffer);
	let md5_hash = md5.result_str();
	let sha256_hash = sha256.result_str();
	let sha1_hash = sha1.result_str();
	let file_name = path.file_stem().expect("Failed to extact file name").to_string_lossy();
	if md5_hash == file_name || sha256_hash == file_name || sha1_hash == file_name {
		println!("Filename is hash of file!");
	} else {
		println!("Continue");
	}
}