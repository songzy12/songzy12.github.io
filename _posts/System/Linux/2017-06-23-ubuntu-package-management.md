---
layout: post
title: "Ubuntu Package Management"
date: 2017-06-23 14:38:26 +0800
comments: true
categories: 

---

Package management on Ubuntu using apt/dpkg

## lsb_release

Linux Standard Base.

```
lsb_release -a
cat /etc/issue
```

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
