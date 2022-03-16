default :
	../tools/make.exe img

ipl.bin : ipl.nas Makefile
	../tools/nask.exe ipl.nas ipl.bin

myOS.img : ipl.bin Makefile
	../tools/edimg.exe    imgin:../tools/fdimg0at.tek   wbinimg src:ipl.bin len:512 from:0 to:0    imgout:myOS.img

asm :
	../tools/make.exe -r ipl.bin

img :
	../tools/make.exe -r myOS.img

run :
	../tools/make.exe img
	copy myOS.img ..\tools\qemu\image.bin
	../tools/make.exe -C ../tools/qemu

clean :
	-del ipl.bin
	-del myOS.img