# YUM Plugins
Used to add extra functionality to YUM. 

> **Tip:** In some 
distributions these plugins are installed by default.

* **Yum-fastestmirror**: makes yum automatically choose the fastest connection to a mirror.
The data is stored in ```/var/cache/yum/timeshosts.txt```. You force the yum to recheck fastest
connection by deleting this file.

```
[root@localhost /]# cat /var/cache/yum/x86_64/7/timedhosts.txt
mirrors.coreix.net 0.102313995361
anorien.csc.warwick.ac.uk 0.0563440322876
mirror.vorboss.net 0.101212024689
centos.serverspace.co.uk 0.0506360530853
repo.uk.bigstepcloud.com 0.0991518497467
mirror.as29550.net 0.102669000626
mirror.econdc.com 0.0775918960571
www.mirrorservice.org 0.104607105255
mirror.ox.ac.uk 0.105323076248
mirrors.melbourne.co.uk 0.106439113617
mirror.cov.ukservers.com 0.0562508106232
mirror.sov.uk.goscomb.net 0.101743936539
mirror.sax.uk.as61049.net 0.183039188385
mirror.mhd.uk.as44574.net 0.159641027451
mirrors.vooservers.com 0.10055398941
centos.mirroring.pulsant.co.uk 0.101631164551
mirrors.clouvider.net 0.0499181747437
```
* **Yum-security**: enables yum to use the ```--security``` command line argument, which makes yum
ignore any packages other than the security related ones.
* **Yum-presto**: decrease the download size when updating a package by downloading
only the changes between the installed and new one *(delta rpms)*.

