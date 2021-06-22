
.. highlight:: rest

Lifemapper Server roll
======================
.. contents::  

Introduction
------------
This roll installs dbserver and webserver parts of Lifemapper.
All prerequisite software listed below are a part of the roll and 
will be installed and configured during roll installation. 
The roll has been tested with Rocks 7.0.

Data 
-----
The current version of GBIF data was pulled on June 22, 2021, see metadata at 
https://www.gbif.org/occurrence/download/0309469-200613084148143 


 
TODO
----
#. add configuration for available interfaces (EML, maps)

#. add note about compiling gdal when postgres/giflib RPms are present

#. check client character encoding for postgres. Currently server is set for
   UTF8. but client appears LATIN9. See
   http://www.postgresql.org/docs/9.1/static/multibyte.html
