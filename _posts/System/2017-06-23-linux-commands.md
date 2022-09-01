---
layout: post
title: "Linux Commands"
date: 2017-06-23 14:38:26 +0800
comments: true
categories: 

---

## apt

```
E: Could not get lock /var/lib/dpkg/lock - open (11: Resource temporarily unavailable)
E: Unable to lock the administration directory (/var/lib/dpkg/), is another process using it?

sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
```

```
Reading package lists... Error!
E: Encountered a section with no Package: header
E: Problem with MergeList /var/lib/apt/lists/cn.archive.ubuntu.com_ubuntu_dists_xenial-backports_main_binary-amd64_Packages
E: The package lists or status file could not be parsed or opened.

sudo rm -vf /var/lib/apt/lists/*
sudo apt-get update
```

### upgrade

```
sudo apt-get update
sudo apt upgrade
```

```
2 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
29 not fully installed or removed.
```

### autoclean, clean, autoremove

* `clean`: clean clears out the local repository of retrieved package files. It removes everything but the lock file from `/var/cache/apt/archives/` and `/var/cache/apt/archives/partial/`. When APT is used as a dselect(1) method, clean is run automatically. Those who do not use dselect will likely want to run apt-get clean from time to time to free up disk space.
* `autoclean`: Like clean, autoclean clears out the local repository of retrieved package files. The difference is that it only removes package files that can no longer be downloaded, and are largely useless. This allows a cache to be maintained over a long period without it growing out of control. The configuration option `APT::Clean-Installed` will prevent installed packages from being erased if it is set to off.
* `autoremove`: is used to remove packages that were automatically installed to satisfy dependencies for some package and that are no more needed.

## awk

* -F: --filed-separator

## chmod

```
rm: cannot remove ‘date.csv’: Permission denied

chmod 777 .
```

## dirname

Get the name of the directory where a script is executed:

```
echo $(dirname $SHELL)
echo $(dirname `readlink -f -- $0`)
```

## dpkg

```
29 not fully installed or removed.
```

```
sudo apt install -f
```

Searches for packages that have been installed only partially on your system. dpkg will suggest what to do with them to get them working.

```
sudo dpkg -C 
```

```
The following packages have been unpacked but not yet configured.
```

```
sudo dpkg --configure -a
```

```
dpkg-query: package 'ibus-table' is not installed
```

```
sudo apt install ibus-table
```

## file

```
file CATS20LINUX 
```

```
-bash: ./CATS20LINUX: No such file or directory 
```

You're probably trying to run a 32-bit binary on a 64-bit system that doesn't have 32-bit support installed.

## find 

```
find . -name 'jquery.min.js'
find . -name '*.md'
```

## gnome-open

```
gnome-open main.pdf
```

## grep

```
find -iname "*.py" | xargs grep -i mooc2
```

```
grep -r 'pending' .
```

* -v: --invert-match
* -i: --ignore-case
* -f: FILE
* -c: --count
* -n: --line-number

## ls

* -F(--classify): append indicator (one of `*/=>@|`) to entries
* -1: list 1 file per line

* `/` is a directory
* `@` is a symlink
* `|` is a named pipe (fifo)
* `=` is a socket.
* `*` for executable files
* `>` is for a "door" -- a file type currently not implemented for Linux, but supported on Sun/Solaris.

## lsb_release

Linux Standard Base.

```
lsb_release -a
cat /etc/issue
```

## man

```
man 2 stat
```

The number corresponds to what section of the manual that page is from. The man page for man itself (man man) explains it and lists the standard ones:

```
    1      User Commands
    2      System Calls
    3      C Library Functions
    4      Devices and Special Files
    5      File Formats and Conventions
    6      Games et. al.
    7      Miscellanea
    8      System Administration tools and Daemons
```

## mkdir

* -p: no error if existing, make parent directories as needed 

## passwd

```
vi /etc/passwd
sudo vi /etc/shadow
```

GECOS(comments field): general electric comprehensive operating system.

## pgrep

```
pgrep std_run.sh
```

## shift

```
#!/bin/bash
echo "Input: $@"
shift 3
echo "After shift: $@"
```

```
$ myscript.sh one two three four five six

Input: one two three four five six
After shift: four five six
```

## ssh-keygen

client:

```
ssh-keygen -t rsa
```

server:

```
cat id_dsa.pub >> ~/.ssh/authorized_keys
chmod 600 authorized_keys
chmod 700 -R .ssh
```

* -t: type
* -b: bits
* -C: comment

## sticky bit

Once set, only the file's owner, the directory's owner, or root user can rename or delete the file.

* t: `chmod o+t /opt/dump/`
* 1: `chmod 1757 /opt/dump/`

## su

su (short for substitute user)

## tar

```
tar zxvf backups.tgz
tar xvf jacana-data.tar.bz2
```

* -z : Uncompress the resulting archive with gzip command.
* -x : Extract to disk from the archive.
* -v : Produce verbose output i.e. show progress and file names while extracting files.
* -f backup.tgz : Read the archive from the specified file called backup.tgz.
* -C /tmp/data : Unpack/extract files in /tmp/data instead of the default current directory.

## unzip

```
unzip '*.zip'
unzip -v test.zip
unzip -o test.zip -d tmp/
```

## gunzip

```
gunzip file.gz
gzip -d file.gz
```

## tee

```
tee 
```

In computing, `tee` is a command in command-line interpreters (shells) using standard streams which reads standard input and writes it to both standard output and one or more files, effectively duplicating its input.

## tree

```
sudo gedit /etc/apt/sources.list
deb http://us.archive.ubuntu.com/ubuntu xenial main universe
sudo apt-get update
sudo apt-get install tree
```

## type

```
type ls
type cd
```

## wc

* -l: print the newline counts
