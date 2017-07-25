# Looping Structures
## For..In Loops
BASH provides ```for...in``` loops for iterating over a group
of values and perform some commands on each.

It can also accept a group of files by using *globing*, which means using an 
asterisk ```*``` or a question mark ```?``` to find files by parts of their names.

For example:  
```
for f in *.log; do
    gzip $files
done
```

The loop starts with the keyword ```for``` followed by the iterator (the variable
to which each value will get assigned), then a list of values or a globed file name.
The a semi-colon ```;```, and the keyword ```do``` are added. After writing the code 
for the loop, you have to close it by adding ```done``` to its end.

A loop can also work on a list of values separated by a space like:
```
for i in user1 user2 user3; do
    echo $i
done
```
## *Classic* For Loop
The classic For Loop is available in BASH with some slight modifications.
The syntax is as follows:
```
for (( i=0; i<$count; i++ )); do
    echo $in
done
```
The loop starts with a ```for``` keyword, followed by double brackets ```((```
in which the loop parameters are entered:
* the iterator - ```i```
* the condition that makes the loop continue as long as it's true - ```i < $count```
* the statemen that increments the iterator - ```i++```  

Notice that ```i``` is not preceded by a ```$``` in the loop definition?

The loop body is terminated by the ```done``` keyword.

## While Loops
The while loop will continue to iterate as long as a specific condition is met.
It is often used in reading strings such as user input or a text file.
The syntax of a while loop is as follows:
```
while [[ condition ]]; do
    code here
done
```
Sometimes you need to make infinite loops. This is typically done in daemons that work in the 
background, listening for an event and acting accordingly. In such a case, you can use a while
loop as follows:
```
while true; do
    code here
    sleep n seconds
done
```
In the above example, you don't care about the loop condition because you want it to work "continuously".
But it's good practice to put a sleep statement at the end of each iteration so that you don't exhaust your
machine resources.

### User Input example
The following example will exit the while loop with correct user input.
```
#!/bin/bash
input=""
while [[ $input != 'Y' ]]; do
        echo -n "Please enter Y to continue "
        read input
done
```
### Infinite Loop example
This example writes a timestamp to a file. Note the use of ``` ` ``` characters to wrap the ```date``` 
command. This allows ```date``` to run and the result to be echoed 
```
#!/bin/bash
while true; do
        echo `date` >> timestamps.text
        sleep 1
done
```