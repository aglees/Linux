# Tee Command
Redirects command output to screen as well as to
a file.

Example
```
[root@localhost tmp]# find / -name "*.log" | tee output.txt
/var/log/audit/audit.log
/var/log/tuned/tuned.log
/var/log/yum.log
/var/log/anaconda/anaconda.log
/var/log/anaconda/anaconda.program.log
/var/log/anaconda/anaconda.packaging.log
/var/log/anaconda/anaconda.storage.log
/var/log/anaconda/anaconda.ifcfg.log
...
[root@localhost tmp]# cat output.txt
/var/log/audit/audit.log
/var/log/tuned/tuned.log
/var/log/yum.log
/var/log/anaconda/anaconda.log
...
```
