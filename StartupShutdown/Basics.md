# Bootstrapping
## What is 'bootstrapping'?
* The process by which the system initializes until it is available to users
* During bootstrapping the kernel is loading into memory, and starts execution. It is the program that allows you to interface with your hardware.
* Any startup script is executed during this process. Stuff like the various daemons like DHCP, SSH etc
* The following are some causes that will prevent the bootstrapping process from completely successfully:
    * Error in one of the configuration files like ```/etc/fstab```
    * Damaged hardware
    * Filesystem corruption

## What is ```/etc/fstab``` ?
It's the file responsible for mounting the file systems during the startup process. An incorrect character here will stop the system from booting. Single user mode will allow you to fix this.

## File system corruption
System hasn't been shutdown cleanly

# The bootstrap process
When you turn on the server, the following happens **_sequentially_**:
* Code saved in the ROM gets executed. It determines where and how to start the system's kernel
* When the kernel loads, it checks for the system's hardware, and starts the first and most important process, the ```init```. The ```init``` process has always PID of 1.
* After filesystems are checked and mounted, the systems startup scripts get executed by the ```init``` process.
* Finally the login prompt/GUI interface appears and the system becomes ready for users.

# Kernel loading
* The kernel is just a program that gets loaded into the systems memory.
* It is loaded by a program called ```Boot Loader``` that executed from ROM.
* Kernel loading cannot be controller by Linux because it occurs outside its scope.
* While loading, the kernel probes the attached hardward, and assigns an amount of RAM for itself. This part of memory will not be available to the user side.
* On Linux systems, the kernel can be found under ```/boot```. For example ```/boot/vmlinuz-3.8.13-118.el6uek.x86_64```. The exact filename of the kernal is vendor specific.
    * The above is Enterprise Linux v6 

# Kernel processes
* Once the kernel is loaded, it creates a number of startup processes. The most important one is the ```init```, having PID of 1.
* Other processes are created after that. They can be identified _- later after the system completes booting -_ by having square brackets around them. For example ```[kworker/0:1]```. The number after the slash / represents the processor number on which the process is running. You can query for such process using ```ps -ef | grep "\[.*\]"```
* Monitoring those kinds of processes you'll notice that they have low PIDs compared to other _normal_ processes.
* They are not and cannot be treated as user processes. Only ```init``` can be dealt with as such. They are portions of the kernel that are made to look like normal processes while they aren't.

# Startup Daemons
* After the kernel and its processes have successfully been loaded, the startup daemons start to get executed by the init process.
* The startup daemons are _**normal**_ shell scripts that load important system services like ```sshd```, ```ntpd```, network file shares ...etc
* Starting up specific daemons depends on the system's run level.

# Stage 1 - The BIOS
* On proprietary systems like AIX, HP-UX and SPARC, the boot code is not stored in BIOS, it is stored in a much more powerful firmware. Such a firmware has enough information about the attached hardware and can talk to the network on a simple level.
* On PC's the BIOS is responsible for executing the boot code. It is much simpler than the firmware of a proprietary machine.
* A typical PC will have several types of BIOS: one for the machine, anothe for the video card and a third for SCSI if it's available.
* BIOS configuration lets you choose the media from which you want the system to start, and the order by which it'll search for alternate media (or the network), should the first one fail.
* Once selected, the boot media has it's _**first 512 bytes**_ checked to determine which partition contains the ```boot loader```. _**This is really important**_.
* The ```boot loader``` is responsible for loading the ```kernel```.

