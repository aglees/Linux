# The "ownership" concept
* Linux regards files and processes as _**objects**_
* Objects have owners. Owners have _almost_ unrestricted control over their own objects.
* The ```root``` account is the system administrator's. It can take ownership of any object.
* Processes control the access to themselves internally. For example, the ```passwd``` command will allow a non-root user to change his own account. But it won't let him reset another user's password.
* Filesystems control access to files and directories. Filesystems are the only object type that implements the concept of _**"groups"**_.
* Groups can contain a number of users. If the group has some permissions on a file or directory, all group members have this same privilege.

# Filesystem security model overview
* ```Users``` and ```Groups``` own files and directories.
* Only the owner user can change the permissions of his own file and directory.
* The filesystem views users and groups as number rather than textual names. For example, ```root``` is identified by the ```UID``` of ```0```, while ```wheel``` group is identified by ```GID 10```.
* When an access attempt occurs from a user or a group, the filesystem will use the ```UID``` and/or the ```GID``` to grant or deny access.
* ```UID```'s and ```GUI```'s are stored in ```/etc/passwd``` and ```/etc/group``` respectively. When a command like ```ls -l``` is used to display ownership information, those files (or the appropriate user database) will be consulted to display a human-friendly name rather than the id.
* You can use the ```id``` command to display your own ```UID```, and ```id -g``` to display the group.

# Process security model overview
* Any process owner can send signals to it (like ```kill -9``` for example). He can also increase it's nice value. That is, decrease it's priority on CPU using the ```renice``` command.
* When a process or a command runs in Linux, it has the following user and group id's:
    * _**Real**_: the account of the owner of the process. It is what defines which files and directories that this process can have access to, and the type of this access.
    * _**Effective**_: normally, this is the same as the real id's. But sometimes it is changed to enable a non-privileged user to access files that can be only access by root. For example, the ```passwd``` command when run by a normal user to change his own password, the effective id becomes ```0``` to enable the user to make changes to ```/etc/shadow``` file. The process will check the real id of the user to grant or deny access accordingly.
    * _**Saved**_: it is used when a process is running with an elevated privilege needs to do some work - temporarily - as a non-privileged account. In this case, it saves the privileged id to the ```suid``` so that can use it back as its effective id

# The power of root
* The ```root``` account has the ```id``` of ```0```
* A process with the id of ```0``` can do any operations on any other file or process
* In addition, some tasks can only be performed by the root account like:
    * Setting the machine's hostname or IP address
    * Changing the system's date and time
    * Open network sockets on privileged ports (below port 1024)
* The ```UID 0``` process can even change it's own ```UID``` and ```GID```. This happens when a normal user logs into the system. The login process changes it's ```UID``` and ```GID``` to those of the user. This change cannot be rolled back.

# Should I login as root?
* The short answer is "no", it's not a good idea for the following reasons:
    * You lose the user accountability: who did what. and when.
    * You give a hacker one step forward: instead  of having to break a normal user's password first, then the root password, you leave them with only one password to crack: _the root one_.
    * Most administrators do not apply password locking on root passwords, because this may completely lock the system, with no direct solution to unlock the root account. This gives the intruder all the time needed to try and guess the password through trial and error.
* The recommended approach is to give administrators normal, unprivileged accounts. When the root power is needed, they either ```su``` to root, or use the ```sudo``` command.

# Using the SU command
* The ```su``` command is short for _**substitute user**_.
* You can use it to change your current login session to a different user session or to ```root```. Provided that you have the appropriate password.
* ```root``` can ```su``` to any user without specifying the password.
* It has two forms:
    * ```su user``` : does not load the user's environment.
    * ```su - user``` : loads the user's environment.
* You will remain in the alternate user session until you type ```exit``` or press ```CTRL+D```. 

# Delegating root powers with sudo
* The ```sudo``` command is used to specify specific commands to be run as another user, typically as ```root```.
* The usage syntax is as follows: ```sudo command``` for ```root``` and ```sudo -u``` and ```sudo -g``` for running the command as the user or group respectively.
* In or