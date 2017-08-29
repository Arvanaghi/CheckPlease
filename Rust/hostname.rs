/*
    Hostname checker, Rust
    Module written by Sam Brown
    Website: https://samdb.xyz
    Twitter: @_samdb_
	A lot of the ffi definitions are yoinked from https://github.com/retep998/winapi-rs/
*/

use std::env;
use std::ffi::OsString;
use std::os::windows::ffi::OsStringExt;

#[allow(non_camel_case_types)]
mod ffi {
	
	use std::os::raw::{c_ulong, c_int};
	
	pub type DWORD = c_ulong;
	pub type LPDWORD = *mut DWORD;
	pub type BOOL = c_int;
	pub type LPWSTR = *mut u16;
	
	#[link(name = "kernel32")]
	extern "stdcall" {
		pub fn GetComputerNameW(lpBuffer: LPWSTR, nSize: LPDWORD) -> BOOL;
	}
}

fn main() {
	let args: Vec<String> = env::args().collect();
	
	if args.len() < 2 {
		println!("Please provide target hostname");
		std::process::exit(1);
	}

	let target: &String = &args[1];
	
	let res: ffi::BOOL;
	let mut buffer: [u16; 3267] = [0; 3267];
	let mut size: ffi::DWORD = 3267;
	unsafe {
		res = ffi::GetComputerNameW(buffer.as_mut_ptr(), &mut size);
	}

	if res == 0 {
		println!("Could not read computer name, exiting.");
		std::process::exit(1);
	}

	let raw_hostname = &buffer[0..size as usize];
	let hostname = OsString::from_wide(raw_hostname).into_string().unwrap();
	if hostname == *target {
		println!("Proceed!");
	} else {
		println!("Hostname: {}", hostname);
	}
}