#!/bin/bash

# Setup Ubuntu 12.04 developer desktop
#
# Copyright (C) 2015 Sergey Kolevatov
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

repos=( stefansundin/truecrypt libreoffice/ppa ondrej/php5-oldstable ubuntu-toolchain-r/test )
apps=( mc subversion workrave redshift gtk-redshift gnome-panel openjdk-7-jre compizconfig-settings-manager secure-delete truecrypt encfs libreoffice curl rabbitvcs-nautilus3 colordiff aha
    php-pear php5-cli php5-common php5-curl php5-dev php5-gd php5-mcrypt php5-mysql php5-pgsql php5-xdebug
    mysql-server
    gcc-4.8 g++-4.8 )

source "install_ubuntu_package_incl.sh"

setup repos[@] apps[@]

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50
