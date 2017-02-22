# Sort Command
```Sort``` lines of text given to it. You have to provide the
key column on which the sort operation is performed, and the type 
of sort: 
* numerical
* dictionary-based

Typical usage is as follows:

```sort -t, -k1,1 -n < sample.csv```

This sorts the lines of sample.csv in an integer based way, regarding 
the comma as a column delimiter, and the key column as 1. The key
column can be more than one so we must specify that it will take 
only one column by inserting a comma and providing an end value:

i.e. ```k1,1```

We could use ```-r``` to reverse the order, ```-u``` to print unique
values only, or ```-b``` to ignore leading spaces.

```Sort``` is usually combined with another filter command like
```cut``` or ```uniq```.  



