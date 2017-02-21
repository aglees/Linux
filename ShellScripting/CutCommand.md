# Cut Command
```Cut``` is an example of a filter command, which take ```STDIN```, perform
some processing on it before returning the result to ```STDOUT```.

```Cut``` is used to display parts of the input text. It is often
used with delimited files like csv, and /etc/passwd

> Tip: The default delimiter is the TAB character, but this can be 
changed using the ```-d``` command line argument.

To select the fields you want to display, use the ```-f``` option
followed by a comma separated list of numbers. 

e.g. ```cut -d , -f 1,3 < sample.csv``` will display fields 1 and 3, which are 
separated by a comma in a typical csv file.

The ```<``` sign is redundant here because ```cut``` accepts a file as 
its first argument. It is used i nthe example for demonstration purposes.

```
[root@localhost tmp]# cat sample.csv
Forename,Surname,Nationality
Andrew,Gleeson,British
Susanne,Moore,Australian
Giovanni,Beggio,Italian
...
[root@localhost tmp]# cut -d , -f 1,3 < sample.csv
Forename,Nationality
Andrew,British
Susanne,Australian
Giovanni,Italian
```

alternatively...
```
[root@localhost tmp]# cut sample.csv -d , -f 1,3
[root@localhost tmp]# cat sample.csv | cut -d , -f 1,3
```

