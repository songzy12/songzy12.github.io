---
layout: post
title: "edX Developer Stack"
date: 2016-05-16 14:26:50 +0800
comments: true
categories: Python

---

See Running Devstack [here](https://openedx.atlassian.net/wiki/display/OpenOPS/Running+Devstack).

```
paver devstack --fast lms > lms.log 2>&1 &
paver devstack --fast studio > studio.log 2>&1 &
```

## OPENEDX_RELEASE

```
default: Downloading: http://files.edx.org/vagrant-images/devstack-periodic-2016-05-05.box
The requested URL returned error: 403 Forbidden

export OPENEDX_RELEASE="named-release/dogwood.1"
```

* staff@example.com / edx
* verified@example.com / edx
* audit@example.com / edx
* honor@example.com / edx

```
vagrant up
vagrant ssh
sudo su edxapp
```

* This will source the edxapp environment (`/edx/app/edxapp/edxapp_env`) so that the venv python and rbenv ruby are in your search path.
* It will also set the current working directory to the edx-platform repository (`/edx/app/edxapp/edx-platform`).

## LMS Workflow

LMS: Learning Management System.

```
paver devstack lms > lms.log 2>&1 &
paver devstack --fast lms > lms.log 2>&1 &

Starting development server at http://0.0.0.0:8000/
```

WSGI: Web Server Gateway Interface

## Studio Workflow

CMS: course management system

```
paver devstack studio > studio.log 2>&1 &
paver devstack --fast studio > studio.log 2>&1 &

Starting development server at http://0.0.0.0:8001/
```

## Forum Workflow

```
sudo su forum
bundle install
ruby app.rb -p 18080
```

---

## Vagrant

```
mkdir devstack
cd devstack
curl -L https://raw.githubusercontent.com/edx/configuration/master/vagrant/release/devstack/Vagrantfile > Vagrantfile
vagrant plugin install vagrant-vbguest
vagrant up
vagrant ssh
```

### update

```
curl -o vagrant_1.7.2_x86_64.deb https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
sudo dpkg -i vagrant_1.7.2_x86_64.deb
```

### remove box

```
vagrant box list
vagrant status
vagrant halt
vagrant destroy
vagrant box remove --force --all dogwood-devstack-2016-03-09
```

### port in use

The forwarded port to 9200 is already in use
on the host machine.

```
netstat -peanut
id
vi Vagrantfile
```

### NFS

```
==> default: Mounting NFS shared folders...
```

```
sudo apt-get install nfs-kernel-server
sudo apt-get install nfs-common
```

### SSH

```
The SSH command responded with a non-zero exit status.
```

```
==> default: FATAL: all hosts have already failed -- aborting

==> default: INFO:ansible.callback_plugins.datadog_tasks_timing:
==> default: Playbook vagrant-devstack finished: Fri Mar 25 13:12:31 2016, 276 total tasks.  0:18:28 elapsed.
==> default:            to retry, use: --limit @/root/vagrant-devstack.retry
==> default:
==> default: localhost                  : ok=260  changed=65   unreachable=0    failed=1
```

```
rm -rf devstack/
```

## VirtualBox

```
vboxmanage --version
```

Port Forwarding

```
Failed to load unit 'pgm' (VERR_MAP_FAILED).
```

Discard saved state.

---

<!--more-->

## 403

```
http://10.9.10.15:8000/courses/course-v1:TsinghuaX+30240184X+2016_T1/courseware/f1903b9555df41bca0ebd3922949ff48/5a6b1d348c8e4c01978090cb9b189af2/
```

Delete this Unit and reconstruct it.

```
grep -r "jquery.cookie.js" .

./edx-platform/lms/envs/common.py:    'js/vendor/jquery.cookie.js',
```

```
find -name "jqeury.cookie.js"
```

```
./edx-platform/common/static/js/vendor/jquery.cookie.js
```

## jQuery

```
http://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js
```

```
grep -r ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js .
```

```
./venvs/edxapp/local/lib/python2.7/site-packages/debug_toolbar/settings.py:    'JQUERY_URL': '//ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js',
./venvs/edxapp/lib/python2.7/site-packages/debug_toolbar/settings.py:    'JQUERY_URL': '//ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js'
```

```
//code.jquery.com/jquery-2.2.2.min.js
```

## static

```
http://static.tsinghuax.org/video/30240184X/01A-1.mp4
```

```
"POST /event HTTP/1.1" 403 9944"
```

```
pscp -P 2222 ./4.2.mp4 vagrant@127.0.0.1:.
pwd
/home/vagarnt
sudo su edxapp
pwd
/edx/app/edxapp/edx-platform
cd /edx/app/edxapp/edx-platform/cms/static/
mkdir video
sudo cp /home/vagarnt/4.2.mp4 video/.  
```

### python 

```
cd ~/edx-platform/cms/static/video
python -m SimpleHTTPServer 7777
```

### settings

`settings.py`

```
https://youtu.be/t1OeLJ1ryRw
https://www.youtube.com/embed/t1OeLJ1ryRw

<iframe> </iframe>
```

### nginx

```
vi /etc/nginx/nginx.conf
```

## xmodule

```
                Finished processing xmodule assets.
touch lms/urls.py cms/urls.py
        CHANGED: /edx/app/edxapp/edx-platform/common/lib/xmodule/xmodule/js/src/vertical/edit.js
xmodule_assets common/static/xmodule
```

```
paver devstack --fast studio
```

## OSError

```
File "pavelib/assets.py", line 338, in watch_assets
    CoffeeScriptWatcher().register(observer)
  File "pavelib/assets.py", line 107, in register
    observer.schedule(self, dirname)
  File "/edx/app/edxapp/venvs/edxapp/local/lib/python2.7/site-packages/watchdog/observers/api.py", line 329, in schedule
    timeout=self.timeout)
  File "/edx/app/edxapp/venvs/edxapp/local/lib/python2.7/site-packages/watchdog/observers/inotify.py", line 128, in __init__
    self._inotify = Inotify(watch.path, watch.is_recursive)
  File "/edx/app/edxapp/venvs/edxapp/local/lib/python2.7/site-packages/watchdog/observers/inotify_c.py", line 189, in __init__
    Inotify._raise_error()
  File "/edx/app/edxapp/venvs/edxapp/local/lib/python2.7/site-packages/watchdog/observers/inotify_c.py", line 429, in _raise_error
    raise OSError(os.strerror(_errnum))
OSError: Too many open files
```

```
lsof -u edxapp
```

lsof: list open files

Then kill the ones that with `anon-inode`.

```
int fd = open( "/tmp/file", O_CREAT | O_RDWR, 0666 );
unlink( "/tmp/file" );
// Note that the descriptor fd now points to an inode that has no filesystem entry; you
// can still write to it, fstat() it, etc. but you can't find it in the filesystem.
```