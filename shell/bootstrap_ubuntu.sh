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
if [ ! -f /opt/run_once ]
then
  apt-get -f

  #Dependencies for the old version of ubuntu
  apt-get -y install git m4 build-essential autoconf apache2-threaded-dev \
  libxml2-dev libcurl4-gnutls-dev libtool apache2

  #Install necessary bison version
  wget http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb
  wget http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb
  dpkg -i libbison-dev_2.7.1.dfsg-1_amd64.deb
  dpkg -i bison_2.7.1.dfsg-1_amd64.deb


  #Download PHP
  cd /usr/src
  #This [--depth 1 --branch PHP-5.6] will download the needed data much faster
  git clone --depth 1 --branch PHP-5.6 https://github.com/php/php-src
  cd php-src

  #Download pthreads
  cd ext
  git clone --depth 1 https://github.com/krakjoe/pthreads
  cd ../

  #NEED THIS (check README)
  #mkdir -p /etc/apache2/mods-available
  #chmod 644 /etc/apache2/mods-available

  #Compile
  ./buildconf --force
  sudo ./configure --prefix=/opt/php-zts --with-config-file-path=/opt/php-zts/etc \
  --enable-maintainer-zts --with-apxs2=/usr/bin/apxs --with-mysql --with-mysqli \
  --with-curl --with-zlib --enable-pthreads --enable-mbstring
  make -j8
  make install
  libtool --finish /usr/src/php-src/libs
  echo "extension=pthreads.so" > /opt/php-zts/modules.d/pthreads.ini

  #Symlinks
  ln -s /opt/php-zts/bin/php /usr/local/bin/php-zts
  ln -s /opt/php-zts/bin/phpize /usr/local/bin/phpize-zts
  ln -s /opt/php-zts/bin/php-config /usr/local/bin/php-config-zts
  ln -s /opt/php-zts/bin/php-cgi /usr/local/bin/php-cgi-zts
  ln -s /opt/php-zts/bin/phpdbg /usr/local/bin/phpdbg-zts

  touch /opt/run_once
fi
