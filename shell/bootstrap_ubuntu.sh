#!/bin/sh
#INSTALL isolated PHP 5.6 ZTS (Thread-safe) with pthreads on Ubuntu

#Once every restart
if [ ! -f /tmp/updated ]
then
  apt-get update
  apt-get upgrade --assume-yes
  apt-get autoremove --assume-yes
  touch /tmp/updated
fi

#Once
if [! -f /opt/run_once ]
  #Install necessary bison version
  wget http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb
  wget http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb
  dpkg -i libbison-dev_2.7.1.dfsg-1_amd64.deb
  dpkg -i bison_2.7.1.dfsg-1_amd64.deb


  #Download PHP
  cd /usr/src
  git clone https://github.com/php/php-src
  cd php-src

  #Optionally check out speicific branch
  git checkout PHP-5.6

  #Download pthreads
  cd ext
  git clone https://github.com/krakjoe/pthreads
  cd ../

  #Compile
  ./buildconf --force
  ./configure --prefix=/opt/php-zts --with-config-file-path=/opt/php-zts/etc --enable-maintainer-zts --with-apxs2=/usr/bin/apxs --with-mysql --with-mysqli --with-curl --with-zlib --enable-pthreads --enable-mbstring
  make -j8
  make install
  echo "extension=pthreads.so" > /opt/php-zts/modules.d/pthreads.ini


  #Symlinking
  ln -s /opt/php-zts/bin/php /usr/local/bin/php-zts
  ln -s /opt/php-zts/bin/phpize /usr/local/bin/phpize-zts
  ln -s /opt/php-zts/bin/php-config /usr/local/bin/php-config-zts
  ln -s /opt/php-zts/bin/php-cgi /usr/local/bin/php-cgi-zts
  ln -s /opt/php-zts/bin/phpdbg /usr/local/bin/phpdbg-zts

  touch /opt/run_once
fi
