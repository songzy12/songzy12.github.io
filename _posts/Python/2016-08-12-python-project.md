---
layout: post
title: "Python Project"
date: 2016-08-12 13:51:20 +0800
comments: true
categories: 

---

[Here](http://jeffknupp.com/blog/2013/08/16/open-sourcing-a-python-project-the-right-way/).

* project layout (directory structure)
* `setuptools` and `setup.py` file
* `git` for version control
* `Github` Issues for bug tracking, feature requests, planned features, release management.
* `git-flow` for git work flow
* `py.test` for unit testing
* `tox` for testing standardization
* `Sphinx` for auto-generated HTML documentation
* `TravisCI` for continuous testing integration
* `ReadTheDocs` for continuous documentation integration
* `Cookiecutter` to automate these steps when starting your next project

## Project Layout

* LICENSE
* README.md
* TODO.md
* docs/
* requirements.txt
* sandman/
* tests/
* setup.py

## setuptools and setup.py

[Here](https://setuptools.readthedocs.io/en/latest/setuptools.html) and [here](https://docs.python.org/2/distutils/index.html).

The `setuptools` package (really a set of enhancements for `distutils`) simplifies the building and distribution of Python packages.

`setup.py` should live in your project's root directory. The most important section of `setup.py` is the call to `setuptools.setup`, where all the meta-information about the package lives.

```
setup(
	version=sandman.__version__,
 	install_requires = ['docutils>=0.3'],
	cmdclass={'test': PyTest},
	long_description=__doc__, # metadata for upload to PyPI
	entry_points={
        'console_scripts': [
            'sandmanctl = sandman.sandmanctl:run',
            ],
		},
	packages = find_packages(),
	test_suite='sandman.test.test_sandman', # for `python setup.py test`	
	package_data={'sandman': ['templates/**', 'static/*/*']},
)
```

### version

We can always use the package's version to populate the `version` parameter in `setup`.

A version consists of an alternating series of release numbers and pre-release or post-release tags.

A release number is a series of digits punctuated by dots.  Each series of digits is treated numerically.

Following a release number, you can have either a pre-release or post-release tag.

A pre-release tag is a series of letters that are alphabetically before `final`. You do not have to place a dot or dash before the prerelease tag if it’s immediately after a number. there are three special prerelease tags that are treated as if they were the letter `c`: `pre`, `preview`, and `rc`. 

A post-release tag is either a series of letters that are alphabetically greater than or equal to `final`, or a dash (`-`). Post-release tags are generally used to separate patch numbers, port numbers, build numbers, revision numbers, or date stamps from the release number.

For example, `0.6a9.dev-r41475` could denote Subversion revision `41475` of the in- development version of the ninth alpha of release `0.6`. Notice that dev is a pre-release tag, so this version is a lower version number than `0.6a9`, which would be the actual ninth alpha of release `0.6`. But the `-r41475` is a post-release tag, so this version is newer than `0.6a9.dev`.

### long_description

reStructuredText: It is part of the `Docutils` project of the Python Doc-SIG (Documentation Special Interest Group), aimed at creating a set of tools for Python similar to `Javadoc` for `Java` or `POD`(Plain Old Documentation) for `Perl`. `Docutils` can extract comments and information from Python programs, and format them into various forms of program documentation.

REST: REpresentational State Transfer.

I use `pandoc` to automatically generate `README.rst` from `README.md`. 

### package_data

Also notice that if you use paths, you must use a forward slash (/) as the path separator, even if you are on Windows. `Setuptools` automatically converts slashes to appropriate platform-specific separators at build time.

* include_package_data: Accept all data files and directories matched by `MANIFEST.in`.
* package_data: Specify additional patterns to match files and directories that may or may not be matched by `MANIFEST.in` or found in source control.
* exclude_package_data: Specify patterns for data files and directories that should not be included when a package is installed, even if they would otherwise have been included due to the use of the preceding options. 

### extras_require: 

A dictionary mapping names of “extras” (optional features of your project) to strings or lists of strings specifying what other distributions must be installed to support those features.

### test_suite

`py.test` has a special entry (`class PyTest`) to allow `python setup.py test` to work correctly.

A string naming a `unittest.TestCase` subclass (or a package or module containing one or more of them, or a method of such a subclass), or naming a function that can be called with no arguments and returns a `unittest.TestSuite`. If the named suite is a module, and the module has an `additional_tests()` function, it is called and the results are added to the tests to be run. If the named suite is a package, any submodules and subpackages are recursively added to the overall test suite.

### entry_points

When this project is installed on non-Windows platforms (using `setup.py install`, `setup.py develop`, or by using EasyInstall), a set of `foo`, `bar`, and `baz` scripts will be installed that import `main_func` and `some_func` from the specified modules. The functions you specify are called with no arguments, and their return value is passed to `sys.exit()`, so you can return an errorlevel or message to print to `stderr`.

Although `setup()` supports a `scripts` keyword for pointing to pre-made scripts to install, the recommended approach to achieve cross-platform compatibility is to use `console_scripts` entry points. 

## README.md

`README.md`:

* A description of your project
* Links to the project's ReadTheDocs page
* A TravisCI button showing the state of the build
* "Quickstart" documentation (how to quickly install and use your project)
* A list of non-Python dependencies (if any) and how to install them

## git-flow

[Here](http://nvie.com/posts/a-successful-git-branching-model/).

The `develop` is the branch you'll be doing most of your work off of; it's also the branch that represents the code to be deployed in the next release. `feature` branches represent non-trivial features and fixes that have not yet been deployed (a completed `feature` branch is merged back into `develop`). Updating master is done through the creation of a `release`. 

```
git flow init

git flow feature start <feature name>
git flow feature finish <feature name>

git flow release start <release number>
git flow release finish <release number>

git flow hotfix start <release number>
git flow hotfix finish <release number>
```

## virtualenvwrapper

```
pip install `virtualenvwrapper`
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
```

```
mkproject [OPTIONS] DEST_DIR
mkvirtualenv ossproject
deactivate
workon <project name>
```

```
pip freeze > requirements.txt
```

Commit `requirements.txt` to your git repo. In addition, you can now add the packages listed there as the value for the `install_requirements` argument to `distutils.setup` in `setup.py`. 

Doing that now will ensure that, when we later upload the package to `PyPI`. It can be `pip install`ed with automatically resolved dependencies.

## py.test

In the Python automated testing ecosystem, there are two main alternatives to the (quite usable) Python standard library `unittest` package: `nose` and `py.test`. Both extend `unittest` to make it easier to work with while adding additional functionality.


* Support for setuptools/distutils projects: `python setup.py test` still works
* Support for "normal" `assert` statements (rather than needing to remember all the jUnit-style assert functions)
* Less boilerplate
* Support for multiple testing styles: `unittest`, `doctest`, `nose` tests

In the `test` directory, create a file called `test_<project_name>.py`. `py.test`'s test discovery mechanism will treat any file with the `test_` prefix as a test file (unless told otherwise).

```
pip install pytest-cov
py.test --cov=path/to/package --cov-report=term --cov-report=html
```

## Tox

`tox.ini`:

```
[tox]
envlist=py27, py34

[testenv]
deps=
    pytest
    coverage
    pytest-cov
setenv=
    PYTHONWARNINGS=all

[pytest]
adopts=--doctest-modules
python_files=*.py
python_functions=test_
norecursedirs=.tox .git

[testenv:py27]
commands=
    py.test --doctest-module

[testenv:py34]
commands=
    py.test --doctest-module

[testenv:py27verbose]
basepython=python
commands=
    py.test --doctest-module --cov=. --cov-report term

[testenv:py34verbose]
basepython=python3.4
commands=
    py.test --doctest-module --cov=. --cov-report term
```

```
tox
tox -e py33verbose
```

`setup.py`

```
setup(
    #...,
    tests_require=['tox'],
    cmdclass = {'test': Tox},
    )
```

## Sphinx

We'll be keeping our documentation in the `docs` directory and the generated documentation in the `docs/generated` directory.

To auto-generate reStructured Text documentation files from your `docstring`s, run the following command in your project's root directory:

```
sphinx-apidoc -F -o docs <package name>
```

This will create a `docs` directory with a number of documentation files. In addition, it creates a `conf.py` file, which is responsible for configuration of your documentation. You'll also see a `Makefile`, handy for building HTML documentation in one command (`make html`).

## PyPI

Even if your project is available on GitHub, it's not until a release is uploaded to PyPI that your project is useful.

`cheesecake`. It analyzes your package and assigns "scores" in a number of categories. It measures how easy/correct packaging and installing your package is, the quality of the code, and the quality and quantity of your documentation.

```
python setup.py register
python setup.py sdist upload
```

After uploading your first release to PyPI, the basic workflow is this:

* Do some work on your package (i.e. fix bugs, add features, etc)
* Make sure the tests pass
* "Freeze" your code by creating a release branch in git-flow
* Update the __version__ number in your package's __init__.py file
* Run python setup.py sdist upload to upload the new version of your package to PyPI

As long as you're properly managing your version numbers, there is no such thing as releasing "too frequently."

## TravisCI

Continuous Integration refers to the process of continuously integrating all changes for a project (rather than periodic bulk updates). 

Each time we push a commit to GitHub our tests run, telling us if the commit broke something.

```
language: python
python:
    - "2.7"
install: 
    - "pip install -r requirements.txt --use-mirrors"
script: 
    - "python setup.py test"
```

## ReadTheDocs

* Repo: https://github.com/github_username/project_name.git
* Default Branch: develop
* Default Version: latest
* Python configuration file: (leave blank)
* Use virtualenv: (checked)
* Requirements file: requirements.txt
* Documentation Type: Sphinx HTML

## Cookiecutter

`Cookiecutter` is a command line tool that automates the process of starting a project in a way that makes doing the stuff discussed in this article easy. 

Don't repeat yourself.