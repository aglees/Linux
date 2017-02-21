# Grep Command
Searches for text in its standard input and outputs it.
You can use regular expressions in pattern matching.

It has the following useful options:
* -c get the number of matches instead of printing them
* -i ignore case when searching
* -v text: matches if the text is not present
* -l print the file names containing the matched text
* -R performs a recursive search, that is, in the current
directory and all subdirectories

## Examples
Find errors in files in /var/log
```
[root@localhost log]# grep -R error
tuned/tuned.log:2014-10-29 16:42:11,917 ERROR    tuned.utils.commands: Executing x86_energy_perf_policy error:
tuned/tuned.log:2014-10-29 16:42:12,233 ERROR    tuned.utils.commands: Executing cpupower error: analyzing CPU 0:
tuned/tuned.log:2014-10-29 16:42:12,234 ERROR    tuned.utils.commands: Reading /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors error: [Errno 2] No such file or directory: u'/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors'
tuned/tuned.log:2017-02-14 16:16:12,472 ERROR    tuned.utils.commands: Executing cpupower error: analyzing CPU 0:
tuned/tuned.log:2017-02-14 16:16:12,472 ERROR    tuned.utils.commands: Reading /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors error: [Errno 2] No such file or directory: u'/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors'
```
Find files with error mentioned in /var/log
```
[root@localhost log]# grep -R -l  error
tuned/tuned.log
anaconda/syslog
anaconda/anaconda.program.log
anaconda/anaconda.packaging.log
boot.log
dmesg.old
dmesg
messages-20170219
```
Find those ssh processes, but don't include the process with grep
running.
```
[root@localhost log]# ps -ef | grep ssh | grep -v grep
root     10666     1  0 Feb14 ?        00:00:03 sshd: root@pts/0
root     34672     1  0 Feb14 ?        00:00:00 /usr/sbin/sshd
root     37869 34672  0 21:35 ?        00:00:00 sshd: root@pts/1
```
