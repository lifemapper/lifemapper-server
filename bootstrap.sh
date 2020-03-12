#!/bin/bash
#
# Build and install prerequisites for compiling lmserver dependencies
#
. /opt/rocks/share/devel/src/roll/etc/bootstrap-functions.sh

# Add PGDG repo for Postgresql and geospatial libs
# No opt-python for yum
module unload opt-python
yum install src/RPMS/screen-4.1.0-0.25.20120314git3c2946.el7.x86_64.rpm
yum install src/RPMS/pgdg-centos96-9.6-3.noarch.rpm epel-release
yum install cmake
yum update

### do this only once for roll distro to keep known RPMS in the roll src
#cd src/RPMS
# yumdownloader --resolve --enablerepo base screen.x86_64

# wget http://li.nux.ro/download/nux/dextop/el7/x86_64/bitstream-vera-fonts-common-1.10-19.el7.nux.noarch.rpm
# wget http://li.nux.ro/download/nux/dextop/el7/x86_64/bitstream-vera-sans-fonts-1.10-19.el7.nux.noarch.rpm
#
## for postgresql9.6 and postgis2 rpms
# wget https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
#
## for gdal
# yumdownloader --resolve --enablerepo epel libaec.x86_64  libaec-devel.x86_64
# yumdownloader --resolve --enablerepo epel hdf5.x86_64 hdf5-devel.x86_64
## for postgis
# yumdownloader --resolve --enablerepo epel proj.x86_64
## for mapserver
# yumdownloader --resolve --enablerepo base giflib-devel.x86_64
#
## Add PostgreSQL 9.6, devel, server, python
# yumdownloader --resolve --enablerepo=pgdg96 postgresql96
# yumdownloader --resolve --enablerepo=pgdg96 postgresql96-server 
# yumdownloader --resolve --enablerepo=pgdg96 postgresql96-contrib 
# yumdownloader --resolve --enablerepo=pgdg96 postgresql96-devel 
# yumdownloader --resolve --enablerepo=pgdg96 postgresql96-plpython
#
## Add postgis 
# yumdownloader --resolve --enablerepo=pgdg96 boost-serialization
# for gdal-libs
# yumdownloader --resolve --enablerepo=epel libdap 
# yumdownloader --resolve --enablerepo=epel CharLS  
# yumdownloader --resolve --enablerepo=epel cfitsio
# yumdownloader --resolve --enablerepo=epel freexl 
# yumdownloader --resolve --enablerepo=epel libgta 
# yumdownloader --resolve --enablerepo=epel netcdf 
# yumdownloader --resolve --enablerepo=epel openjpeg2 
## armadillo brings arpack, atlas, blas, lapack, hdf5, SuperLU, openblas-openmp
# yumdownloader --resolve --enablerepo epel  armadillo

# yumdownloader --resolve --enablerepo=pgdg96 postgis2_96
#
## Add postgresql-python connector
# yumdownloader --resolve --enablerepo=pgdg96 python2-psycopg2.x86_64

## Add pgbouncer from PGDG and dependency c-ares from epel and base repos
# yumdownloader --resolve --enablerepo=base c-ares.x86_64
# yumdownloader --resolve --enablerepo=base c-ares-devel.x86_64
# yumdownloader --resolve --enablerepo=pgdg96 pgbouncer
#
# for gdal
rpm -i src/RPMS/libaec-1.0.4-1.el7.x86_64.rpm
rpm -i src/RPMS/libaec-devel-1.0.4-1.el7.x86_64.rpm
rpm -i src/RPMS/hdf5-1.8.12-10.el7.x86_64.rpm
rpm -i src/RPMS/hdf5-devel-1.8.12-10.el7.x86_64.rpm

# for pgbouncer
rpm -i src/RPMS/c-ares-1.10.0-3.el7.x86_64.rpm
rpm -i src/RPMS/c-ares-devel-1.10.0-3.el7.x86_64.rpm

# for mapserver
module unload opt-python
# gd-devel pulls libXpm-devel also
yum --enablerepo base install gd-devel
rpm -i src/RPMS/bitstream-vera-fonts-common-1.10-19.el7.nux.noarch.rpm
rpm -i src/RPMS/bitstream-vera-sans-fonts-1.10-19.el7.nux.noarch.rpm
rpm -i src/RPMS/giflib-devel-4.1.6-9.el7.x86_64.rpm

