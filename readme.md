# dpkg [Python 3.x](https://www.python.org/)

Unfortunately raspbian has old packages and the linux distro model is to move
slow and not update things. Unfortunately linux homebrew doesn't always work
(I use homebrew on macOS and it is awesome!) on linux.

# What this does

This package installs to `/home/pi/.local` and doesn't interact with normal debian
packages from Raspbian. You can install by:

1. Add `export PATH=/home/pi/.local/bin:$PATH` to your `bash_profile`
2. Install package with: `sudo dpkg -i kevin-python-3.x.x.deb` where 3.x.x is the current version
3. You will most likely need to login again to the `PATH` correction from step 1 takes effect

## Package Setup

- DEBIAN
    - control (required)
    - templates (optional)
    - preinst (optional, chmod 0755)
    - postinst (optional, chmod 0755)
    - prerm (optional, chmod 0755)
    - postrm (optional, chmod 0755)

 where:

**preinst** – this script executes before that package will be unpacked from its Debian archive (“.deb”) file. Many ‘preinst’ scripts stop services for packages which are being upgraded until their installation or upgrade is completed (following the successful execution of the ‘postinst’ script).

**postinst** – this script typically completes any required configuration of the package foo once it has been unpacked from its Debian archive (“.deb”) file. Often ‘postinst’ scripts ask the user for input, and/or warn the user that if they accept the default values, they should remember to go back and re-configure that package as the situation warrants. Many ‘postinst’ scripts then execute any commands necessary to start or restart a service once a new package has been installed or upgraded.

**prerm** – this script typically stops any daemons which are associated with a package. It is executed before the removal of files associated with the package.

**postrm** – this script typically modifies links or other files associated with foo, and/or removes files created by the package.

# Build the Package

Get the current Python number from: www.python.org

You should be able to use the package already built in this
repo, but if you want/need to build it, do:

	./update-python.sh
	./build-python.sh 3.7.0
	./build-pkg.sh 3.7.0

Note, you pass the version number to `build-python.sh` so it downloads the version you want
and you pass it `build-pkg.sh` so it gets appended onto the packages name. After, running
the above commands, you should now have a shiny new debian package.

## Check

You can double check your package with: `dpkg-deb --info <deb file>`

```bash
pi@multiped python $ dpkg-deb --info python-3.7.0.deb
 new debian package, version 2.0.
 size 28513140 bytes: control archive=612 bytes.
     145 bytes,     7 lines   *  control              
     288 bytes,    10 lines   *  copyright            
       6 bytes,     1 lines   *  install              
     463 bytes,    24 lines   *  postinst             #!/bin/bash
 Package: python3
 Architecture: all
 Maintainer: Kevin
 Depends: debconf (>= 0.5.00)
 Priority: optional
 Version: 3.7.0
 Description: Kevins python 3
 ```

# Install the Package

Make sure to run update python script so you have the right libraries installed and setup.

	./update-python.sh
	sudo dpkg -i libopencv3.4.0.deb

## References

- [Package setup details](https://www.leaseweb.com/labs/2013/06/creating-custom-debian-packages/)


# Licenses


## MIT License for build scripts

Copyright (c) 2016 Kevin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Documentation

 <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" align="middle"/></a><br />This documentation is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
