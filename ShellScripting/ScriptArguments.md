# Script Arguments
You can add command line arguments to scripts. They are internally interpretted
by BASH as ```$1```, ```$2```, for the 1st and 2nd arguments, and so on and so on.

There are special variables which can be useful:
* ```$0``` - holds the name of the script
* ```$#``` - contains the number of arguments passed to the script
* ```$*``` - contains all arguments passed at once

The command line argument variables with the special ones can be used to test whether or 
not the user has supplied the correct input, and take according action.

### Example of command line arguments with checking
```
[root@localhost tmp]# cat myotherbashscript.sh
#!/bin/bash
if [[ $# -eq 0 ]]; then
        echo "Usage: "$0 "your name"
        exit 1
fi
echo "Hello "$1
exit 0
```
Exit codes can be used to determine where the script exited, which is very useful when
debugging. 

#### Output
```
[root@localhost tmp]# ./myotherbashscript.sh
Usage: ./myotherbashscript.sh your name

[root@localhost tmp]# ./myotherbashscript.sh "Andrew Gleeson"
Hello Andrew Gleeson
```