# Package Mangement
## Manual Compilation
Compiling using ```./configure``` and ```make install```

This is more error prone, complex and difficult.  

The user gets ```.tar.gz``` files, and needs to uncompress and 
then manually compile them.

> Tip: There is a risk of overwriting existing system configuration files, 
like ```ntp.conf``` configuration files when manually compiling applications.

### Uninstalling Manually Compiled Packages
Uninstalling applications is a pain, as there is no 
automatic way of removing all installed files and reverting configuration.

## Pre-packed packages
- ```.rpm``` for RedHat and SUSE
- ```.deb``` for Debian and Ubuntu

Multiple packages can be wrapped inside a single package for 
complex installations 

> Tip: Dependencies are considered with pre-packed packages

System files are respected, with .new files written. 
It is up to the user to merge the two.

### RedHat RPM Commands
The ```rpm``` command does not handle dependencies.
It cannot search for packages either. For example
VI cannot be installed with installing dependencies 
first.

```rpm -i {package name}``` - install a package   
```rpm -u {package name}``` - update a package  
```rpm -e``` - erase (uninstall) a package  
```rpm -q``` - query. Must be combined with another option.

> Tip: query all packages on a system with 
```rpm -qa | grep {package name}``` 

### Debian DEB Installation
The ```dpkg``` command does not handle dependencies.
It cannot search for packages either. So very similar
to ```rpm```.

```dpkg -install``` - installs a package  
```dpkg -remove``` - uninstall a package  
```dpkg -l``` - list installed packages  

> Tip: list all installed packages with ```dkpg -l | grep {package name}```

## Linux  Package Management Systems
Because of the above drawbacks there are a number of 
advanced package managers to take up the slack.
* **YUM** - Yellow Dog Updater, Modified - RedHat
* **APT** - Advanced Package Tool = Debian
* **ZYpper** - SUSE

The repositories contain metadata on each package. This is how
dependencies are learned.

Each vendor offers it's own repo. RedHat offers the RedHat Network
(paid), Centos and Oracle Linux have their own repos too.

Packages are offered via HTTP or FTP.

```yum``` or ```apt-get``` install for RedHat and Ubuntu respectively.
This will handle searching and downloading the package and the
dependencies. 

### apt-get 
```apt-get update``` - updates the cache of the local system 
with metadata from the repositories.

```/etc/apt/sources.list``` - file with URLS for repos

### common apt-get repo
Use a local common repo to save bandwidth.
Install ```apt-mirror``` with:  

```apt-get install apt-mirror```

The configuration file is ```/etc/apt/mirror.list```

Initial config with ```apt-mirror```. THe first run will
take a while because of the amount of data to download.
Subsequent runs will be quicker, and can be automated with 
```cron```.

Packages are downloaded to ```/var/spool/apt-mirror```, so 
you should ensure you have atleast **50 GB** free. 
The path can be changed with the configuration file.

Obselete packages can be deleted by running:
```/var/spool/apt-mirror/var/clean.sh```

To make the repo usable just make it reachable via **HTTP** 
or **FTP**. Make a symbolic link from your website directory
to the packages directory. Clients will have to change their
```sources.list``` files to point to the new repo.

1. ```cd /var/www/html```
2. ```sudo ln -s {path to repo folder}```

### Running apt-get unattended
Can automate system updates using ```cron```. It is good 
practice to run ```apt-get update``` befor attempting to
run the update to ensure you have the latest data.

## Red Hat yum
Configuration file is located ```/etc/yum.conf``` 
while the repositories are in ```/etc/yum.conf.d/```

- ```yum update```
- ```yum install```
- ```yum remove```

auto-confirmation by using `-y`

> Tip: you can use ```*``` for wild card matching of 
package names. For example ```yum install http``` will not work,
but ```yum install http*``` will install ```httpd``` for you.

### Making a local yum repo
THis can be done by speciying a file:/// URL that points
to the mounted filesystem of the DVD

If needed this can be further extended to serve other 
systems on the same network from the same DVD in the
interest of saving time. Just use a symbolic link in the 
web directory that points to the mounted DVD filesystem, and 
update the appropriate client repo configuration to point to it.






