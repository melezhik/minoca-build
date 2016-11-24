# SYNOPSIS

Minoca OS builder.

# Description

This is high level wrapper of [Minoca build scripts](https://github.com/minoca/os) and by no means
to be treated as substitution of a such. Now it's just work for me. I found this tool quite helpful in
task of automation various Minoca builds.

# INSTALL

    $ sparrow plg install minoca-build


# USAGE

Caveat. 

Before running any build, you should install [Minoca Toolchain](http://www.minocacorp.com/download/minoca-tools-linux.tar.gz) binaries:

    $ wget http://www.minocacorp.com/download/minoca-tools-linux.tar.gz
    $ mkdir minoca-tools
    $ tar -xzf minoca-tools-linux.tar.gz -C minoca-tools
    $ PATH=$PATH:$PWD/minoca-tools/src/x86dbg/tools/bin/


Now you are free to run builds:

    $ sparrow plg run minoca-build --param target=build-os          # build minoca OS
    $ sparrow plg run minoca-build --param target=build-perl-5.20.1 # build Perl package
    $ sparrow plg run minoca-build --param target=test-perl-5.20.1  # test Perl package
    $ sparrow plg run minoca-build --param target=build-perl-5.20.1,test-perl-5.20.1 # build and test 
    $ sparrow plg run minoca-build --param target=list # show available target list

![minoca build report](https://raw.githubusercontent.com/melezhik/minoca-build/master/sparrow-minoca-build.png)

# Custom configuration

These are default settings for minoca build environment:

    +----------------------+---------------------------+
    | Variable             | Default Value             |
    +----------------------+---------------------------+
    | SRCROOT              | ~/src                     |
    | DEBUG                | dbg                       |
    | ARCH                 | x86                       |
    +--------------------------------------------------+


To override default settings you do:

    $ sparrow plg run minoca-build --param srcroot=/path/to/srcroot/ --param target=build-os

Or ( probably better as could be set once ) create a sparrow task:

    $ sparrow project create minoca
    $ sparrow task add minoca builder minoca-build
    $ sparrow task ini minoca/builder
    
      srcroot = /my/src/root
      debug   = dbg
      arch    = x86


    $ sparrow task run minoca/builder --param target=build-os

# Copy resulted *.ipk files

Every successful build results in creation of `*.ipk` file which then gets copied
to $SRCROOT/$ARCH$DEBUG/bin/apps directory, so usually next step could be rebuilding OS image:

    $ sparrow plg run minoca-build --param target=build-image


# Custom builds 

You may define custom builds with either command line parameters.


    # Build nano editor with dependencies
    $ sparrow plg run minoca-build --param target=build-ncurses-5.9,build-readline-6.3,build-nano-2.2.6

Or using sparrow tasks:

    $ sparrow task add minoca nano minoca-build # build nano editor
    $ sparrow task ini minoca/nano

      target build-ncurses-5.9
      target build-readline-6.3
      target build-nano-2.2.6

  
    $ sparrow task run minoca/nano

# Running none build targets

Usually all you need is to build a package, but if you run other some specific targets:

## Building os

There is dedicate target for it called 'build-os', probably this should be the very first step:

    $ sparrow plg run minoca-build --param target=build-os

## Rebuilding os image

Sometimes you need to rebuild os image, usually right after you get some package built:

    # Build nano editor with dependencies 
    # and copy resulted *.ipk files to $SRCROOT/$ARCH$DEBUG/bin/apps

    $ sparrow plg run minoca-build --param target=build-ncurses-5.9,build-readline-6.3,build-nano-2.2.6
    $ sparrow plg run minoca-build --param target=build-image

## Tests

    # running tests against third party Perl:
    $ sparrow plg run minoca-build --param target=test-perl-5.20.1

    # or with task:

    $ sparrow task add minoca perl-test minoca-build
    $ sparrow task ini minoca/perl-test

      target test-perl-5.20.1

    $ sparrow task run minoca/perl-test

## Clean

This target cleans some already build package, this technical equivalent of `make clean`
for given package:

    # clean nano and dependencies
    $ sparrow plg run minoca-build --param target=clean-ncurses-5.9,build-readline-6.3,build-nano-2.2.6

    # or with sparrow task

    $ sparrow task add minoca nano-clean minoca-build
    $ sparrow task ini minoca/nano-clean

      target clean-ncurses-5.9
      target clean-readline-6.3
      target clean-nano-2.2.6


## List available targets

To list all targets you can run:

    $ sparrow plg run minoca-build --param target=list


## Running sequence of builds:


    $ nano tasks.json

    [
 
      {
        "task" : "build-os",
        "plugin" : "minoca-build",
        "data" : {
          "srcroot"   => "/src",
          "arch"      => "x86", 
          "debug"     => "dbg",
          "target"    => "build-curl-7.41.0"
        }
      },
      {
        "task" : "build-perl",
        "plugin" : "minoca-build",
        "data" : {
          "srcroot"   => "/src",
          "arch"      => "x86", 
          "debug"     => "dbg",
          "target"    => "build-nano-2.2.6"
        }
      },
 
    ]

    $ sparrow box run tasks.json


## Running by cron

With `--cron` flag sparrow suppress a normal output and only emit report on unsuccessful exit code

    $ sparrow task run minoca/perl-test --cron

## Running builds by ssh

Take a look at [Sparrowdo](http://github.com/melezhik/sparrowdo/) - tool to run sparrow plugins over ssh ( and even more! ).


# Author

[Alexey Melezhik](mailto:melezhik@gmail.com)
  

# See also

[Minoca OS Project](http://minocacorp.com/)

    
 
