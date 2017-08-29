/*
    Checks all loaded process names, Rust
    Module written by Sam Brown
    Website: https://samdb.xyz
    Twitter: @_samdb_
	A lot of the ffi definitions are yoinked from https://github.com/retep998/winapi-rs/
*/

use std::mem;
use std::str;

#[allow(non_camel_case_types)]
#[allow(non_snake_case)]
mod ffi {
	use std::os::raw::{c_ulong, c_long, c_int, c_uchar, c_void};
	pub type CHAR = c_uchar;
	pub type DWORD = c_ulong;
	pub type LONG = c_long;
	pub type ULONG_PTR = usize;
	pub type BOOL = c_int;
	pub type HANDLE = *mut c_void;
	
	#[repr(C)]
	pub struct PROCESSENTRY32 {
		pub dwSize: DWORD,
		pub cntUsage: DWORD,
		pub th32ProcessID: DWORD,
		pub th32DefaultHeapID: ULONG_PTR,
		pub th32ModuleID: DWORD,
		pub cntThreads: DWORD,
		pub th32ParentProcessID: DWORD,
		pub pcPriClassBase: LONG,
		pub dwFlags: DWORD,
		pub szExeFile: [CHAR; MAX_PATH],
	}
	
	pub type LPPROCESSENTRY32 = *mut PROCESSENTRY32;
	
	#[link(name = "kernel32")]
	extern "stdcall" {
		pub fn CreateToolhelp32Snapshot(dwFlags: DWORD, th32ProcessID: DWORD) -> HANDLE;
		pub fn Process32First(hSnapshot: HANDLE, lppe: LPPROCESSENTRY32) -> BOOL;
		pub fn Process32Next(hSnapshot: HANDLE, lppe: LPPROCESSENTRY32) -> BOOL;
		pub fn CloseHandle(hObject: HANDLE) -> BOOL;
	}
	pub const TH32CS_SNAPPROCESS: DWORD = 0x00000002;
	pub const INVALID_HANDLE_VALUE: HANDLE = -1isize as HANDLE;
	pub const MAX_PATH: usize = 260;
}

const SANDBOX_PROCESSES: [& 'static str; 21] = ["vmsrvc", "tcpview", "wireshark", "visual basic", "fiddler", "vmware", "vbox", "process explorer", "autoit", "vboxtray", "vmtools", "vmrawdsk", "vmusbmouse", "vmvss", "vmscsi", "vmxnet", "vmx_svga", "vmmemctl", "df5serv", "vboxservice", "vmhgfs"];

fn main() {
	
	let h_process_snapshot;
	unsafe {
		h_process_snapshot = ffi::CreateToolhelp32Snapshot(ffi::TH32CS_SNAPPROCESS, 0);
	}
	if h_process_snapshot == ffi::INVALID_HANDLE_VALUE {
		println!("Could not create snapshot, exiting.");
		std::process::exit(1);
	}
	let mut pe32 = ffi::PROCESSENTRY32 {
		dwSize: mem::size_of::<ffi::PROCESSENTRY32>() as ffi::DWORD,
		cntUsage: 0,
		th32ProcessID: 0,
		th32DefaultHeapID: 0,
		th32ModuleID: 0,
		cntThreads: 0,
		th32ParentProcessID: 0,
		pcPriClassBase: 0,
		dwFlags: 0,
		szExeFile: [0; ffi::MAX_PATH]
	};
	let mut res;
	unsafe	{
		res = ffi::Process32First(h_process_snapshot, &mut pe32);
	}
	if res == 0 {
		println!("Could not retrieve information about processes, exiting.");
		unsafe {
			ffi::CloseHandle(h_process_snapshot);
		}
		std::process::exit(1);
	}
	let mut evidence_count = 0;
	
	loop {
		{
			let len = pe32.szExeFile.iter().position(|&r| r == 0).unwrap();
			let proc_name_str = str::from_utf8(&pe32.szExeFile[0..len]).unwrap();
			for sandbox_name in SANDBOX_PROCESSES.iter() {
				if proc_name_str.contains(sandbox_name) {
					println!("{}", proc_name_str);
					evidence_count += 1;
				}
			}
		}
		unsafe {
			res = ffi::Process32Next(h_process_snapshot, &mut pe32);
		}
		if res == 0 {
			break;
		}
	}
	if evidence_count == 0 {
		println!("Proceed!");
	}
}