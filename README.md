# CheckPlease
**Payload-Agnostic Implant Security**

Written by Brandon Arvanaghi ([@arvanaghi](https://twitter.com/arvanaghi)) and Chris Truncer ([@ChrisTruncer](https://twitter.com/christruncer))

CheckPlease is the go-to repository for the newest targeted payload, sandbox-detection, and implant security modules. Each check is written in:

* PowerShell
* Python
* Go
* Ruby
* Perl
* C
* C#

Every module functions as a standalone "check." All checks can be run with command-line arguments, like so:

```
<module> <optional arguments>
```

This repository is for defenders to harden their sandboxes and AV tools, malware researchers to discover new techniques, and red teamers to get serious about their payloadds.

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

## Examples 

**PowerShell**: Confirm that the parent process of your payload was WinWord.exe:

```
PS arvanaghi: .\parent_process.ps1 WinWord
```
<img src="https://arvanaghi.com/hostedimages/parentprocess_ps.png" width="450">

**Python**: Make the user click 6 times before executing your payload to ensure it is not being run in an automated environment:

```
arvanaghi: python click_tracker.py 6
```

**Go**: Ensure user activity by making the user click a pop-up prompt before executing your payload:

```
arvanaghi: go run user_prompt.go "This is the box title" "This is the box message." 
```
<img src="https://arvanaghi.com/hostedimages/userpromptgo.gif" width="450">

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

## Why every language?

Payloads are more commonly being delivered in languages that are not C. In implementing in every language, we give sandbox and antivirus vendors a broader scope from which to detect. In your red teams, any payload you deliver can now be more targeted. 

## Contribute

I want you to **contribute** to this repository to make it truly comprehensive. If your implementation works, I will merge your modules into this repository within **one day**. 
