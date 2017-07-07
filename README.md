# CheckPlease
## Targeted payloads in every language. 

CheckPlease is the go-to repository for the newest targeted payload and sandbox-detection modules. Written by Brandon Arvanaghi ([@arvanaghi](https://twitter.com/arvanaghi)) and Chris Truncer ([@ChrisTruncer](https://twitter.com/christruncer))

Every module functions as a standalone "check." All checks can be run with command-line arguments, like so:

```
<module> <optional arguments>
```

This repository is for defenders to harden their sandboxes and AV tools, malware researchers to discover new techniques, and red teamers to get serious about their paylaods.

I want you to **contribute** to this repository to make it truly comprehensive. If your implementation works, I will merge your modules into this repository within **one day**. 

## Examples 

**PowerShell**: Confirm that the parent process of your payload was WinWord.exe:

```
PS arvanaghi: .\parent_process.ps1 WinWord
```

**Python**: Make the user click 6 times before executing your payload to ensure it is not being run in an automated environment:

```
arvanaghi: python click_tracker.py 6
```

**Go**: Ensure user activity by making the user click a pop-up prompt before executing your payload:

```
arvanaghi: go run user_prompt.go "This is the box title" "This is the box message." 
```

**Ruby**: Only execute the payload if running as a specific user:

```
arvanaghi: ruby username.rb "Chris Truncer"
```

**Perl**: Make your payload execute on a certain date.

```
arvanaghi: perl date_trigger.pl 09/20/2017
```

You know how to run **C** and **C#** code.

## Why every language?

Payloads are more commonly being delivered in languages that are not C. In implementing in every language, we give sandbox and antivirus vendors a broader scope from which to detect. In your red teams, any payload you deliver can now be more targeted. 

## Adding to your code

Another way to use CheckPlease is to take the checks that are currently in the repository and add them to your own custom code. You can easily just copy and paste the check itself (along with any required libraries) and use the if-else check to determine if your real code should run. On top of this, you also have the ability to chain more than one check together. This could/would require that all checks must pass prior to your real code running. For example:

```
import getpass
import os

if getpass.getuser().lower() == " ".join(sys.argv[1:]).lower():
    if os.environ['COMPUTERNAME'].lower() == " ".join(sys.argv[1:]).lower():
        <INSERT REAL CODE HERE>
```
