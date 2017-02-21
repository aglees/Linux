# Tail Command
Tail prints the last 10 lines of a file by default. 
It has the following useful command line options:
* ```--lines=n``` prints the last n lines in a file
* ```--lines+n``` prints all lines in a file starting with line 
number number
* ```-f``` will keep the file open, displaying any new lines as
they are written. Typically used with log files.
* ```--pid=PID``` makes the command exit after the process which
is writing to the file you're tailing exits. Useful so that you know 
if the process has exited or it's just not writing any output at the
current moment.

> Tip: tail --lines=+n can be useful when combined with the 
sort command

```
[root@localhost tmp]# tail --lines=+2 sample.csv | sort -n  -k 1,1 -t ,

1,Giovanni,Beggio,Italian
1,Giovanni,Beggio,Italian
1,Giovanni,Beggio,Italian
2,Andrew,Gleeson,British
2,Andrew,Gleeson,British
2,Andrew,Gleeson,British
3,Susanne,Moore,Australian
3,Susanne,Moore,Australian
3,Susanne,Moore,Australian
```
Tail -f can also be useful for watching the system log:
```
[root@localhost tmp]# tail -f /var/log/messages
Feb 21 21:35:48 localhost dbus[758]: [system] Successfully activated service 'org.freedesktop.problems'
Feb 21 21:40:01 localhost systemd: Started Session 1227 of user root.
Feb 21 21:40:01 localhost systemd: Starting Session 1227 of user root.
Feb 21 21:50:01 localhost systemd: Started Session 1228 of user root.
Feb 21 21:50:01 localhost systemd: Starting Session 1228 of user root.
Feb 21 22:00:01 localhost systemd: Started Session 1229 of user root.
Feb 21 22:00:01 localhost systemd: Starting Session 1229 of user root.
Feb 21 22:01:01 localhost systemd: Started Session 1230 of user root.
Feb 21 22:01:01 localhost systemd: Starting Session 1230 of user root.
Feb 21 22:05:18 localhost root: hello
```