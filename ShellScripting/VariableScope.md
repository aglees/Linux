# Variable Scope
Variables are **global by default**; they can be accessed anywhere
in the code. But a function can make variables accessibility limited
to their own scope by using the keyword ```local```.

For example:

* ```$a``` is a global variable
* ```local a``` is a local variable

It's good practice to use local variables, and only globals where required.

The variable retains its original value as soon as code execution leaves
the function where the variable was created as local.

## Example
Here's a small example of global, local and assigning a global as a local.
```
[root@localhost tmp]# cat variable_scope.sh
#!/bin/bash
myvar="Andrew"
echo $myvar
function process {
        local myvar
        myvar="Andrew Gleeson as Local"
        echo "Inside the function: "$myvar
}
process
[root@localhost tmp]#
```
#### Output
```
[root@localhost tmp]# ./variable_scope.sh
Andrew
Inside the function: Andrew Gleeson as Local
```