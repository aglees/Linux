# Shell Functions
Can be used in the same way as functions in any other programming language.

> **Syntax:** function *function_name* { --code here-- }

Functions can also be used as an alias to your shell commands. For example, you can
add a function to your ```.bash_profile``` and use it as a command.

The following example builds on our previous shell script, replacing the usage generation
text with a function:
```
[root@localhost tmp]# cat myotherbashscript.sh
#!/bin/bash
function usage {
        echo "Usage: "$0 "your name"
}
if [[ $# -eq 0 ]]; then
        usage
        exit 1
fi
echo "Hello "$1
exit 0
```

We could also update our ```~/.bash_profile``` with a grepv function:

```
...
export PATH
function grepv {
        grep -v grep
}
```


> **Tip:** reload BASH profile by running:  
```. ~/.bash_profile```
