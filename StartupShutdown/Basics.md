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
* The configuration file has the following options:
    * ```default=number``` indicates which operating system/kernel to boot the system to. The list starts at ```0```. When the new kernel is installed, like through system upgrades, the old ones stay available for booting in the menu, so that you can choose to boot from them if the new one breaks the system.
    * ```timeout=number``` sets the number of seconds the system would wait for a keyboard interruption before it loads the configured options.
    * ```root (hd0,0) ``` is where to find the partition from which to load the system. The first disk and the first partition on the machine are defined as ```0``` and ```0``` respectively.
    * ```kernel``` loads the kernel from the specified path

# Stage 3 - 