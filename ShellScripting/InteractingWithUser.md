# Printf vs Echo

Best illustrated by example:

```
[root@localhost tmp]# printf "hello\n"
hello

[root@localhost tmp]# echo  "hello\n"
hello\n
```

There are two command line options for ```echo```:
* ```-n```: do not add new line characters to end of the line 
* ```-e```: which respects new line and tab special characters

```
[root@localhost tmp]# echo -n  "hello"
hello[root@localhost tmp]#

[root@localhost tmp]# echo -e  "hello\n"
hello

[root@localhost tmp]# echo -e "This\tis\ttabbed\n"
This    is      tabbed
```
# Read
Here is a small script that gets user input, and echos it back to the 
user. Notice that ```-n``` allows the user to input data on the same line.
```
[root@localhost tmp]# cat mybashscript.sh
#!/bin/bash
# this is a comment
echo -n "Please enter your name: "
read user_name
echo "hello "$user_name
```
##### Ouput:
```
[root@localhost tmp]# ./mybashscript.sh
Please enter your name: Andrew
hello Andrew
```

