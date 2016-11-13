# SYNOPSIS

Minoca OS builder.


# INSTALL

    $ sparrow plg install minoca-build


# USAGE


    $ sparrow plg run minoca-build --param action=build-os # build minoca OS
    $ sparrow plg run minoca-build --param action=build-perl-5.20.1 # build Perl package
    $ sparrow plg run minoca-build --param action=show-targets # show available build targets
    $ sparrow plg run minoca-build --param action=test-perl-5.20.1 # test Perl package

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

    $ sparrow plg run minoca-build --param srcroot=/path/to/srcroot/ --param action=build-os

Or ( probably better as could be set once ) create a sparrow task:

    $ sparrow project create minoca
    $ sparrow task add minoca builder minoca-build
    $ sparrow task ini minoca/builder
    
    srcroot=/my/src/root
    debug=dbg
    arch=x86


    $ sparrow task run minoca/builder --param action=build-os

# Author

[Alexey Melezhik](mailto:melezhik@gmail.com)
  

# See also

[Minoca OS Project](http://minocacorp.com/)

    
 
