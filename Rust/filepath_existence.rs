/*
	Filepath existence checker, Rust
	Module written by Sam Brown
	Website: https://samdb.xyz
	Twitter: @_samdb_
*/

use std::path::Path;

const PATHS: [& 'static str; 32] = [ "C:\\windows\\Sysnative\\Drivers\\Vmmouse.sys",
		"C:\\windows\\Sysnative\\Drivers\\vm3dgl.dll", "C:\\windows\\Sysnative\\Drivers\\vmdum.dll",
		"C:\\windows\\Sysnative\\Drivers\\vm3dver.dll", "C:\\windows\\Sysnative\\Drivers\\vmtray.dll",
		"C:\\windows\\Sysnative\\Drivers\\vmci.sys", "C:\\windows\\Sysnative\\Drivers\\vmusbmouse.sys",
		"C:\\windows\\Sysnative\\Drivers\\vmx_svga.sys", "C:\\windows\\Sysnative\\Drivers\\vmxnet.sys",
		"C:\\windows\\Sysnative\\Drivers\\VMToolsHook.dll", "C:\\windows\\Sysnative\\Drivers\\vmhgfs.dll",
		"C:\\windows\\Sysnative\\Drivers\\vmmousever.dll", "C:\\windows\\Sysnative\\Drivers\\vmGuestLib.dll",
		"C:\\windows\\Sysnative\\Drivers\\VmGuestLibJava.dll", "C:\\windows\\Sysnative\\Drivers\\vmscsi.sys",
		"C:\\windows\\Sysnative\\Drivers\\VBoxMouse.sys", "C:\\windows\\Sysnative\\Drivers\\VBoxGuest.sys",
		"C:\\windows\\Sysnative\\Drivers\\VBoxSF.sys", "C:\\windows\\Sysnative\\Drivers\\VBoxVideo.sys",
		"C:\\windows\\Sysnative\\vboxdisp.dll", "C:\\windows\\Sysnative\\vboxhook.dll",
		"C:\\windows\\Sysnative\\vboxmrxnp.dll", "C:\\windows\\Sysnative\\vboxogl.dll",
		"C:\\windows\\Sysnative\\vboxoglarrayspu.dll", "C:\\windows\\Sysnative\\vboxoglcrutil.dll",
		"C:\\windows\\Sysnative\\vboxoglerrorspu.dll", "C:\\windows\\Sysnative\\vboxoglfeedbackspu.dll",
		"C:\\windows\\Sysnative\\vboxoglpackspu.dll", "C:\\windows\\Sysnative\\vboxoglpassthroughspu.dll",
		"C:\\windows\\Sysnative\\vboxservice.exe", "C:\\windows\\Sysnative\\vboxtray.exe",
		"C:\\windows\\Sysnative\\VBoxControl.exe"];


fn main(){
	let mut count = 0;
	for path in PATHS.iter() {
		if Path::new(path).exists(){
			println!("{}", path);
			count += 1;
		}
	}
	
	if count == 0 {
		println!("No files exist on disk that suggest we are running in a sandbox. Proceed!");
	}
	
	
}