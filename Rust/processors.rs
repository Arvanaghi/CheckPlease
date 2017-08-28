/*
	Minimum number of Processors, Rust
	Module written by Sam Brown
	Website: https://samdb.xyz
	Twitter: @_samdb_
	A lot of the ffi definitions are yoinked from https://github.com/retep998/winapi-rs/
*/
use std::env;
use std::str::FromStr;

#[allow(non_snake_case)]
#[allow(non_camel_case_types)]
mod ffi {
	
	use std::os::raw::{c_ulong, c_ushort, c_void};
	
	pub type WORD = c_ushort;
	pub type DWORD = c_ulong;
	pub type ULONG_PTR = usize;
	pub type DWORD_PTR = ULONG_PTR;
	pub type LPVOID = *mut c_void;
	pub type PVOID = *mut c_void;
	
	#[repr(C)]
	pub struct SYSTEM_INFO {
		pub wProcessorArchitecture: WORD,
		pub wReserved: WORD,
		pub dwPageSize: DWORD,
		pub lpMinimumApplicationAddress: LPVOID,
		pub lpMaximumApplicationAddress: LPVOID,
		pub dwActiveProcessorMask: DWORD_PTR,
		pub dwNumberOfProcessors: DWORD,
		pub dwProcessorType: DWORD,
		pub dwAllocationGranularity: DWORD,
		pub wProcessorLevel: WORD,
		pub wProcessorRevision: WORD,
	}
	
	pub type LPSYSTEM_INFO = *mut SYSTEM_INFO;
	#[link(name = "kernel32")]
	extern "stdcall" {
		pub fn GetSystemInfo(lpSystemInfo: LPSYSTEM_INFO);
	}
	pub const NULL: PVOID = 0 as PVOID;
}

fn main() {
	let args: Vec<String> = env::args().collect();
	
	let mut min_processors = 2;
	if args.len() > 1 {
		min_processors = u32::from_str(&args[1]).unwrap();
	}
	
	let mut info = ffi::SYSTEM_INFO{
		wProcessorArchitecture: 0,
		wReserved: 0,
		dwPageSize: 0,
		lpMinimumApplicationAddress: ffi::NULL,
		lpMaximumApplicationAddress: ffi::NULL,
		dwActiveProcessorMask: 0,
		dwNumberOfProcessors: 0,
		dwProcessorType: 0,
		dwAllocationGranularity: 0,
		wProcessorLevel: 0,
		wProcessorRevision: 0
	};
	
	unsafe {
		ffi::GetSystemInfo(&mut info);
	}
	let num_processors = info.dwNumberOfProcessors;
	
	if num_processors >= min_processors {
		println!("Number of processors: {}", num_processors);
		println!("Proceed!");
	} else {
		println!("Number of processors: {}", num_processors);
	}
}