# $Id$
#
# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 5.6 (Emerald Boa)
# 		         version 6.1 (Emerald Boa)
# 
# Copyright (c) 2000 - 2013 The Regents of the University of California.
# All rights reserved.	
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided 
# with the distribution.
# 
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement: 
# 
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
# 
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of 
# the associated name, interested parties should contact Technology 
# Transfer & Intellectual Property Services, University of California, 
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910, 
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
# 
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# @Copyright@
#
# $Log$


REDHAT.ROOT = $(CURDIR)/../../
-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

RPM.EXTRAS += "AutoReq: 0"

version.mk:
	cat ../version.mk version.mk.in > version.mk

PY.PATH = /opt/python/bin/$(PYTHONVER)
PY.INCLUDE_PATH = /opt/python/include/$(PYTHONVER)m
PY.LIBRARY = /opt/python/lib/lib$(PYTHONVER)m.so.1.0

MAPSERVERPROGS = legend \
                mapserv \
                msencrypt \
                scalebar \
                shp2img \
                shptree \
                shptreetst \
                shptreevis \
                sortshp \
                tile4ms

SEDSPEC += \
        -e 's%@ARCHIVENAME@%$(ARCHIVENAME)%g'  \
        -e 's%@VERSION@%$(VERSION)%g'  \
        -e 's%@TARBALL_POSTFIX@%$(TARBALL_POSTFIX)%g'

prepSrc.sh: prepSrc.sh.in
	$(SED) $(SEDSPEC) $^ > $@
	chmod 755 $@

prep: prepSrc.sh
	rm -rf version.mk
	make version.mk
	make prepSrc.sh
	./prepSrc.sh

build:
	tar xzf  $(ARCHIVENAME)-$(VERSION).$(TARBALL_POSTFIX)
	(\
		cd $(ARCHIVENAME)-$(VERSION); \
        	module load opt-python;       \
		export PYTHON=$(PY.PATH);     \
		mkdir build;                  \
		cp CMakeLists.txt build/;     \
		cd build;                     \
        cmake3                         			\
            -DCMAKE_INSTALL_PREFIX=$(ROOT)/$(PKGROOT)   \
            -DCMAKE_INSTALL_LIBDIR=$(PKGROOT)/lib   	\
            -DCMAKE_PREFIX_PATH=$(ROOT):$(PKGROOT):$(PKGROOT)/bin:/usr/lib64:$(PATH)  \
            -DPYTHON_EXECUTABLE=$(PY.PATH)          	\
            -DPYTHON_INCLUDE_PATH=$(PY.INCLUDE_PATH)    \
    		-DPYTHON_LIBRARIES=$(PY.LIBRARY)	\
            -DWITH_GEOS=1           \
            -DWITH_PROJ=$(PKGROOT)  \
            -DPROJ_LIBRARY=$(PKGROOT)/lib/libproj.so   \
            -DWITH_GDAL=1           \
            -DWITH_PROTOBUFC=0      \
            -DWITH_WMS=1            \
            -DWITH_FRIBIDI=0        \
            -DWITH_HARFBUZZ=0       \
            -DWITH_ICONV=0          \
            -DWITH_CAIRO=0          \
            -DWITH_FCGI=0           \
            -DWITH_POSTGIS=0        \
            -DWITH_OGR=1            \
            -DWITH_WFS=0            \
            -DWITH_WCS=1            \
            -DWITH_LIBXML2=1        \
            -DWITH_GIF=1            \
            -DWITH_KML=1            \
            -DWITH_PYTHON=1   \
            ../ >../configure.out.txt;    	\
		make ;  			\
		cp ../mapscript/python/README.rst mapscript/python/; \
		cd mapscript/python;		\
		$(PY.PATH) setup.py build; 	\
		module unload opt-python;	\
	)

install::
	mkdir -p $(ROOT)/$(PKGROOT)/bin
	mkdir -p $(ROOT)/$(PKGROOT)/sbin
	mkdir -p $(ROOT)/$(PKGROOT)/lib
	mkdir -p $(ROOT)/$(PKGROOT)/rocks/etc
	(\
	    cp -p $(PY.LIBRARY) $(ROOT)/$(PKGROOT)/lib/;       \
        export PYTHON=$(PY.PATH);                             \
        export PATH=$(ROOT):$(PKGROOT)/bin:$(PATH);           \
        cd $(ARCHIVENAME)-$(VERSION)/build;	\
        $(INSTALL) $(MAPSERVERPROGS) $(ROOT)/$(PKGROOT)/bin;  \
        $(INSTALL) mapserv $(ROOT)/$(PKGROOT)/sbin;           \
        $(INSTALL) libmapserver.so.$(VERSION) $(ROOT)/$(PKGROOT)/lib;  \
        cd mapscript/python;                      \
        module load opt-python;                   \
        $(PY.PATH) setup.py $@ --root=$(ROOT)/;   \
        module unload opt-python;                 \
	)

clean::
	rm -rf $(ARCHIVENAME)-$(VERSION) version.mk prepSrc.sh

