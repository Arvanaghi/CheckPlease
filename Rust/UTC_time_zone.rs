/*
    Checks if time zone is Coordinated Universal Time (UTC), Rust
    Module written by Sam Brown
    Website: https://samdb.xyz
    Twitter: @_samdb_
	A lot of the ffi definitions are yoinked from https://github.com/retep998/winapi-rs/
*/

use std::ffi::OsString;
use std::os::windows::ffi::OsStringExt;

#[allow(non_snake_case)]
#[allow(non_camel_case_types)]
mod ffi {
	
	use std::os::raw::{c_ulong, c_long, c_ushort};
	
	pub type WCHAR = u16;
	pub type DWORD = c_ulong;
	pub type LONG = c_long;
	pub type WORD = c_ushort;
	
	#[repr(C)]
	pub struct SYSTEMTIME {
		pub wYear: WORD,
		pub wMonth: WORD,
		pub wDayOfWeek: WORD,
		pub wDay: WORD,
		pub wHour: WORD,
		pub wMinute: WORD,
		pub wSecond: WORD,
		pub wMilliseconds: WORD
	}
	impl Copy for SYSTEMTIME {}
	impl Clone for SYSTEMTIME {
		#[inline]
		fn clone(&self) -> SYSTEMTIME { *self }
	}
	
	#[repr(C)]
	pub struct TIME_ZONE_INFORMATION {
		pub Bias: LONG,
		pub StandardName: [WCHAR; 32],
		pub StandardDate: SYSTEMTIME,
		pub StandardBias: LONG,
		pub DaylightName: [WCHAR; 32],
		pub DaylightDate: SYSTEMTIME,
		pub DaylightBias: LONG
	}
	
	pub type LPTIME_ZONE_INFORMATION = *mut TIME_ZONE_INFORMATION;
	#[link(name = "kernel32")]
	extern "stdcall" {
		pub fn GetTimeZoneInformation(lpTimeZoneInformation: LPTIME_ZONE_INFORMATION) -> DWORD;
	}
	pub const TIME_ZONE_ID_INVALID: DWORD = 0xFFFFFFFF;
}

fn main() {
	let sys_time = ffi::SYSTEMTIME{
		wYear: 0,
		wMonth: 0,
		wDayOfWeek: 0,
		wDay: 0,
		wHour: 0,
		wMinute: 0,
		wSecond: 0,
		wMilliseconds: 0
	};
	let mut time_zone = ffi::TIME_ZONE_INFORMATION {Bias: 0, StandardName: [0; 32], StandardDate:sys_time, StandardBias: 0, DaylightName: [0; 32], DaylightDate: sys_time, DaylightBias: 0};
	let res: ffi::DWORD;
	unsafe {
		res = ffi::GetTimeZoneInformation(&mut time_zone);
	}
	
	if res == ffi::TIME_ZONE_ID_INVALID {
		println!("Unable to retrieve time zone informaiton, exiting.");
		std::process::exit(1);
	}
	
	let standard_name = OsString::from_wide(&time_zone.StandardName).into_string().unwrap();
	let daylight_name = OsString::from_wide(&time_zone.DaylightName).into_string().unwrap();
	if standard_name.contains("Coordinated Universal Time") || daylight_name.contains("Coordinated Universal Time") {
		println!("The time zone is Coordinated Universal Time (UTC), do not proceed.");
	} else {
		println!("The time zone is {}. Proceed!", standard_name);
	}
}