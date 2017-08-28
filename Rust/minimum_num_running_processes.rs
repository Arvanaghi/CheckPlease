/*
	Ensures there are more than N processes currently running on the system (default: 50), Rust
	Ensures at least N processes running on the system (defaults to 50)
	Module written by Sam Brown
	Website: https://samdb.xyz
	Twitter: @_samdb_
	A lot of the ffi definitions are yoinked from https://github.com/retep998/winapi-rs/
*/


use std::mem;
use std::env;
use std::str;
use std::str::FromStr;

#[allow(non_camel_case_types)]
mod ffi {
	
	use std::os::raw::{c_ulong, c_int};
	
	pub type DWORD = c_ulong;
	pub type LPDWORD = *mut DWORD;
	pub type BOOL = c_int;
	
	#[link(name = "psapi")]
	extern "stdcall" {
		pub fn EnumProcesses(lpidProcess: *mut DWORD, cb: DWORD, lpcbNeeded: LPDWORD) -> BOOL;
	}
}

fn main() {
	let args: Vec<String> = env::args().collect();
	
	let mut min_processes: u32 = 50;
	if args.len() > 1 {
		min_processes = u32::from_str(&args[1]).unwrap();
	}
	
	let mut cb_needed: ffi::DWORD = 0;
	let c_processes: ffi::DWORD;
	let mut loaded_processes: [ffi::DWORD; 1024] = [0; 1024];
	let res: ffi::BOOL;
	unsafe {
		res = ffi::EnumProcesses(loaded_processes.as_mut_ptr(), loaded_processes.len() as u32, &mut cb_needed);
	}
	if res == 0 {
		println!("Could not get all PIDs, exiting.");
		std::process::exit(1);
	}
	
	c_processes = cb_needed / mem::size_of::<ffi::DWORD>() as u32;

	if c_processes >  min_processes {
		println!("There are {} processes running on the system, which satisfies the minimum you set of {}. Proceed!", c_processes, min_processes);
	} else {
		println!("Only {} processes are running on the system, which is less than the minimum you set of {}. Do not proceed.", c_processes, min_processes);
	}
}