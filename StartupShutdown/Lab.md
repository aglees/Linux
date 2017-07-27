# LAB: creating a custom daemon with a startup script
* Write a script that prints the current date to a log file every second.
* Create a script that accepts ```start```, ```stop``` and ```restart``` command line arguments to start, stop and restart the script we just created.
* Add the required comment ```# chkconfig: 345 80 20```, where 345 is run levels 3, 4 and 5. 80 20 means that the start command will have the number 20 (```S20```), and 80 means that the kill command will have the number 80 (```K80```).
* Put this _**launcher**_ script in the ```/etc/init.d``` directory
* Use ```chkconfig``` to add this script to the respective ```rc``` directory.
* Use ```chkconfig``` to enable the script.
* Reboot the system to one of the configured run levels and ensure that the script has been launched.

# The Time script
```
#!/bin/bash
while true; do
        echo `date` >> /tmp/timed.log
        sleep 1
done
```

* This is stored as the ```/opt/timed```
* To make this script executable: ```sudo chmod +x /opt/timed```



# Setup the init.d script

```
#!/bin/bash
# chkconfig: 345 80 20
#
start() {
        nohup /opt/timed &
}
stop() {
        pkill timed
}
case "$1" in
        start)
                start
        ;;
        stop)
                stop
        ;;
        *)
                echo $"Usage: $0 {start|stop}"
                RETVAL=1
esac
exit 0
```
* to make this script executable: ```sudo chmod +x /etc/init.d/time```

## Comments
* ```start()``` : the start function.
* ```stop()``` : the stop function.
* ```nohup``` : runs the script in the background.
* ```case``` & ```esac```: start and end of the case structure
* ```$0``` : the name of the script


## So how does this run?
When we run this script without a parameter we get:
```
/etc/init.d/time
Usage: /etc/init.d/time {start|stop}
```

When we run with the ```start``` parameter we get:
```
/etc/init.d/time start
[.]$ nohup: appending output to ‘/home/ec2-user/nohup.out’
```

We can look for the running process
```
ps -ef | grep timed
ec2-user 17655     1  0 10:17 pts/0    00:00:00 /bin/bash /opt/timed
ec2-user 17707 11307  0 10:17 pts/0    00:00:00 grep --color=auto timed
```
 
We can kill the process as follows
```
/etc/init.d/time stop
```

And can verify that it has stopped:
```
ps -ef | grep timed
ec2-user 17959 11307  0 10:19 pts/0    00:00:00 grep --color=auto timed
```

We can add it to the start up scripts (and also check) with ```chkconfig```:
```
sudo chkconfig --add time
[.]$ sudo chkconfig --list | grep time
time            0:off   1:off   2:off   3:on    4:on    5:on    6:off
```

## How has this affected the init.d and rc files?
We can see that a Kill sequence of ```20``` has been applied to the shutdown run level.
```
[.]$ ls -l /etc/rc0.d/ | grep time
lrwxrwxrwx 1 root root 14 Jul 27 10:25 K20time -> ../init.d/time
```

Also, it's set to Start sequence of ```80``` 
```
[.]$ ls -l /etc/rc3.d/ | grep time
lrwxrwxrwx 1 root root 14 Jul 27 10:25 S80time -> ../init.d/time
```

When we reboot the system the script starts running 
```
[.]$ ps -ef | grep timed
root      2718     1  0 10:33 ?        00:00:00 /bin/bash /opt/timed
ec2-user  2944  2892  0 10:34 pts/0    00:00:00 grep --color=auto timed
```