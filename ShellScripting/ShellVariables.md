# Shell Variables
Declare a variable like so:  
```{variable name}={assigned value}```  
e.g. USER=joe

* There must not be space between the = sign, the 
variable name and the assigned value
* Values should be enclosed in single quotes, especially
if they contain spaces

To call a variable, you prefix it with a ```$``` sign. You can
also add curly braces, so: ```${USER}```. This is recommended
if you are using the variable name with literal text.

e.g. ```${ORACLE_HOME}```/oraInventory

Enclosing the variable name in single quotes will prevent
the variable from being resolved.

e.g. ```'$HOME'``` will print $HOME, while ```"$HOME"``` will print 
the home directory path of the user.

You can add your *environment* variables in ```~/.bash_profile``` or 
```/.profile```

```
[root@localhost /]# cat ~/.bash_profile
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH
```

### Example of creating and echoing variables
```
[root@localhost /]# myvar=andrew
[root@localhost /]# echo $myvar
andrew
...
[root@localhost /]# myvar="This variable contains text"
[root@localhost /]# echo $myvar
This variable contains text
...
[root@localhost /]# echo $PATH
/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
```
### Example of using variables in variables
The variable ```$myvar``` will be resolved inside the ```$newvar```.
```
[root@localhost /]# myvar=andrew
[root@localhost /]# newvar="This variable contains text, and was written by $myvar"
[root@localhost /]#
[root@localhost /]# echo $newvar
This variable contains text, and was written by andrew
```

What is we using single-quotes, instead of double?
```
[root@localhost /]# newvar='This variable contains text, and was written by $myvar'
[root@localhost /]# echo $newvar
This variable contains text, and was written by $myvar
```
The variable ```$myvar``` has been treated as literal text!

