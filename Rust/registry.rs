/*
	Windows Registry key and value checker, Rust
	Module written by Sam Brown
	Website: https://samdb.xyz
	Twitter: @_samdb_
	A lot of the ffi definitions are yoinked from https://github.com/retep998/winapi-rs/
*/

use std::str;

#[allow(non_camel_case_types)]
mod ffi {

	use std::os::raw::{c_long, c_ulong, c_uchar, c_void};
	pub type LONG = c_long;
	pub type DWORD = c_ulong;
	pub type LPDWORD = *mut DWORD;
	pub type BYTE = c_uchar;
	pub type LPBYTE = *mut BYTE;
	pub enum HKEY__ {}
	pub type HKEY = *mut HKEY__;
	pub type PHKEY = *mut HKEY;
	pub type REGSAM = DWORD;
	pub type CHAR = c_uchar;
	pub type LPCSTR = *const CHAR;
	pub type PVOID = *mut c_void;
	
	#[link(name = "kernel32")]
	extern "stdcall" {
		pub fn RegOpenKeyExA(hKey: HKEY, lpSubKey: LPCSTR, ulOptions: DWORD, samDesired: REGSAM, phkResult: PHKEY) -> LONG;
		pub fn RegQueryValueExA(hKey: HKEY, lpValueName: LPCSTR, lpReserved: LPDWORD, lpType: LPDWORD, lpData: LPBYTE, lpcbData: LPDWORD) -> LONG;
		pub fn RegCloseKey(hKey: HKEY) -> LONG;
	}
	pub const SYNCHRONIZE: DWORD = 0x00100000;
	pub const STANDARD_RIGHTS_READ: DWORD = 0x00020000;
	pub const HKEY_LOCAL_MACHINE: HKEY = 0x80000002 as isize as HKEY;
	pub const KEY_QUERY_VALUE: u32 = 0x0001;
	pub const KEY_ENUMERATE_SUB_KEYS: u32 = 0x0008;
	pub const KEY_NOTIFY: u32 = 0x0010;
	pub const KEY_READ: u32 = (STANDARD_RIGHTS_READ | KEY_QUERY_VALUE | KEY_ENUMERATE_SUB_KEYS | KEY_NOTIFY) & !SYNCHRONIZE;
	pub const NULL: PVOID = 0 as PVOID;
}

const SANDBOX_STRINGS: [& 'static str; 5] = ["VMWare", "virtualbox", "vbox", "qemu", "xen"];
const HKLM_KEYS_TO_CHECK_EXIST: [& 'static str; 7] = [
	"HARDWARE\\DEVICEMAP\\Scsi\\Scsi Port 2\\Scsi Bus 0\\Target Id 0\\Logical Unit Id 0\\Identifier",
	"SYSTEM\\CurrentControlSet\\Enum\\SCSI\\Disk&Ven_VMware_&Prod_VMware_Virtual_S",
	"SYSTEM\\CurrentControlSet\\Control\\CriticalDeviceDatabase\\root#vmwvmcihostdev",
	"SYSTEM\\CurrentControlSet\\Control\\VirtualDeviceDrivers",
	"SOFTWARE\\VMWare, Inc.\\VMWare Tools",
	"SOFTWARE\\Oracle\\VirtualBox Guest Additions",
	"HARDWARE\\ACPI\\DSDT\\VBOX_"
];

		
const HKLM_KEYS_WITH_VALUES_TO_PRASE: [[&str; 2]; 6] = [
	["SYSTEM\\ControlSet001\\Services\\Disk\\Enum", "0"],
	["HARDWARE\\Description\\System", "SystemBiosInformation"],
	["HARDWARE\\Description\\System", "VideoBiosVersion"],
	["HARDWARE\\Description\\System\\BIOS", "SystemManufacturer"],
	["HARDWARE\\Description\\System\\BIOS", "SystemProductName"],
	["HARDWARE\\DEVICEMAP\\Scsi\\Scsi Port 0\\Scsi Bus 0\\Target Id 0", "Logical Unit Id 0"]
];

fn main() {
	let mut evidence_of_sandbox: u32 = 0;
	let mut h_key: ffi::HKEY = ffi::NULL as ffi::HKEY;
	for key in HKLM_KEYS_TO_CHECK_EXIST.iter(){
		let res;
		unsafe {
			res = ffi::RegOpenKeyExA(ffi::HKEY_LOCAL_MACHINE, key.as_bytes().as_ptr(), 0, ffi::KEY_READ, &mut h_key); 
		}
		if res == 0 {
			println!("{}", key);
			evidence_of_sandbox += 1;
			unsafe {
				ffi::RegCloseKey(h_key);
			}
		}
	}
	
	for pair in HKLM_KEYS_WITH_VALUES_TO_PRASE.iter() {
		let mut res;
		let mut data = [0; 1024];
		unsafe {
			res = ffi::RegOpenKeyExA(ffi::HKEY_LOCAL_MACHINE, pair[0].as_bytes().as_ptr(), 0, ffi::KEY_READ, &mut h_key); 
		}
		if res == 0 {
			unsafe {
				res = ffi::RegQueryValueExA(h_key, pair[1].as_bytes().as_ptr(), &mut 0, &mut 0, data.as_mut_ptr(), &mut (data.len() as u32));
			}
			if res == 0 {
				for sandbox_string in SANDBOX_STRINGS.iter() {
					let value = str::from_utf8(&data).unwrap();
					if value.contains(sandbox_string) {
						println!("{}\\{} --> {}", pair[0], pair[1], value);
						evidence_of_sandbox += 1;
					}	
				}
			}
			unsafe {
				ffi::RegCloseKey(h_key);
			}
		}
	}
	
	if evidence_of_sandbox == 0 {
		println!("Proceed!");
	}
}