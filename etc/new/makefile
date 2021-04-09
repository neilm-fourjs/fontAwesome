# Automatic Makefile made by make4js by N.J.M.

fgl_obj2 =  \
	 fa5.$(4GLOBJ)

fgl_obj1 =  \
	 gmdi.$(4GLOBJ)

fgl_frm1 = 

#depend::
#	echo "making depends";  cd lib ; ./link_lib

PRG2=fa5.42r
PRG1=gmdi.42r

include ./Make_fjs.inc

Font-Awesome:
	git clone git@github.com:FortAwesome/Font-Awesome.git

material-design-icons:
	git clone git@github.com:google/material-design-icons.git

update:
	cd Font-Awesome && git pull
	cd material-design-icons && git pull
	fglrun fa5.42r
	cp fa5.txt ..
	cp Font-Awesome/webfonts/fa-brands-400.ttf ..
	cp Font-Awesome/webfonts/fa-regular-400.ttf ..
	cp Font-Awesome/webfonts/fa-solid-900.ttf ..

