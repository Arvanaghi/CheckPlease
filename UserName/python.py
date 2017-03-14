import getpass
targeted_username = input("\n [>] What username should we validate is being used?")
user_name = getpass.getuser()
if targeted_username.lower() in user_name:
    # Run the rest of your code now
    pass
