# fontAwesome
My Genero fontAwesome Viewer 
You can build using the GeneroStudio project file fontAwesome.4pw

On Linux you can use the makefile to build and run using the fontAwesome.4pw

![screenshot_20181109_142814](https://user-images.githubusercontent.com/16427457/48265072-d6024600-e42b-11e8-8f7d-9c8b3c7f69fd.png)


# Notes:
*IMPORTANT* Make sure you use the --recursive flag when you clone this repo, eg: On Linux
```
git clone --recursive git@github.com:neilm-fourjs/fontAwesome.git
cd fontAwesome/
. /opt/fourjs/gst310/envgenero
make
make run
history
```


The demos also uses the gl_lib repo which was added using:
* git submodule add https://github.com/neilm-fourjs/gl_lib.git gl_lib

If libraries change do:
* git submodule foreach git pull origin master

