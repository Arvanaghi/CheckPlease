/*
    MAC address checker, Rust
    Most code taken from https://msdn.microsoft.com/en-us/library/windows/desktop/aa366062(v=vs.85).aspx
    Module written by Sam Brown
    Website: https://samdb.xyz
    Twitter: @_samdb_
*/

use std::mem;

#[allow(non_snake_case)]
#[allow(non_camel_case_types)]
mod ffi {
	
	use std::os::raw::{c_ulong, c_uint, c_int, c_uchar};
	
	pub type DWORD = c_ulong;
	pub type BOOL = c_int;
	pub type UINT = c_uint;
	pub type CHAR = c_uchar;
	pub type BYTE = c_uchar;
	pub type time_t = c_uint;
	pub type PULONG = *mut c_ulong;

	#[repr(C)]
	pub struct IP_ADDRESS_STRING {
		pub String: [CHAR; 16]
	}
	impl Copy for IP_ADDRESS_STRING {}
	impl Clone for IP_ADDRESS_STRING {
		#[inline]
		fn clone(&self) -> IP_ADDRESS_STRING { *self }
	}
	
	#[repr(C)]
	pub struct IP_MASK_STRING {
		pub String: [CHAR; 16]
	}
	impl Copy for IP_MASK_STRING {}
	impl Clone for IP_MASK_STRING {
		#[inline]
		fn clone(&self) -> IP_MASK_STRING { *self }
	}
	
	#[repr(C)]
	pub struct IP_ADDR_STRING {
		pub Next: PIP_ADDR_STRING,
		pub IpAddress: IP_ADDRESS_STRING,
		pub IpMask: IP_MASK_STRING,
		pub Context: DWORD
	}
	impl Copy for IP_ADDR_STRING {}
	impl Clone for IP_ADDR_STRING {
		#[inline]
		fn clone(&self) -> IP_ADDR_STRING { *self }
	}
	
	pub type PIP_ADDR_STRING = *mut IP_ADDR_STRING;
	
	#[repr(C)]
	pub struct IP_ADAPTER_INFO {
		pub next: PIP_ADAPTER_INFO,
		pub ComboIndex: DWORD,
		pub AdapterName: [CHAR; (MAX_ADAPTER_NAME_LENGTH + 4) as usize],
		pub Description: [CHAR; (MAX_ADAPTER_DESCRIPTION_LENGTH + 4) as usize],
		pub AddressLength: UINT,
		pub Address: [BYTE; MAX_ADAPTER_ADDRESS_LENGTH as usize],
		pub Index: DWORD,
		pub Type: UINT,
		pub DhcpEnabled: UINT,
		pub IpAddressList: IP_ADDR_STRING,
		pub GatewayList: IP_ADDR_STRING,
		pub DhcpServer: IP_ADDR_STRING,
		pub HaveWins: BOOL,
		pub PrimaryWinsServer: IP_ADDR_STRING,
		pub SecondaryWinsServer: IP_ADDR_STRING,
		pub LeaseObtained: time_t,
		pub LeaseExpires: time_t
	}
	
	pub type PIP_ADAPTER_INFO = *mut IP_ADAPTER_INFO;
	
	#[link(name = "Iphlpapi")]
	extern "stdcall" {
		pub fn GetAdaptersInfo(pAdapterInfo: PIP_ADAPTER_INFO, pOutBufLen: PULONG) -> DWORD;
	}
	
	pub const MAX_ADAPTER_NAME_LENGTH: u32 = 256;
	pub const MAX_ADAPTER_DESCRIPTION_LENGTH: u32 = 128;
	pub const MAX_ADAPTER_ADDRESS_LENGTH: u32 = 8;
	pub const ERROR_BUFFER_OVERFLOW: u32 = 111;
	pub const NO_ERROR: DWORD = 0;
}


const BAD_MAC_ADDRESSES: [[u8; 3]; 5] = [
	[ 0x00, 0x0C, 0x29 ],
	[ 0x00, 0x1C, 0x14 ],
	[ 0x00, 0x50, 0x56 ],
	[ 0x00, 0x05, 0x69 ],
	[ 0x08, 0x00, 0x27 ]
];

fn main() {
	let mut evidence_of_sandbox: bool = false;
	let mut out_buf_len = mem::size_of::<ffi::IP_ADAPTER_INFO>() as u32;
	let mut raw_adaptor_mem: Vec<u8> = Vec::with_capacity(out_buf_len as usize);
	let mut p_adaptor: *mut ffi::IP_ADAPTER_INFO;
	let mut res: ffi::DWORD;
	
	unsafe {
		res = ffi::GetAdaptersInfo(raw_adaptor_mem.as_mut_ptr() as *mut ffi::IP_ADAPTER_INFO, &mut out_buf_len);
	}
	if res == ffi::ERROR_BUFFER_OVERFLOW {
		raw_adaptor_mem = Vec::with_capacity(out_buf_len as usize);
		unsafe {
			res = ffi::GetAdaptersInfo(raw_adaptor_mem.as_mut_ptr() as *mut ffi::IP_ADAPTER_INFO, &mut out_buf_len);
		}
	}
	
	if res != ffi::NO_ERROR {
		println!("GetAdaptersInfo failed, exiting.");
		std::process::exit(1);
	}
	//Loop through all adopters, checking each mac address against each known bad address
	p_adaptor = unsafe { mem::transmute(&raw_adaptor_mem) };
	while p_adaptor as u64 != 0 {
		let address;
		let address_len;
		unsafe {
			address = (*p_adaptor).Address;
			address_len = (*p_adaptor).AddressLength;
		}
		for bad_mac_address in BAD_MAC_ADDRESSES.iter() {
			if address[0] == bad_mac_address[0] && address[1] == bad_mac_address[1] && address[2] == bad_mac_address[2] {
				for i in 0..address_len - 1 {
					print!("{:02X}:", address[i as usize]);
				}
				println!("{:02X}", address[address_len as usize]);
				evidence_of_sandbox = true;
			}
		}
		unsafe { p_adaptor = (*p_adaptor).next;	}
	}

	if !evidence_of_sandbox {
		println!("No MAC addresses match known virtual machine MAC addresses. Proceed!");
	}
}