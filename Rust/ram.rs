/*
	Minimum amount of RAM, Rust
	Module written by Sam Brown
	Website: https://samdb.xyz
	Twitter: @_samdb_
	A lot of the ffi definitions are yoinked from https://github.com/retep998/winapi-rs/
*/

use std::mem;

#[allow(non_snake_case)]
#[allow(non_camel_case_types)]
mod ffi {
	
	use std::os::raw::{c_int, c_ulong};
	
	pub type BOOL = c_int;
	pub type DWORD = c_ulong;
	pub type DWORDLONG = u64;
	
	#[repr(C)]
	pub struct MEMORYSTATUSEX {
		pub dwLength: DWORD,
		pub dwMemoryLoad: DWORD,
		pub ullTotalPhys: DWORDLONG,
		pub ullAvailPhys: DWORDLONG,
		pub ullTotalPageFile: DWORDLONG,
		pub ullAvailPageFile: DWORDLONG,
		pub ullTotalVirtual: DWORDLONG,
		pub ullAvailVirtual: DWORDLONG,
		pub ullAvailExtendedVirtual: DWORDLONG
	}
	pub type LPMEMORYSTATUSEX = *mut MEMORYSTATUSEX;
	
	#[link(name = "kernel32")]
	extern "stdcall" {
		pub fn GlobalMemoryStatusEx(lpBuffer: LPMEMORYSTATUSEX) -> BOOL;
	}
}


fn main() {
	
	let mut memory_status = ffi::MEMORYSTATUSEX{
		dwLength: mem::size_of::<ffi::MEMORYSTATUSEX>() as u32,
		dwMemoryLoad: 0,
		ullTotalPhys: 0,
		ullAvailPhys: 0,
		ullTotalPageFile: 0,
		ullAvailPageFile: 0,
		ullTotalVirtual: 0,
		ullAvailVirtual: 0,
		ullAvailExtendedVirtual:0
	};
	
	let res;
	unsafe {
		res = ffi::GlobalMemoryStatusEx(&mut memory_status);
	}
	
	if res == 0 {
		println!("Failed to read system memory status, exiting.");
		std::process::exit(1);
	}
		
	if (memory_status.ullTotalPhys as f64 / 1073741824.0) > 1.0 {
		println!("The RAM of this host is at least 1 GB in size. Proceed!");
	} else {
		println!("Less than 1 GB of RAM exists on this system. Do not proceed.");
	}
}