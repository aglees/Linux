# About Shells
Different Linix systems have different default shells. The two
main shells are:
* **sh**: Bourne Shell
* **BASH**: Bourne Again Shell

```BASH``` is default for Red Hat and Ubuntu.

Other types include:
* **ksh**: Korn shells
* **csh**: C-shell

```csh``` is designed to make c-programmers feel at home. The commands
are very like regular c-syntax.

Very easy to change shells (type ```ksh``` to start Korn shell)

If the task at hand cannot be solved via shell commands, then 
languages like ```Perl``` & ```Python``` can be used. For example
connecting to a database, or other high-level functions.

# BASH shortcuts

* **ctrl + a:** go to start of line
* **ctrl + e:** go to end of line
* **ctrl + r:** start search of previous commands (history)

# VI Mode
Makes the command line like the VI editor with the same
editting commands and methods.

Press ```Esc``` to enter command mode, where you can input
navigational commands. When you want to enter text, press ```i```. You 
can use the following commands to interact with the CLI:

* **$**: goto the end of the current line
* **0**: jump to the start of the line
* **k**: bring the last command typed. Press again for earlier commands.
* **/**: searches the history for commands

Activated VI mode by:  
```set -o vi```

Return to normal:  
```set -o emacs```

# Process File Descriptors
In UNIX paradigm, a process communicates with the systems
using channels called file descriptors *(fd)*.

At least 3 channels are available to a given process:
* **Standard Input** *(STDIN)* from which the process accepts input. 
For example, the shell process typically accepts input from the keyboard.
It is numbered as 0.
* **Standard Output** *(STDOUT)*, to which the process directs any output
produced. It is numbered as 1.
* **Standard Error** *(STDERR)*, to which any error message are directed. It
is numbered as 2.

You can always examine the current fd's used by a process by listing
the files under the virtual directory ```/proc```. For example:

```ls -l /proc/45163/fd```

where 45163 is the process number.

### Get a list of processes
```
[root@localhost /]# ps -ef | more
...
root     34998     1  0 Feb14 ?        00:00:55 /usr/sbin/irqbalance --foreground
root     35103     1  0 Feb14 ?        00:00:10 /usr/bin/python -Es /usr/sbin/firewalld --nofork --nopid
root     35158     2  0 11:50 ?        00:00:00 [kworker/1:0]
root     35207     1  0 Feb14 ?        00:00:00 /usr/sbin/atd -f
chrony   35305     1  0 Feb14 ?        00:00:00 /usr/sbin/chronyd
avahi    35343     1  0 Feb14 ?        00:00:00 avahi-daemon: running [linux.local]
avahi    35344 35343  0 Feb14 ?        00:00:00 avahi-daemon: chroot helper
root     35375     2  0 13:48 ?        00:00:05 [kworker/0:0]
postfix  35403  1917  0 14:03 ?        00:00:00 pickup -l -t unix -u
root     35412     1  0 Feb14 ?        00:00:08 /sbin/rngd -f
root     35448     2  0 14:53 ?        00:00:00 [kworker/0:1]
root     35459     2  0 14:58 ?        00:00:00 [kworker/0:2]
root     35465 10701  0 14:59 pts/0    00:00:00 ps -ef
root     35466 10701  0 14:59 pts/0    00:00:00 more
...
```

Use the process id to get the file descriptors:

```
[root@localhost /]# ls -l  /proc/10666/fd
total 0
lrwx------. 1 root root 64 Feb 14 16:32 0 -> /dev/null
lrwx------. 1 root root 64 Feb 14 16:32 1 -> /dev/null
lrwx------. 1 root root 64 Feb 14 16:32 10 -> /dev/ptmx
lrwx------. 1 root root 64 Feb 14 16:32 11 -> /dev/ptmx
lrwx------. 1 root root 64 Feb 14 16:32 2 -> /dev/null
lrwx------. 1 root root 64 Feb 14 16:32 3 -> socket:[29548]
lrwx------. 1 root root 64 Feb 14 16:32 4 -> socket:[30388]
lr-x------. 1 root root 64 Feb 14 16:32 5 -> pipe:[30392]
l-wx------. 1 root root 64 Feb 14 16:32 6 -> /run/systemd/sessions/2.ref
l-wx------. 1 root root 64 Feb 14 16:32 7 -> pipe:[30392]
lrwx------. 1 root root 64 Feb 14 16:32 8 -> /dev/ptmx
```

## Communicating with File Descriptors
Redirect standard output and standard error to a file using
```>``` or ```>>``` (remember error fd is 2)
* **>**: clears the file before writing to to it.
* **>>**: appends the file.
* **&>**: directs both input and output to the same destination 
* **<**: instruct the process to take it's standard input from a file
* **|**: inject STDOUT of a command to the STDIN of another *(pipe)*

### Example redirect and append output
```
[root@localhost tmp]# echo "This is some text"
This is some text
[root@localhost tmp]# echo "This is some text" > temp.txt
[root@localhost tmp]# cat temp.txt
This is some text
[root@localhost tmp]# echo "This is some text" > temp.txt
[root@localhost tmp]# cat temp.txt
This is some text
[root@localhost tmp]# echo "This is some text" >> temp.txt
[root@localhost tmp]# cat temp.txt
This is some text
This is some text
```
### Example redirecting Standard Error output
 ```
 [root@localhost tmp]# useradd user1
[root@localhost tmp]# su - user1
[user1@localhost ~]$ find / -name core > output.txt 2>error.txt
[user1@localhost ~]$ ls
error.txt  output.txt
[user1@localhost ~]$ cat output.txt
/dev/core
/proc/sys/net/core
/usr/lib/python2.7/site-packages/firewall/core
/usr/lib/modules/3.10.0-123.el7.x86_64/kernel/drivers/infiniband/core
/usr/lib/modules/3.10.0-123.el7.x86_64/kernel/drivers/memstick/core
/usr/lib/modules/3.10.0-123.el7.x86_64/kernel/drivers/mmc/core
/usr/lib/modules/3.10.0-123.el7.x86_64/kernel/drivers/net/ethernet/mellanox/mlx5/core
 ...
 [user1@localhost ~]$
[user1@localhost ~]$ cat error.txt
find: ‘/boot/grub2’: Permission denied
find: ‘/proc/tty/driver’: Permission denied
find: ‘/proc/1/task/1/fd’: Permission denied
find: ‘/proc/1/task/1/fdinfo’: Permission denied
find: ‘/proc/1/task/1/ns’: Permission denied
find: ‘/proc/1/fd’: Permission denied
find: ‘/proc/1/fdinfo’: Permission denied
...
 ```
 ### Example of using Standard Input
 Here we send an internal mail to root, taking input from the
 ```output.txt``` file that we created in the last example.
 ```
 [user1@localhost ~]$ mail -s "output" root < output.txt
[user1@localhost ~]$ logout
You have mail in /var/spool/mail/root
[root@localhost /]# mail
Heirloom Mail version 12.5 7/5/10.  Type ? for help.
"/var/spool/mail/root": 1 message 1 new
>N  1 user1@localhost.loca  Mon Feb 20 15:21  55/2931  "output"
& 1
Message  1:
From user1@localhost.localdomain  Mon Feb 20 15:21:34 2017
Return-Path: <user1@localhost.localdomain>
X-Original-To: root
Delivered-To: root@localhost.localdomain
Date: Mon, 20 Feb 2017 15:21:34 +0000
To: root@localhost.localdomain
Subject: output
User-Agent: Heirloom mailx 12.5 7/5/10
Content-Type: text/plain; charset=us-ascii
From: user1@localhost.localdomain
Status: R

/dev/core
/proc/sys/net/core
/usr/lib/python2.7/site-packages/firewall/core
/usr/lib/modules/3.10.0-123.el7.x86_64/kernel/drivers/infiniband/core
/usr/lib/modules/3.10.0-123.el7.x86_64/kernel/drivers/memstick/core
/usr/lib/modules/3.10.0-123.el7.x86_64/kernel/drivers/mmc/core
/usr/lib/modules/3.10.0-123.el7.x86_64/kernel/drivers/net/ethernet/mellanox/mlx5/core
```
### Example of piping output
```
[root@localhost /]# ls -l | grep usr
lrwxrwxrwx.   1 root root    7 Feb 14 16:25 bin -> usr/bin
lrwxrwxrwx.   1 root root    7 Feb 14 16:25 lib -> usr/lib
lrwxrwxrwx.   1 root root    9 Feb 14 16:25 lib64 -> usr/lib64
lrwxrwxrwx.   1 root root    8 Feb 14 16:25 sbin -> usr/sbin
drwxr-xr-x.  13 root root 4096 Feb 14 16:25 usr
```
