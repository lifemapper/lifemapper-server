#!/bin/bash
#
# Build and install prerequisites for compiling lmserver dependencies
#
. /opt/rocks/share/devel/src/roll/etc/bootstrap-functions.sh

# EPEL repo 7.9 is installed in Rocks 7 by default

# enable repo for postgresql and postgis2 rpms
# since using RHEL 6 repo for release version 7, edit repo to point to 6
#     /etc/yum.repos.d/pgdg-91-centos.repo
(cd src/RPMS; 
PGDGREPO=pgdg-centos91-9.1-4.noarch.rpm
wget http://yum.postgresql.org/9.1/redhat/rhel-6-x86_64/$PGDGREPO
rpm -i $PGDGREPO
)

# replace defunct rpmforge repo for hdf4, hdf5 rpms
# since using RHEL 6 repo for release version 7, edit repo to point to 6
#     /etc/yum.repos.d/pgdg-91-centos.repo
(cd src/RPMS; 
RPMFORGEREPO=rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
wget http://ftp.tu-chemnitz.de/pub/linux/dag/redhat/el6/en/x86_64/rpmforge/RPMS/$RPMFORGEREPO
rpm -Uvh $RPMFORGEREPO
)

#do this only once for roll distro to keep known RPMS in the roll src
#(cd src/RPMS; 
#wget http://li.nux.ro/download/nux/dextop/el7/x86_64//bitstream-vera-fonts-common-1.10-19.el7.nux.noarch.rpm; \
#wget http://li.nux.ro/download/nux/dextop/el7/x86_64//bitstream-vera-sans-fonts-1.10-19.el7.nux.noarch.rpm; \

### elgis repo is belly up
#yumdownloader --resolve --enablerepo epel fcgi.x86_64; \
#yumdownloader --resolve --enablerepo epel fribidi.x86_64; \
#yumdownloader --resolve --enablerepo epel mapserver.x86_64; \
#
#yumdownloader --resolve --enablerepo pgdg91 postgresql91.x86_64; \
#yumdownloader --resolve --enablerepo pgdg91 postgresql91-devel.x86_64; \
#yumdownloader --resolve --enablerepo pgdg91 postgresql91-server.x86_64; \
#yumdownloader --resolve --enablerepo pgdg91 postgresql91-docs.x86_64; \
#yumdownloader --resolve --enablerepo pgdg91 postgresql91-python.x86_64; \
#yumdownloader --resolve --enablerepo pgdg91 postgresql91-contrib.x86_64; \
#yumdownloader --resolve --enablerepo pgdg91 postgresql91-test.x86_64; \
#yumdownloader --resolve --enablerepo pgdg91 pgbouncer.x86_64; \
#yumdownloader --resolve --enablerepo pgdg91 postgis2_91.x86_64; \
#
### hdf libs are in updated rpmforge repo
#yumdownloader --resolve --enablerepo rpmforge hdf4.x86_64 hdf4-devel.x86_64; \
#yumdownloader --resolve --enablerepo rpmforge hdf5.x86_64 hdf5-devel.x86_64; \
#
#yumdownloader --resolve --enablerepo base byacc.x86_64; \
#yumdownloader --resolve --enablerepo base screen.x86_64; \
#)

# add dynamic libs
## No longer using java roll with /usr/java/latest/jre
echo "/etc/alternatives/jre/lib/amd64" > /etc/ld.so.conf.d/lifemapper-server.conf
echo "/etc/alternatives/jre/lib/amd64/server" >> /etc/ld.so.conf.d/lifemapper-server.conf
echo "/opt/lifemapper/lib" >> /etc/ld.so.conf.d/lifemapper-server.conf
echo "/opt/python/lib/" >> /etc/ld.so.conf.d/lifemapper-server.conf
# echo "/opt/rocks/fcgi/lib" >> /etc/ld.so.conf.d/lifemapper-server.conf
/sbin/ldconfig

rpm -i src/RPMS/screen*rpm

# cmake already installed and up-to-date
# yum --enablerepo base install cmake

# for mapserver
module unload opt-python
yum -y install giflib-devel

module load opt-python
compile proj
module unload opt-python

install lifemapper-proj
yum -y install gd-devel
rpm -i src/RPMS/bitstream-vera-fonts-common-1.10-19.el7.nux.noarch.rpm
rpm -i src/RPMS/bitstream-vera-sans-fonts-1.10-19.el7.nux.noarch.rpm

# for mysql-python, rtree, cherrypy
# setuptools 6.1, included in python roll
# setuptools 20.7, needed for cherrypy build (on devapp, not in LM install)
module load opt-python
(cd src/setuptools; /opt/python/bin/python2.7 setup.py install)

# for cherrypy
# cheroot requires six
# tempora requires six, pytz
# portend requires tempora
# cherrypy requires six, cheroot>=5.2.0, portend>=1.6.1
module load opt-python
compile six
module unload opt-python
install opt-lifemapper-six

module load opt-python
compile cheroot
module unload opt-python
install opt-lifemapper-cheroot

module load opt-python
compile pytz
module unload opt-python
install opt-lifemapper-pytz

module load opt-python
compile tempora
module unload opt-python
install opt-lifemapper-tempora

module load opt-python
compile portend
module unload opt-python
install opt-lifemapper-portend

# for pytables 
module load opt-python
compile cython 
module unload opt-python
install opt-lifemapper-cython 

module load opt-python
compile numexpr 
module unload opt-python
install opt-lifemapper-numexpr 
rpm -i src/RPMS/hdf5*rpm

# meed for gdal
module load opt-python
compile geos
module unload opt-python
install lifemapper-geos
/sbin/ldconfig

# meed for psycopg2
module load opt-python
compile gdal
module unload opt-python
install lifemapper-gdal
/sbin/ldconfig

# for rtree
module load opt-python
compile spatialindex
module unload opt-python
install lifemapper-spatialindex
/sbin/ldconfig


# install postgresql
yum --enablerepo base update openssl
yum -y install postgresql91
yum -y install postgresql91-devel

echo "You will need to checkout Lifemapper src from Github:"
echo "    cd src/lmserver"
echo "    make prep "
echo "then download data from Lifemapper:"
echo "    cd src/lmdata-env"
echo "    make prep "
echo "    cd src/lmdata-species"
echo "    make prep "
echo "then download Solr source code:"
echo "    cd src/solr"
echo "    make prep "
echo "finally download CCTools source code:"
echo "    cd src/cctools"
echo "    make prep "
echo "and DendroPy source code:"
echo "    cd src/dendropy"
echo "    make prep "

