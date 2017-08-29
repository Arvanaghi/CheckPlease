/*
    Username checker, Rust
    Module written by Sam Brown
    Website: http://samdb.xyz 
    Twitter: @_samdb_
	A lot of the ffi definitions are yoinked from https://github.com/retep998/winapi-rs/
*/
use std::str;
use std::env;
use std::os::raw::c_ulong;
use std::ffi::OsString;
use std::os::windows::ffi::OsStringExt;

#[allow(non_camel_case_types)]
mod ffi {
	
	use std::os::raw::{c_ulong, c_int};
	
	pub type LPDWORD = *mut c_ulong;
	pub type LPWSTR = *mut u16;
	
	pub type BOOL = c_int;
	
	#[link(name = "Advapi32")]
	extern "stdcall" {
		pub fn GetUserNameW(lpBuffer: LPWSTR, pcbBuffer: LPDWORD) -> BOOL;
	}
}

fn main(){
	let args: Vec<String> = env::args().collect();
	
	if args.len() < 2 {
		println!("Please provide target username");
		std::process::exit(1);
	}
	
	let mut len: c_ulong = 3267;
	let mut buf: Vec<u16> = vec![0; len as usize];
	
	let res;
	unsafe {
		res = ffi::GetUserNameW(buf.as_mut_ptr(), &mut len);
	}
	if len == 0 ||  res != 1 {
		println!("Failed to decode username!");
		std::process::exit(1);
	}
	let raw_username = &buf[0..(len - 1) as usize];
	let username = OsString::from_wide(raw_username).into_string().unwrap();
	if username == args[1] {
		println!("Proceed!");
	} else {
		println!("Username: {}", username);
	}
}