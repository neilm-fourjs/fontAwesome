# fontAwesome
My Genero fontAwesome Viewer 
You can build using the GeneroStudio project file fontAwesome.4pw
This demo includes files for fontAwesome 5.0 and Google Material Design

This demos also uses the g2_lib for the library code, so make sure to also check that out.

# Font Awesome 4.7 ( Supplied with Genero )
* https://fontawesome.com/v4.7.0/cheatsheet/

# Font Awesome 5
* https://fontawesome.com/icons?d=gallery&p=2&m=free
* https://fontawesome.com/cheatsheet

#Google Material Design:
* https://fonts.google.com/icons?selected=Material+Icons
* https://github.com/google/material-design-icons/tree/master/font


On Linux you can use the makefile to build and run using the fontAwesome.4pw

* Screenshot showing default fontAwesome 4.7
![screenshot_20181109_142814](https://user-images.githubusercontent.com/16427457/48265072-d6024600-e42b-11e8-8f7d-9c8b3c7f69fd.png)

* Screenshot showing Google Material Design font ( using Genero V4.00 EAP version )
![Screenshot_20210329_153605](https://github.com/neilm-fourjs/fontAwesome/blob/master/screenshots/Screenshot_20210329_153605.png)

# Building on Linux
Set the Genero Environment then:
```
git clone git@github.com:neilm-fourjs/g2_lib.git
cd g2_lib
git checkout g400
cd ..
git clone git@github.com:neilm-fourjs/fontAwesome.git
cd fontAwesome/
make
make run
```