# add dynamic libs
echo "/etc/alternatives/jre/lib/amd64" > /etc/ld.so.conf.d/lifemapper-server.conf
echo "/etc/alternatives/jre/lib/amd64/server" >> /etc/ld.so.conf.d/lifemapper-server.conf
echo "/opt/lifemapper/lib" >> /etc/ld.so.conf.d/lifemapper-server.conf
echo "/opt/python/lib/" >> /etc/ld.so.conf.d/lifemapper-server.conf
# echo "/opt/rocks/fcgi/lib" >> /etc/ld.so.conf.d/lifemapper-server.conf
/sbin/ldconfig

# # add newer version of chardet for requests dependency
# cd src/chardet
# make prep
# cd ../..
# module load opt-python
# compile chardet
# module unload opt-python
# install opt-lifemapper-chardet
# /sbin/ldconfig

# install proj, tiff, geos for gdal
cd src/proj
make prep
cd ../..
compile proj
install lifemapper-proj
/sbin/ldconfig

cd src/tiff
make prep
cd ../..
compile tiff
install lifemapper-tiff
/sbin/ldconfig

cd src/geos
make prep
cd ../..
compile geos
install lifemapper-geos
/sbin/ldconfig

cd src/gdal
make prep
cd ../..
module load opt-python
compile gdal
module unload opt-python
install lifemapper-gdal
/sbin/ldconfig

# install postgresql
# yum --enablerepo base update openssl
rpm -i src/RPMS/postgresql96-libs-9.6.15-1PGDG.rhel7.x86_64.rpm
rpm -i src/RPMS/postgresql96-9.6.15-1PGDG.rhel7.x86_64.rpm
rpm -i src/RPMS/postgresql96-devel-9.6.15-1PGDG.rhel7.x86_64.rpm
rpm -i src/RPMS/postgresql96-server-9.6.15-1PGDG.rhel7.x86_64.rpm
rpm -i src/RPMS/postgresql96-contrib-9.6.15-1PGDG.rhel7.x86_64.rpm
/sbin/ldconfig  /usr/pgsql-9.6/lib/
      

# TODO: Upgrade cherrypy to 17.4.2 and prepSrc on it and build dependencies
# cherrypy 17.4.2 requires six>=1.11.0, cheroot>=6.2.4, portend>=2.1.1, 
#                    and for exec, not build:
#                          more-itertools=5.0.0 
#                          contextlib2==0.6.0.post1
#                          zc.lockfile=2.0
#                          backports.functools_lru_cache=1.6.1
#                          jaraco.functools=2.0
# cheroot requires six and setuptools
# portend requires tempora requires six, pytz

# setuptools needed for cheroot build (on devapp, not in LM install?)
cd src/setuptools
module load opt-python
unzip setuptools-46.0.0.zip
cd setuptools-46.0.0
/opt/python/bin/python3.6 setup.py install
cd ../../..
module unload opt-python

cd src/six
make prep
cd ../..
module load opt-python
compile six
module unload opt-python
install opt-lifemapper-six
/sbin/ldconfig

cd src/cheroot
make prep
cd ../..
module load opt-python
compile cheroot
module unload opt-python
install opt-lifemapper-cheroot
/sbin/ldconfig

cd src/pytz
make prep
cd ../..
module load opt-python
compile pytz
module unload opt-python
install opt-lifemapper-pytz
/sbin/ldconfig

cd src/tempora
make prep
cd ../..
module load opt-python
compile tempora
module unload opt-python
install opt-lifemapper-tempora
/sbin/ldconfig

cd src/portend
make prep
cd ../..
module load opt-python
compile portend
module unload opt-python
install opt-lifemapper-portend
/sbin/ldconfig

# Leave with opt-python loaded
module load opt-python


echo "You will need to download source code, data and dependencies."
echo "    lmserver"
echo "    webclient"
echo "    lmdata-env"
echo "    lmdata-image"
echo "    lmdata-species"
echo "    solr"
echo "    cctools"
echo "    dendropy"
echo "Go to each of the packages and execute:"
echo "    make prep"

