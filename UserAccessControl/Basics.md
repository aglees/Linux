# The "ownership" concept
* Linux regards files and processes as _**objects**_
* Objects have owners. Owners have _almost_ unrestricted control over their own objects.
* The ```root``` account is the system administrator's. It can take ownership of any object.
* Processes control the access to themselves internally. For example, the ```passwd``` command will allow a non-root user to change his own account. But it won't let him reset another user's password.
* Filesystems control access to files and directories. Filesystems are the only object type that implements the concept of _**"groups"**_.
* Groups can contain a number of users. If the group has some permissions on a file or directory, all group members have this same privilege.
