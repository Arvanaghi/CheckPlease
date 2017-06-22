/*
    Filepath existence checker, C#
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

using System;
using System.IO;
using System.Collections.Generic;

namespace FilePath_Existence {
  class Program {
    static void Main(string[] args) {
      List<string> EvidenceOfSandbox = new List<string>();
      string[] FilePaths = {@"C:\windows\Sysnative\Drivers\Vmmouse.sys",
        @"C:\windows\Sysnative\Drivers\vm3dgl.dll", @"C:\windows\Sysnative\Drivers\vmdum.dll",
        @"C:\windows\Sysnative\Drivers\vm3dver.dll", @"C:\windows\Sysnative\Drivers\vmtray.dll",
        @"C:\windows\Sysnative\Drivers\vmci.sys", @"C:\windows\Sysnative\Drivers\vmusbmouse.sys",
        @"C:\windows\Sysnative\Drivers\vmx_svga.sys", @"C:\windows\Sysnative\Drivers\vmxnet.sys",
        @"C:\windows\Sysnative\Drivers\VMToolsHook.dll", @"C:\windows\Sysnative\Drivers\vmhgfs.dll",
        @"C:\windows\Sysnative\Drivers\vmmousever.dll", @"C:\windows\Sysnative\Drivers\vmGuestLib.dll",
        @"C:\windows\Sysnative\Drivers\VmGuestLibJava.dll", @"C:\windows\Sysnative\Drivers\vmscsi.sys",
        @"C:\windows\Sysnative\Drivers\VBoxMouse.sys", @"C:\windows\Sysnative\Drivers\VBoxGuest.sys",
        @"C:\windows\Sysnative\Drivers\VBoxSF.sys", @"C:\windows\Sysnative\Drivers\VBoxVideo.sys",
        @"C:\windows\Sysnative\vboxdisp.dll", @"C:\windows\Sysnative\vboxhook.dll",
        @"C:\windows\Sysnative\vboxmrxnp.dll", @"C:\windows\Sysnative\vboxogl.dll",
        @"C:\windows\Sysnative\vboxoglarrayspu.dll", @"C:\windows\Sysnative\vboxoglcrutil.dll",
        @"C:\windows\Sysnative\vboxoglerrorspu.dll", @"C:\windows\Sysnative\vboxoglfeedbackspu.dll",
        @"C:\windows\Sysnative\vboxoglpackspu.dll", @"C:\windows\Sysnative\vboxoglpassthroughspu.dll",
        @"C:\windows\Sysnative\vboxservice.exe", @"C:\windows\Sysnative\vboxtray.exe",
        @"C:\windows\Sysnative\VBoxControl.exe"};
      foreach (string FilePath in FilePaths) {
        if (File.Exists(FilePath)) {
          EvidenceOfSandbox.Add(FilePath);
        }
      }

      if (EvidenceOfSandbox.Count == 0) {
        Console.WriteLine("Proceed!");
        Console.ReadKey();
      } else {
        Console.Write(string.Join(", ", EvidenceOfSandbox));
        Console.ReadKey();
      }
    }
  }
}