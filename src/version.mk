PKGROOT			= /opt/lifemapper
LMHOME			= /opt/lifemapper
MAPSERVER_TMP	= /var/www/tmp
LMURL			= http://yeti.lifemapper.org/dl
LMSERVERDISK	= /share/lmserver
LMDISK			= /share/lm

## DATADIR_SHARED is identical in the lifemapper-compute roll
DATADIR_SHARED  = /share/lm/data

DATADIR_SERVER  = /share/lmserver/data
LMSCRATCHDISK	= /state/partition1/lmscratch

ENV_DATA_DIR		= layers
SPECIES_DATA_DIR	= species

PYTHONVER			= python3.6
PYTHON36			= /opt/python/bin/$(PYTHONVER)
PYTHON36_PACKAGES	= /opt/python/lib/$(PYTHONVER)/site-packages
PGSQLVER			= 9.6
UNIXSOCKET			= /var/run/postgresql
SMTPSERVER			= localhost
SMTPSENDER			= no-reply-lifemapper@@PUBLIC_FQDN@
JAVABIN				= /etc/alternatives/java

# Top directory of the current webclient and metrics dashboard client
LMCLIENT			= biotaphy
DASHBOARD			= lmdashboard
# Top dir for the Results Package code
PACKAGING_DIR       = LmWebServer/assets/gridset_package

# SCENARIO_PACKAGE matches SCENARIO_PACKAGE in the lifemapper-compute roll
# and lifemapper-env-data rpm in both rolls
SCENARIO_PACKAGE	= 10min-past-present-future
ECOREGION_LAYER		= ecoreg_10min_global

EPSG				= 4326
MAPUNITS			= dd

PUBLIC_USER			= kubi

GBIF_TAXONOMY		= gbif_taxonomy
GBIF_OCCURRENCES	= gbif_occ_subset
GBIF_PROVIDER		= gbif_orgs
GBIF_VERSION        = 2020.12.12
# GBIF_VERSION        = 2021.03.23

GRID_NAME				= lmgrid_1d
GRID_CELLSIZE			= 1
GRID_NUM_SIDES			= 4

# Code version
LMCODE_VERSION			  = 3.4.9.p3
LMVIZ_VERSION            = 2.3.1



