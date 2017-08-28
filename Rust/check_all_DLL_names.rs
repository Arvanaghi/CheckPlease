/*
    Checks all DLL names loaded by each process, Rust
    Module written by Sam Brown
    Website: https://samdb.xyz
    Twitter: @_samdb_
	A lot of the ffi definitions are yoinked from https://github.com/retep998/winapi-rs/
*/

use std::mem;
use std::str;

#[allow(non_camel_case_types)]
mod ffi {
	
	use std::os::raw::{c_ulong, c_int, c_void, c_uchar};
	
	pub type DWORD = c_ulong;
	pub type LPDWORD = *mut DWORD;
	pub type HANDLE = *mut c_void;
	pub type LPSTR = *mut c_uchar;
	pub type PVOID = *mut c_void;
	
	pub enum HINSTANCE__ {}
	pub type HINSTANCE = *mut HINSTANCE__;
	pub type HMODULE = HINSTANCE;
	pub type BOOL = c_int;
	
	#[link(name = "psapi")]
	extern "stdcall" {
		pub fn EnumProcesses(lpidProcess: *mut DWORD, cb: DWORD, lpcbNeeded: LPDWORD) -> BOOL;
		pub fn EnumProcessModules(hProcess: HANDLE, lphModule: *mut HMODULE, cb: DWORD, lpcbNeeded: LPDWORD) -> BOOL;
		pub fn GetProcessImageFileNameA(hProcess: HANDLE, lpImageFileName: LPSTR, nSize: DWORD) -> DWORD;
		pub fn GetModuleFileNameExA(hProcess: HANDLE, hModule: HMODULE, lpFilename: LPSTR, nSize: DWORD) -> DWORD;
		pub fn OpenProcess(dwDesiredAccess: DWORD, bInheritHandle: BOOL, dwProcessId: DWORD) -> HANDLE;
		pub fn CloseHandle(hObject: HANDLE) -> BOOL;
	}
	pub const PROCESS_QUERY_INFORMATION: DWORD = 0x0400;
	pub const PROCESS_VM_READ: DWORD = 0x0010;
	pub const NULL: PVOID = 0 as PVOID;
	pub const MAX_PATH: usize = 260;
}

const SANDBOX_DLLS: [& 'static str; 7] = [ "sbiedll.dll", "dbghelp.dll", "api_log.dll", "dir_watch.dll", "pstorec.dll", "vmcheck.dll", "wpespy.dll"];


fn main() {
	let mut cb_needed: ffi::DWORD = 0;
	let c_processes;
	let mut loaded_processes: [ffi::DWORD; 1024] = [0; 1024];
	let res: ffi::BOOL;
	
	//Get all pids
	unsafe {
		res = ffi::EnumProcesses(loaded_processes.as_mut_ptr(), loaded_processes.len() as u32, &mut cb_needed);
	}
	if res != 1 {
		println!("Could not get all PIDs!");
		std::process::exit(1);
	}
	
	//Calculate how many PIDs we've been given
	c_processes = cb_needed / mem::size_of::<ffi::DWORD>() as u32;
	
	//Check all loaded DLLs in each process
	let mut h_process: ffi::HANDLE;
	let mut evidence_count: u32 = 0;
	for x in 0..c_processes {
		//Grab a handle to each process
		unsafe {
			h_process = ffi::OpenProcess(ffi::PROCESS_QUERY_INFORMATION | ffi::PROCESS_VM_READ, 0, loaded_processes[x as usize]);
		}
		if h_process == ffi::NULL{ 
			continue;
		}
		//Get a list of all modules
		let mut h_mods = [ffi::NULL as ffi::HINSTANCE; 1024]; 
		let res;
		unsafe {
			res = ffi::EnumProcessModules(h_process, h_mods.as_mut_ptr(), mem::size_of::<[ffi::HMODULE; 1024]>() as u32, &mut cb_needed);
		}
		if res != 0 {
			for i in 0..cb_needed / mem::size_of::<ffi::HMODULE>() as u32 {
				//Get module names
				let mut mod_name = [0; ffi::MAX_PATH];
				let res: ffi::DWORD;
				unsafe {
					res = ffi::GetModuleFileNameExA(h_process, h_mods[i as usize], mod_name.as_mut_ptr(), ffi::MAX_PATH as u32);
				}
				if res != 0 {
					//Check for sandbox dll names for each module 
					for dll_name in SANDBOX_DLLS.iter() {
						let mod_name_len = mod_name.iter().position(|&r| r == 0).unwrap();
						let mod_name_str = str::from_utf8(&mod_name[0..mod_name_len]).unwrap();
						if mod_name_str.contains(dll_name) {
							let mut proc_name = [0; ffi::MAX_PATH];
							unsafe {
								ffi::GetProcessImageFileNameA(h_process, proc_name.as_mut_ptr(), ffi::MAX_PATH as u32);
							}
							let proc_name_len = proc_name.iter().position(|&r| r == 0).unwrap();
							let proc_name_str = str::from_utf8(&proc_name[0..proc_name_len]).unwrap();
							println!("Process name: {}", proc_name_str);
							println!("\tDLL loaded: {}", mod_name_str);
							evidence_count += 1;
						}
					}
				}
			}
		}
		unsafe {
			ffi::CloseHandle(h_process);
		}
	}
	
	if evidence_count == 0 {
		println!("No sandbox-indicative DLLs were discovered loaded in any accessible running process. Proceed!");
	}
}