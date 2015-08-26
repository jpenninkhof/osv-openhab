OSv OpenHab
===========

This project aims to run OpenHab as an OSv Unikernel and is using Capstan to build OSv images.

OpenHab is a vendor and technology agnostic open source automation software for your home.

Build
-----

To build an OSv image of OpenHab, just clone this repository first. After cloning run

`capstan build -v -m 1024M`

This should build the OSv image. 

Run
---

To try it out, run

`capstan run -f 1880:80`

After having started the image, you should be able to browse to http://localhost:1880 and be greeted by OpenHab's user interface

Note
----

Please note that OpenHab relies on configuration files that need to be present on the image. If you want to run this Unikernel, it is best to fork it, include your configuration files in the build process and then spin it up (at least, this is how I work with this Unikernel ;). 
