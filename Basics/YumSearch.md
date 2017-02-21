# Yum Search
Search yum respositories for a particular package. 

The following output shows a seach for ```ssh```:

```
[root@localhost /]# yum search ssh
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * base: mirrors.clouvider.net
 * extras: mirrors.clouvider.net
 * updates: mirrors.clouvider.net
================================================ N/S matched: ssh =================================================
fence-agents-ilo-ssh.x86_64 : Fence agent for HP iLO devices via SSH
ksshaskpass.x86_64 : A KDE version of ssh-askpass with KWallet support
libssh.x86_64 : A library implementing the SSH protocol
libssh-devel.x86_64 : Development files for libssh
libssh2.i686 : A library implementing the SSH2 protocol
libssh2.x86_64 : A library implementing the SSH2 protocol
libssh2-devel.i686 : Development files for libssh2
libssh2-devel.x86_64 : Development files for libssh2
libssh2-docs.noarch : Documentation for libssh2
openssh.x86_64 : An open source implementation of SSH protocol versions 1 and 2
openssh-askpass.x86_64 : A passphrase dialog for OpenSSH and X
openssh-clients.x86_64 : An open source SSH client applications
openssh-keycat.x86_64 : A mls keycat backend for openssh
openssh-ldap.x86_64 : A LDAP support for open source SSH server daemon
openssh-server.x86_64 : An open source SSH server daemon
openssh-server-sysvinit.x86_64 : The SysV initscript to manage the OpenSSH server.
pam_ssh_agent_auth.i686 : PAM module for authentication with ssh-agent
pam_ssh_agent_auth.x86_64 : PAM module for authentication with ssh-agent
jsch.noarch : Pure Java implementation of SSH2
python-paramiko.noarch : SSH2 protocol library for python

  Name and summary matches only, use "search all" for everything.
```

# Yum Provides
Suppose you want to install ```scp```, you initially go to run
```yum -y install scp```. That fails to find a package called ```scp```.
That's because ```scp``` is a component of other packages. 

How can you find what package includes ```scp```?

Run "```yum provides scp```" and you'll get the following output:

```
[root@localhost /]# yum provides scp
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * base: mirrors.clouvider.net
 * extras: mirrors.clouvider.net
 * updates: mirrors.clouvider.net
openssh-clients-6.6.1p1-31.el7.x86_64 : An open source SSH client applications
Repo        : base
Matched from:
Filename    : /usr/bin/scp

openssh-clients-6.6.1p1-33.el7_3.x86_64 : An open source SSH client applications
Repo        : updates
Matched from:
Filename    : /usr/bin/scp

openssh-clients-6.6.1p1-33.el7_3.x86_64 : An open source SSH client applications
Repo        : @updates
Matched from:
Filename    : /bin/scp

openssh-clients-6.6.1p1-33.el7_3.x86_64 : An open source SSH client applications
Repo        : @updates
Matched from:
Filename    : /usr/bin/scp
```

You can also use ```*``` in the package search expression.

# Yum Info
Get information on a particular package.

This particular example shows ```openssh-clients```:

```
[root@localhost /]# yum info openssh-clients
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * base: mirrors.clouvider.net
 * extras: mirrors.clouvider.net
 * updates: mirrors.clouvider.net
Installed Packages
Name        : openssh-clients
Arch        : x86_64
Version     : 6.6.1p1
Release     : 33.el7_3
Size        : 2.2 M
Repo        : installed
From repo   : updates
Summary     : An open source SSH client applications
URL         : http://www.openssh.com/portable.html
Licence     : BSD
Description : OpenSSH is a free version of SSH (Secure SHell), a program for logging
            : into and executing commands on a remote machine. This package includes
            : the clients necessary to make encrypted connections to SSH servers.
```

# Yum Group Install
This allows you to install a group of packages. A good exmaple of this
is when you want to install the GUI on a Red Hat installation:

```yum -y groupinstall "Desktop" "Desktop Platform" "X Window System" "Fonts"```

# Yum Clean All
This is used to clean the package metadata off the metadata.
This will force yum to redownload package metadata.
