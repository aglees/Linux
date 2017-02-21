# Head Command
Returns the top n-lines of a file. By default it 
returns 5 lines, but you can specify otherwise.

```
[root@localhost tmp]# head -2 output.txt
/var/log/audit/audit.log
/var/log/tuned/tuned.log
```
You can also have head return everything but the last 
n-lines of a file:
```
[root@localhost tmp]# head --lines=-3 output.txt
/var/log/audit/audit.log
/var/log/tuned/tuned.log
/var/log/yum.log
/var/log/anaconda/anaconda.log
/var/log/anaconda/anaconda.program.log
/var/log/anaconda/anaconda.packaging.log
/var/log/anaconda/anaconda.storage.log
```