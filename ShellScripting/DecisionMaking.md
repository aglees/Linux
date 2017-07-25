# Decision Making
If statements are important. The syntax is quite particular too
> **Syntax:**  
 if [ --test goes here-- ]; then   
{ --code goes here-- }  
else  
{ --code goes here-- }  
fi

* spaces must be included before and after the square brackets
* the semi-colon after the trailing square bracket is only needed if ```then``` is on the 
same line. Else a carriage return will suffice.
* ```elif``` statements can be added in addition to ```else```.
* the ```if``` block must end with ```fi```. 

# Operators
## Basic operators 
```=``` means "equal to" for strings   
```-eq``` means "equal to" for numbers  
```!=``` means "not equal to" for strings  
```-ne``` means "not equal to" for numbers  
```-gt``` means "greater than"  
```-lt``` means "less than"  
```-gte``` means "greater than or equal to"  
```-lte``` means "less than or equal to"  

## Advanced operators 
```-n``` means "string is non-zero length"  
```-z``` means "string is zero length"  
```-d``` means "directory exists"  
```-e``` means "file exists"  
```-f``` means "file exists, and regular" (not a block device)   
```-r``` means "file is readable"  
```-s``` means "file is not empty"  
```-w``` means "file is writable"  

## AND & OR
It is possible to chain expressions with 

```-a``` as the AND operator  
```-o``` as the OR operator

> **Tip:** ```man test``` has more examples of operators.

> **Extra Info:** ```[ ]``` is actually a shortcut for the ```/bin/test``` function

## Example
This script relies on the command ```id -u``` to return the id of the calling user.
```
id=`id -u`
if [ $id -eq 0 ]; then
    echo "This script cannot run as root"
else
    echo "Welcome to our script"
fi
```
#### Output
Run as ```root```:
```
[root@localhost tmp]# ./if_statement.sh
This script cannot run as root
```

Run as ```user1```:
```
[user1@localhost tmp]$ ./if_statement.sh
Welcome to our script
[user1@localhost tmp]$
```