# Stage 2 - GRUB
* **GR**and **U**inified **B**oot Loader
* It is the default boot loader for Linux and UNIX systems running on Intel processors
* It is responsible for loading the ```kernel```, together with some options that can be tweaked by the system administrator.
* It reads configuration options from ```/boot/grub/menu.lst``` (on Ubuntu and SUSE), and ```/boot/grub/grub.conf``` on Red Hat.
* Allows for the dual boot of Linux and Windows OSes.
* The configuration file has the following options:
    * ```default=number``` indicates which operating system/kernel to boot the system to. The list starts at ```0```. When the new kernel is installed, like through system upgrades, the old ones stay available for booting in the menu, so that you can choose to boot from them if the new one breaks the system.
    * ```timeout=number``` sets the number of seconds the system would wait for a keyboard interruption before it loads the configured options.
    * ```root (hd0,0) ``` is where to find the partition from which to load the system. The first disk and the first partition on the machine are defined as ```0``` and ```0``` respectively.
    * ```kernel``` loads the kernel from the specified path
    * ```title``` is the name of the OS at it will appear in the GRUB menu.
    * ```splashimage=path``` e.g. path is ```(hd1,0)/grub/splash.xpm.gz```. A specific image format is used, and then compressed with ```gz``` compression.
    * ```rootnoverify (hd0,0) ``` dunno what it does, but can be used to boot Windows off the first hard-drive, and first volume
    * ```chainloader +1``` is a command that instructs bootloader to take bootloader from first sector of disk 
    * ```rootnoverify``` prevents GRUB from trying to mount the filesystem. You need this to boot Windows with NTFS filesystems.

## Oracle Linux
Two flavours:
* Oracle Linux Server Unbreakable Enterprise Kernel
* Oracle Linux Server Red Hat Compatible Kernel

# GRUB command line interface
* It can be invoked by typing ```c``` in the GRUB boot screen
* It provides a basic command line interface that has some useful grub commands
* You can have a list of the possible commands by typing ```TAB``` twice.
* One of the most useful cases of using GRUB CLI is to boot an OS that is not configured in the ```grub.conf``` file. Assuming that this OS is installed on the first partition of the second disk of the machine, this can be done as follows:
    * ```root (hd1,0)```
    * ```kernel /vmlinuz-```[select the kernel image you want] ``` root=/dev/sdb2``` [root specifies where the root (/) filesystem is located. sdb2 is disk 2, partition 2]
    * ```boot``` [boots the OS]
* Other useful commands include ```find```. It will search for regular files only (no directories). You can use it on a failing system to find, for example, on which partition the kernel is installed (vmliniz), or where the root partition is (```/sbin/init```)

