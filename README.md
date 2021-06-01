# CheckPlease
**Implant-Security Modules in PowerShell, Python, Go, Ruby, Perl, C, C#, VBS, and Rust.**

Written by Brandon Arvanaghi ([@arvanaghi](https://twitter.com/arvanaghi)) and Chris Truncer ([@christruncer](https://twitter.com/christruncer))

[Slides](https://www.slideshare.net/BrandonArvanaghi/checkplease-payloadagnostic-implant-security) from BSides Las Vegas 2017.

CheckPlease is the go-to repository for the newest implant security modules. Every module functions as a standalone "check." All checks can be run with command-line arguments, like so:

```
<module> <optional arguments>
```

This repository is for defenders to harden their sandboxes and AV tools, malware researchers to discover new techniques, and red teamers to get serious about their payloads. 

For an explanation of every cheeck in this repository, see the [CheckPlease wiki](https://github.com/Arvanaghi/CheckPlease/wiki).

## Examples 

**PowerShell**: Ensure user activity by making the user click a pop-up prompt before executing your payload:
```
.\user_prompt.ps1 "Security Update" "Your system has been updated successfully."
```
<img src="https://arvanaghi.com/hostedimages/userprompt.gif" width="450">

**PowerShell**: Confirm that the parent process of your payload was WinWord.exe:

```
PS arvanaghi: .\parent_process.ps1 WinWord
```
<img src="https://arvanaghi.com/hostedimages/parentprocess_ps.png" width="450">

**Python**: Make the user click 6 times before executing your payload to ensure it is not being run in an automated environment:

```
arvanaghi: python click_tracker.py 6
```

**Go**: Ensure the Registry on the target system is at least 60 MB in size:

```
arvanaghi: go run registry_size.go 60 
```

**Ruby**: Only execute the payload if running as a specific user:

```
arvanaghi: ruby username.rb "Chris Truncer"
```
<img src="https://arvanaghi.com/hostedimages/usernamerb.png" width="450">

**Perl**: Make your payload execute on a certain date.

```
arvanaghi: perl date_trigger.pl 09/20/2017
```

You know how to run **C** and **C#** code.

## Adding to your code

Take the checks in the repository and add them to your own custom code. Add the checks you want into nested `if` statements. You can, and should, chain more than one together. If the system passes all your checks, your payload will execute. 

**Example:** ensuring the username is as expected, and the time zone is not UTC:

```
import getpass
import time

expectedUserName = " ".join(sys.argv[1:]).lower()

if getpass.getuser().lower() == expectedUserName:
  if time.tzname[0] != "Coordinated Universal Time" and time.tzname[1] != "Coordinated Universal Time":
    # Your code goes here. If it passed all checks, it will run!
```

## Why every language?

Payloads are more commonly being delivered in languages that are not C. In implementing in every language, we give sandbox and antivirus vendors a broader scope from which to detect. In your red teams, any payload you deliver can now be more targeted. 

## Contribute

We encourage contributions to this repository. To make it truly comprehensive, we want the newest techniques added to this repository as soon as possible. If you submit a merge request, I will get it tested within a week.  
