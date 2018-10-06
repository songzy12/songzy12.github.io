---
layout: post
title: "edX platform"
date: 2016-06-08 16:51:49 +0800
comments: true
categories: Python

---

## mongo

```
mongo 
```

```
sudo -i
rm /edx/var/mongo/mongodb/mongod.lock
sudo -u mongodb mongod --dbpath /edx/var/mongo/mongodb --repair --repairpath /edx/var/mongo/mongodb
start mongod
```

## paver

```
paver devstack --fast lms > lms.log 2>&1 &
paver devstack --fast studio > studio.log 2>&1 &
```

### pavement.py

```
grep -r devstack pavelib
pavelib/servers.py
```

### pavelib/servers.py

```
def devstack(args):
	sh(django_cmd('cms', settings, 'reindex_course', '--setup'))
	run_server(
        args.system[0],
        fast=args.fast,
        settings=settings,
        asset_settings=asset_settings,
        contracts=not args.no_contracts,
    )
```

```
def run_server(
        system, fast=False, settings=None, asset_settings=None, port=None, contracts=False
):
	if not settings:
		DEFAULT_SETTINGS = 'devstack'
	
	if not fast and asset_settings:
	    call_task('pavelib.assets.update_assets', args=args)

	args = [settings, 'runserver', '--traceback', '--pythonpath=.', '0.0.0.0:{}'.format(port)]
	run_process(django_cmd(system, *args))
```

### pavelib/utils/cmd.py

```
def django_cmd(sys, settings, *args):
	return cmd("python manage.py", sys, "--settings={}".format(settings), *args)
```

```
['python manage.py', 'cms', '--settings=devstack', ('reindex_course', '--setup')]
['python manage.py', 'lms', '--settings=devstack', ('runserver', '--traceback', '--pythonpath=.', '0.0.0.0:8000', '--contracts')]
```

```
python manage.py lms --settings=devstack runserver --traceback --pythonpath=. 0.0.0.0:8000 --contracts
```

---

## manage.py

```
settings_base='lms/envs'
default_settings='lms.envs.dev'
startup='lms.startup'

os.environ["DJANGO_SETTINGS_MODULE"] = edx_args.settings_base.replace('/', '.') + "." + edx_args.settings

startup = importlib.import_module(edx_args.startup)
startup.run()

from django.core.management import execute_from_command_line
execute_from_command_line([sys.argv[0]] + django_args)
# ['manage.py', 'runserver', '--traceback', '--pythonpath=.', '0.0.0.0:8000']
```

* lms/startup.py

---

## django-admin

django-admin: [here](https://docs.djangoproject.com/en/1.9/ref/django-admin/)

```
whereis django-admin

/usr/local/bin/django-admin.py
/usr/local/lib/python2.7/dist-packages/django
```

## management

execute_from_command_line: [here](https://github.com/django/django/blob/master/django/core/management/__init__.py)

```
utility = ManagementUtility(argv)
utility.execute()
```

```
self.argv = argv or sys.argv[:]
self.prog_name = os.path.basename(self.argv[0]) # manage.py
```

```
subcommand = self.argv[1] # runserver

parser.add_argument('--settings')
parser.add_argument('--pythonpath')
 
settings.INSTALLED_APPS

if subcommand == 'runserver' and '--noreload' not in self.argv:
	autoreload.check_errors(django.setup)()

self.autocomplete()

self.fetch_command(subcommand).run_from_argv(self.argv)
```

`/usr/local/lib/python2.7/dist-packages/django/core/management/commands/runserver.py`

---

## settings.py

```
vi /edx/app/edxapp/edx-platform/lms/envs/common.py
cd /edx/app/edxapp/venvs/edxapp/local/lib/python2.7/site-packages/simple_history
```

* INSTALLED_APPS
* TEMPLATES = [{'DIRS':[PROJECT_ROOT / "templates",]}]

---

## urls.py

```
vi /edx/app/edxapp/edx-platform/lms/urls.py
```

```
url(r'^$', 'branding.views.index', name="root")
```

`vi /edx/app/edxapp/edx-platform/lms/djangoapps/branding/views.py`

```
return redirect(reverse('dashboard'))
```

```
url(r'^dashboard$', 'student.views.dashboard', name="dashboard"),
```

`vi /edx/app/edxapp/edx-platform/common/djangoapps/student/views.py`

```
return render_to_response('dashboard.html', context)
```

`vi /edx/app/edxapp/edx-platform/lms/templates/dashboard.html`

```
url(
    r'^courses/{}/info$'.format(
        settings.COURSE_ID_PATTERN,
    ),
    'courseware.views.course_info',
    name='info',
),
```

```
url(
    r'^courses/{}/courseware/(?P<chapter>[^/]*)/(?P<section>[^/]*)/$'.format(
        settings.COURSE_ID_PATTERN,
    ),
    'courseware.views.index',
    name='courseware_section',
),
url(
    r'^courses/{}/courseware/(?P<chapter>[^/]*)/(?P<section>[^/]*)/(?P<position>[^/]*)/?$'.format(
        settings.COURSE_ID_PATTERN,
    ),
    'courseware.views.index',
    name='courseware_position',
),
```

`vi /edx/app/edxapp/edx-platform/lms/envs/common.py`

```
COURSE_KEY_PATTERN = r'(?P<course_key_string>[^/+]+(/|\+)[^/+]+(/|\+)[^/?]+)'
COURSE_ID_PATTERN = COURSE_KEY_PATTERN.replace('course_key_string', 'course_id')
```

`vi /edx/app/edxapp/edx-platform/lms/djangoapps/courseware/views.py`

```
from opaque_keys.edx.keys import CourseKey, UsageKey
def index(request, course_id, chapter=None, section=None,
          position=None):
	course_key = CourseKey.from_string(course_id)
	return _index_bulk_op(request, course_key, chapter, section, position)

def _index_bulk_op(request, course_key, chapter, section, position):
	context = {
	    'csrf': csrf(request)['csrf_token'],
	    'accordion': render_accordion(user, request, course, chapter, section, field_data_cache),
	    'COURSE_TITLE': course.display_name_with_default,
	    'course': course,
	    'init': '',
	    'fragment': Fragment(),
	    'staff_access': staff_access,
	    'studio_url': studio_url,
	    'masquerade': masquerade,
	    'xqa_server': settings.FEATURES.get('XQA_SERVER', "http://your_xqa_server.com"),
	}
	context['fragment'] = section_module.render(STUDENT_VIEW, section_render_context)
	context['section_title'] = section_descriptor.display_name_with_default
	result = render_to_response('courseware/courseware.html', context)
	return result/conte
```

---

## courseware.html

`vi /edx/app/edxapp/edx-platform/lms/templates/courseware/courseware.html`

```
${fragment.body_html()}
```

---

## DATABASES

```
lms.auth.json
```

```
"read_replica": {
    "ENGINE": "django.db.backends.mysql",
    "HOST": "localhost",
    "NAME": "edxapp",
    "PASSWORD": "password",
    "PORT": "3306",
    "USER": "edxapp001"
}
```

```
mysql --host="localhost" --password="password" --user="edxapp001"
use read_replica;
```
