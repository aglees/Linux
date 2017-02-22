# Basics of BASH scripting
All the commands that you write in the BASH shell can be put in a file
called a shell script to automate them.

You can comment any line of code in a BASH script by adding a ```#``` at the start 
of the line.

Multiple commands can be added to the same line by separating them with a ```;```

If you want the script to be self-executable, you must add the interpreter at the first
line of the script. For example ```#!/bin/bash```. This is referred to as a **shebang**. Otherwise
the script will only run if you precede the file with the interpreter. 

For example: 
```
sh script.sh 
bash script.sh
```

The file extension has no effect on execution. Adding ```.sh``` to the end of scripts is good practice, though, 
to easily identify a file without having to open it.


> Tip: Make a script self-executable with:
```chmod +x {name of script}```

The reason why is that executables, by default, are only allowed from programs in the $PATH varaible. 
We therefore have to inform the system, through ```chmod``` that the file can be run.



