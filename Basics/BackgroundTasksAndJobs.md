# Background Tasks
A long running process or script can be set as a 
Background task by suffixing it with an ```&``` character:

```./infiniteloop.sh &```

A job will be created for that process/script, a list of which can be 
recalled via the ```jobs``` command.

```
[root@localhost tmp]# jobs
[1]+  Running                 ./infiniteloop.sh &
```

To bring a job to the foreground, the ```fg``` command can be used
in combination with the job number.
```
[root@localhost tmp]# fg %1
./infiniteloop.sh
```

At this point it is possible to stop process/script, or return it to the 
background
* ```^Z``` - return to Background
* ```^C``` - cancel / stop the process
