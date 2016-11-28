# SYNOPSIS

Minoca OS builder.

# Description

This is high level wrapper of [Minoca build scripts](https://github.com/minoca/os) and by no means
to be treated as substitution of a such. Now it's just work for me. Minoca-build tools abstract some
low level details of cooking things with `make` which could be safe way to go for unprepared user,
but if you need to hack into process - please follow [Minoca build scripts](https://github.com/minoca/os) documentation.

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

    $ sparrow plg run minoca-build --param target=list              # show available target list
    $ sparrow plg run minoca-build --param target=os                # build minoca OS
    $ sparrow plg run minoca-build --param target=all-tools         # required to build packages
    $ sparrow plg run minoca-build --param target=nano-2.2.6        # build nano package
    $ sparrow plg run minoca-build --param target=nano-2.2.6-clean  # clean nano package 
    $ sparrow plg run minoca-build --param target=nano-2.2.6-clean,nano-2.2.6 # clean and the build nano
    $ sparrow plg run minoca-build --param target=image             # build OS image with packages built in

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

    $ sparrow plg run minoca-build --param srcroot=/path/to/srcroot/ --param target=os

Or ( probably better as could be set once ) create a sparrow task:

    $ sparrow project create minoca
    $ sparrow task add minoca builder minoca-build
    $ sparrow task ini minoca/builder
    
      srcroot = /my/src/root
      debug   = dbg
      arch    = x86


    $ sparrow task run minoca/builder --param target=os

# Custom builds 

You may define custom builds with either command line parameters.


    # Build nano editor, curl and bash
    $ sparrow plg run minoca-build --param --param target=nano-2.2.6,curl-7.41.0,bash-4.3.30

Or using sparrow tasks:

    $ sparrow task add minoca gear minoca-build # build some useful tools
    $ sparrow task ini minoca/gear

      target nano-2.2.6
      target curl-7.41.0
      target bash-4.3.30
  
    $ sparrow task run minoca/gear

# Running none build targets

Usually all you need is to build a package, but if you run other some specific targets:

## Building tools

Tools are required to build all other packages, so this is probably the first thing you need to do.

Warning: building tools takes awhile when doing first time. Take your coffee ;-)

    $ sparrow plg run minoca-build --param target=all-tools   # required to build packages

## Building os

There is dedicate target for it called 'os' to build Minoca OS.

    $ sparrow plg run minoca-build --param target=os

## Rebuilding os image

Sometimes you need to rebuild os image, usually right after you get some package built:

    # Build my gear soft:
    $ sparrow plg run minoca-build --param target=nano-2.2.6,curl-7.41.0,bash-4.3.30

    # Now I need to rebuild by image 
    $ sparrow plg run minoca-build --param target=image

## Tests

    # running tests against third party Perl:
    $ sparrow plg run minoca-build --param target=perl-5.20.1-test

    # or with task:

    $ sparrow task add minoca perl-test minoca-build
    $ sparrow task ini minoca/perl-test

      target perl-5.20.1-test

    $ sparrow task run minoca/perl-test

## Clean

This target cleans some already build package, this technical equivalent of `make clean`
for given package:

    # remove nano, curl and bash objects 
    $ sparrow plg run minoca-build --param target=nano-2.2.6-clean,curl-7.41.0-clean,bash-4.3.30-clean

    # or with sparrow task

    $ sparrow task add minoca hacker-gear-clean minoca-build
    $ sparrow task ini minoca/hacker-gear-clean
      target nano-2.2.6-clean
      target curl-7.41.0-clean
      target bash-4.3.30-clean


## List available targets

To list all targets you can run:

    $ sparrow plg run minoca-build --param target=list

Or narrow list by using filter:

    $ sparrow plg run minoca-build --param target=list --param filter=gcc

## Show build log

By default all build logs gets redirected to file and only dumped out on errors.
If you want to see it use `verbose` option:

    $ sparrow plg run minoca-build --param verbose=on

## Running sequence of builds:


    $ nano tasks.json

    [
 
      {
        "task" : "os",
        "plugin" : "minoca-build",
        "data" : {
          "srcroot"   => "/src",
          "arch"      => "x86", 
          "debug"     => "dbg",
          "target"    => "os"
        }
      },
      {
        "task" : "build-nano-editor",
        "plugin" : "minoca-build",
        "data" : {
          "srcroot"   => "/src",
          "arch"      => "x86", 
          "debug"     => "dbg",
          "target"    => "nano-2.2.6"
        }
      },
      {
        "task" : "build-new-image",
        "plugin" : "minoca-build",
        "data" : {
          "srcroot"   => "/src",
          "arch"      => "x86", 
          "debug"     => "dbg",
          "target"    => "image"
        }
      }
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

    
 
