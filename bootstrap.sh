#!/bin/bash
#
# Build and install prerequisites for compiling lmserver dependencies
#
. /opt/rocks/share/devel/src/roll/etc/bootstrap-functions.sh

# Add PGDG repo for Postgresql and geospatial libs
# No opt-python for yum
module unload opt-python

yum install src/RPMS/screen-4.1.0-0.25.20120314git3c2946.el7.x86_64.rpm
yum install src/RPMS/pgdg-centos96-9.6-3.noarch.rpm 

# yumdownloader --resolve --enablerepo epel cmake3
rpm -i src/RPMS/cmake3-3.17.1-2.el7.x86_64.rpm     
rpm -i src/RPMS/cmake3-data-3.17.1-2.el7.noarch.rpm     
rpm -i src/RPMS/libuv-1.37.0-1.el7.x86_64.rpm     
rpm -i src/RPMS/libzstd-1.4.4-1.el7.x86_64.rpm
rpm -i src/RPMS/rhash-1.3.4-2.el7.x86_64.rpm

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
# yumdownloader --resolve --enablerepo=pgdg96 geos
# yumdownloader --resolve --enablerepo=pgdg96 geos-devel
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
#
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
# # for gdal-libs
rpm -i src/RPMS/CharLS-1.0-5.el7.x86_64.rpm 
rpm -i src/RPMS/SuperLU-5.2.0-5.el7.x86_64.rpm 
rpm -i src/RPMS/armadillo-8.300.0-1.el7.x86_64.rpm
rpm -i src/RPMS/arpack-3.1.3-2.el7.x86_64.rpm 
rpm -i src/RPMS/atlas-3.10.1-12.el7.x86_64.rpm 
rpm -i src/RPMS/blas-3.4.2-8.el7.x86_64.rpm 
rpm -i src/RPMS/cfitsio-3.370-10.el7.x86_64.rpm 
rpm -i src/RPMS/freexl-1.0.5-1.el7.x86_64.rpm 
rpm -i src/RPMS/geos-3.5.0-1.rhel7.1.x86_64.rpm 
rpm -i src/RPMS/hdf5-1.8.12-10.el7.x86_64.rpm
rpm -i src/RPMS/hdf5-devel-1.8.12-10.el7.x86_64.rpm
rpm -i src/RPMS/lapack-3.4.2-8.el7.x86_64.rpm 
rpm -i src/RPMS/libaec-1.0.4-1.el7.x86_64.rpm
rpm -i src/RPMS/libaec-devel-1.0.4-1.el7.x86_64.rpm
rpm -i src/RPMS/libdap-3.13.1-2.el7.x86_64.rpm 
rpm -i src/RPMS/libgeotiff-1.4.0-1.rhel7.x86_64.rpm
rpm -i src/RPMS/libgeotiff-devel-1.4.0-1.rhel7.x86_64.rpm
rpm -i src/RPMS/libgta-1.0.4-1.el7.x86_64.rpm 
rpm -i src/RPMS/libtiff-devel-4.0.3-27.el7_3.x86_64.rpm
rpm -i src/RPMS/netcdf-4.3.3.1-5.el7.x86_64.rpm 
rpm -i src/RPMS/ogdi-3.2.0-4.rhel7.1.x86_64.rpm 
rpm -i src/RPMS/openblas-openmp-0.3.3-2.el7.x86_64.rpm 
rpm -i src/RPMS/openjpeg2-2.3.1-1.el7.x86_64.rpm 
rpm -i src/RPMS/postgresql-libs-9.2.24-1.el7_5.x86_64.rpm
rpm -i src/RPMS/proj-4.8.0-4.el7.x86_64.rpm 
rpm -i src/RPMS/unixODBC-2.3.1-11.el7.x86_64.rpm 
rpm -i src/RPMS/xerces-c-3.1.1-8.el7_2.x86_64.rpm 
#  for gdal
rpm -i src/RPMS/gpsbabel-1.5.0-2.el7.x86_64.rpm
rpm -i src/RPMS/libusb-0.1.4-3.el7.x86_64.rpm
rpm -i src/RPMS/shapelib-1.3.0-2.el7.x86_64.rpm
# for postgis
rpm -i src/RPMS/CGAL-4.7-1.rhel7.1.x86_64.rpm
rpm -i src/RPMS/boost-serialization-1.53.0-27.el7.x86_64.rpm 
rpm -i src/RPMS/SFCGAL-libs-1.3.1-1.rhel7.x86_64.rpm 
rpm -i src/RPMS/SFCGAL-1.3.1-1.rhel7.x86_64.rpm 

rpm -i src/RPMS/postgis2_96-2.3.2-1.rhel7.x86_64.rpm

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

# pip, wheel for wheel installs and numpy/scipy
module load opt-python
python3.6 -m ensurepip --default-pip
pip3 install --upgrade pip
module unload opt-python


# # install newer verson of proj for gdal
cd src/proj
make prep
cd ../..
compile proj
install lifemapper-proj
/sbin/ldconfig

# gdal and dependencies 
rpm -i src/RPMS/geos-3.5.0-1.rhel7.x86_64.rpm
rpm -i src/RPMS/geos-devel-3.5.0-1.rhel7.x86_64.rpm
rpm -i src/RPMS/gdal-libs-1.11.4-12.rhel7.x86_64.rpm
# gdal and gdal-dev only for mapserver rpm build
# Build gdal from source for install
rpm -i src/RPMS/gdal-1.11.4-12.rhel7.x86_64.rpm
rpm -i src/RPMS/gdal-devel-1.11.4-12.rhel7.x86_64.rpm


# install postgresql
# yum --enablerepo base update openssl
rpm -i src/RPMS/postgresql96-libs-9.6.15-1PGDG.rhel7.x86_64.rpm
rpm -i src/RPMS/postgresql96-9.6.15-1PGDG.rhel7.x86_64.rpm
rpm -i src/RPMS/postgresql96-devel-9.6.15-1PGDG.rhel7.x86_64.rpm
rpm -i src/RPMS/postgresql96-server-9.6.15-1PGDG.rhel7.x86_64.rpm
rpm -i src/RPMS/postgresql96-contrib-9.6.15-1PGDG.rhel7.x86_64.rpm
/sbin/ldconfig  /usr/pgsql-9.6/lib/


# Leave with opt-python loaded
module load opt-python


