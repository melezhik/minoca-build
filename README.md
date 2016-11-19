# SYNOPSIS

Minoca OS builder.


# INSTALL

    $ sparrow plg install minoca-build


# USAGE


    $ sparrow plg run minoca-build --param target=build-os # build minoca OS
    $ sparrow plg run minoca-build --param target=build-perl-5.20.1 # build Perl package
    $ sparrow plg run minoca-build --param target=test-perl-5.20.1 # test Perl package
    $ sparrow plg run minoca-build --param target=build-perl-5.20.1,test-perl-5.20.1 # build and test 
    $ sparrow plg run minoca-build --param target=show-targets # show available targets list

# Custom configuration

These setting should be defined or plugin use default values:

    +----------------------+---------------------------+
    | Variable             | Default Value             |
    +----------------------+---------------------------+
    | SRCROOT              | /src                      |
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

As sparrow is flexible tool with out of the box configuration facilities you may create a custom Minoca builds upon it:


## Build a dedicated packages:


    # using plg run command:
    $ sparrow plg run minoca-build --param target=build-os,build-perl-5.20.1,build-nginx-1.10.1
    $ sparrow plg run minoca-build --param target=build-perl-5.20.1,test-perl-5.20.1

    # using task:

    $ sparrow task add minoca lamp minoca-build # Linux/Apache/Mysql/Perl stack
    $ sparrow task ini minoca/lamp

      target build-httpd-2.4.0
      target build-perl-5.20.1
      target build-mysql-5.7.13

    $ sparrow task run minoca/lamp

## Running tests

    # using plg run command:
    $ sparrow plg run minoca-build --param targets=test-perl-5.20.1,test-nginx-1.10.1


    # using task:

    $ sparrow task add minoca lamp-test minoca-build # Linux/Apache/Mysql/Perl stack
    $ sparrow task ini minoca/lamp-test

     target test httpd-2.4.0
     target test perl-5.20.1
     target test mysql-5.7.13

    $ sparrow task run minoca/lamp-test

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
          "target"    => "build-os"
        }
      },
      {
        "task" : "build-perl",
        "plugin" : "minoca-build",
        "data" : {
          "srcroot"   => "/src",
          "arch"      => "x86", 
          "debug"     => "dbg",
          "action"    => "build-perl-5.20.1"
        }
      },
 
    ]

    $ sparrow box run tasks.json


## Running by cron

With `--cron` flag sparrow suppress a normal output and only emit report on unsuccessful exit code

    $ sparrow task run minoca/lamp-test --cron

## Running builds by ssh

Take a look at [Sparrowdo](http://github.com/melezhik/sparrowdo/) - tool to run sparrow plugins over ssh ( and even more! ).


# Author

[Alexey Melezhik](mailto:melezhik@gmail.com)
  

# See also

[Minoca OS Project](http://minocacorp.com/)

    
 
