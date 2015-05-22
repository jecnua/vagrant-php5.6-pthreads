vagrant-php5.6-pthreads
=======================

Vagrant machine for php5.6 recompiled with pthreads

##Source

The original source is this [bash script](https://gist.github.com/jnardiello/ba6c41f7434ffd906de6)

This has been slightly modified to work with this version of ubuntu (older).
Also the clone are depth 1 (faster).

This [article](http://blog.thecybershadow.net/2013/01/25/installing-php-and-apache-module-under-home/)
have a lot of information about the pitfall of compiling php.

##To run

    $ vagrant up --provider=virtualbox

##Test results

    $ /opt/php-zts/bin/php --version

##Notes

Memory 1024MB is not enough.

    ==> pthreads01: virtual memory exhausted: Cannot allocate memory

So I put 2048.
