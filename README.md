# SYNOPSIS

Minoca OS builder.


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

    $ sparrow plg run minoca-build --param target=build-os # build minoca OS
    $ sparrow plg run minoca-build --param target=build-perl-5.20.1 # build Perl package
    $ sparrow plg run minoca-build --param target=test-perl-5.20.1 # test Perl package
    $ sparrow plg run minoca-build --param target=build-perl-5.20.1,test-perl-5.20.1 # build and test 
    $ sparrow plg run minoca-build --param target=list-targets # show available target list

![minoca build report](https://raw.githubusercontent.com/melezhik/minoca-build/master/sparrow-minoc-build.png)

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


# Custom builds 

You may define custom builds with either command line parameters.


    # Build a apache httpd server
    $ sparrow plg run minoca-build --param target=build-apr-util-1.5.4,build-apr-1.5.1,build-httpd-2.4.20

Or using sparrow tasks:

    $ sparrow task add minoca httpd minoca-build # build apache httpd server
    $ sparrow task ini minoca/httpd

      target build-apr-util-1.5.4
      target build-apr-1.5.1
      target build-httpd-2.4.20
  
    $ sparrow task run minoca/httpd

## Running none build targets

Usually all you need is to build a package, but if you run other some specific targets:

    # running tests against third party Perl:
    $ sparrow plg run minoca-build --param target=test-perl-5.20.1

    # or with task:

    $ sparrow task add minoca perl-test minoca-build
    $ sparrow task ini minoca/perl-test

      target test-perl-5.20.1

    $ sparrow task run minoca/perl-test

## Building os

There is dedicate target for it called 'build-os':

    $ sparrow plg run minoca-build --param target=build-os

## List available targets

To list all targets you can run:

    $ sparrow plg run minoca-build --param target=list-targets


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

    
 