# Booting a second OS
* With GRUB, you have the option to install more than one operating system on the same machine, and select which one to use on startup.
* If the second OS you want to use is Windows, it is wise to install it before Linux because Windows deletes GRUB after installation.
* Some changes have to be made in GRUB to enable the system to boot into Windows:
   * ```rootnoverfiy (hd0,0)``` this forces GRUB not to try to mount the root partition (NTFS doesn't play well with GRUB)
   * ```chainloader +1``` makes GRUB load the boot loader from the first sector of the selected disk (disk 1 partition 1) as indicated by the ```root``` statement. This instructs it to use the Windows bootloader.

# Kernel command switches
* You can interrupt GRUB loading, while in the timeout period, by pressing any key. You can then select the kernel you wish to boot from, and press ```a``` to start adding command switches.
* Examples of useful switches are:
    * ```l``` or ```single``` to enter single user mode (useful for recovery as no login prompts, therefore can be used for resetting passwords).
    * ```n``` where n is the run level to where you want the system to boot (covered later)
    * ```init=/bin/bash``` will let the kernel load ```/bin/bash``` instead of the ```/sbin/init``` process. Both of these options will allow you to access the system as root without a password. 
    
        _You can reset the root password with this method, so physical access to the booting machine (and therefore GRUB) means you do not have a secure system._
    * ```root=/dev/sdxx``` lets the system boot to a different root partition. Example: ```root=/dev/sdb1```
    * ```ro``` boots the system in read only mode. This is strongly recommended when you want to perform ```fsck``` on the disks before booting. ```fsck``` should never be done on a read/write system. _This would result in corruption._
    * ```debug``` prints a more verbose output of the kernel loading status. It is useful when you want to troubleshoot a booting issue.
    * ```selinx 0 or 1``` disables/enables selinux module. It's a security module, that controls files processes and permissions, and some users like this. Others turn it off. This change would only last for the current boot session.

# The Single User Mode
* It is used to give the administrator the most basic functionality of a system, when it fails to boot.
* In single user mode, multiple logins are disabled, only the administrator (root) can login.
* This login is done physically on the machine and not through the network because networking is disabled in this mode.
* An administrator can choose to enter single user mode by editing the GRUB boot arguments, by using the ```shutdown``` command, or by using the ```telinit``` command.
* You are allowed, in this mode, to open a shell as root without being prompted for a password. This is one way to reset the root password if lost or forgotton.

# Startup Scripts
* They are the scripts that are run by the ```init``` process.
* They are normal shell scripts that do some _"housekeeping"_ to the system like clearing ```/tmp``` files, they also prepare the machine for use by doing tasks like setting the hostname, starting SSH daemon and configuring the network interfaces.
* The are placed in the ```/etc/init.d``` and symbolic links are made to them from respective, numbered directories like ```/etc/rc0.d```.
* The ```init``` (or ```upstart```) process ensures that the correct scripts are executed depending on the requested _**run level**_ to which the system will boot. 

# System run levels
* A run level is a specific _state_ of a UNIX/Linux system. They vary form one system to another, but the following are generally common among them:
    * ```0``` : halt, the system is shutdown
    * ```1``` : Single user mode
    * ```2,3,4,5``` : networking is enabled
    * ```6``` : system is rebooting
* In Linux, ```run level 3``` is used for a non-GUI session, while ```run level 5``` is used for a GUI-desktop session.
* The default run level of the system can be configured in ```/etc/inittab``` file.
* You can move from one run level to another, including shutdown and reboot, by using the ```telinit``` command followed by the desired run level.
* ```telinit -q``` will force the system to re-read the ```/etc/inittab``` file.

# The init process and the /etc/rc*.d
* Startup scripts are used to both start and stop daemons. They can be used to restart it (```stop``` then ```start```)
* The command is passed to the script as an argument. For example, ```/etc/init.d/httpd start```
* They are placed in the ```/etc/init.d```. The symbolic links are located in ```/etc/rc.*.d``` where ```*``` indicates the run level at which the script should run.
* The init process looks at the ```rc.d``` directories to determine which scripts to run, depending on the configured run level.
* In an ```rc.d``` directory, the script name (symbolic link) starts with an ```S``` (start) or ```k``` (kill) followed by a number. For example ```K35smb```.
* This way, ```init``` has a clear plan as to which scripts to run an in what order. For example, when transistioning from ```run level 3``` to ```run level 5```, ```init``` runs all the scripts that start with ```S``` in ```/etc/rc5.d```, in an ascending order, passing ```start``` as a command line argument to them.
* Numbers also ensure dependency between different services. For example, if ```httpd``` server daemon is started before the ```network service``` does, it will fail an you will have to manually restart it after the network is up.

# Red Hat implementation
* In Red Hat systems, ```init``` uses ```/etc/rc.d/rc``` script, passing the run level as an argument.
* ```/etc/rc.d/rc``` can run in _**"confirmation"**_ mode, where it asks the user before starting each script. This is useful when troubleshooting a faulty system.
* The scripts place an empty lock file in ```/var/lock/subsys``` with the same name as the daemon. Presence of this file means that the service is up and running. This file is deleted when the script is called with the stop argument.
* The ```ckhconfig``` command is used to install, remove, and manage startup scripts. It has the following useful options:
    * ```chkconfig --add script_name``` will add the script to the configuration.
    * ```chkconfig --level script_name on | off``` will enable/disable an added script in the specified run level.
    * ```chkconfig --del script_name``` will remove the script from the configuration
    * ```chkconfig --list``` will print all the configured startup scripts. Works best with ```grep```.
* Red Hat also offers the ```/etc/rc.d/rc.local``` file, which is run after all other boot scripts have finished execution. You can use it to add custom startup scripts.


