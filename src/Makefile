TOOLPATH = ../z_tools/
INCPATH  = ../z_tools/haribote/

MAKE     = $(TOOLPATH)make.exe -r
EDIMG    = $(TOOLPATH)edimg.exe
IMGTOL   = $(TOOLPATH)imgtol.com
COPY     = copy
DEL      = del

default :
	$(MAKE) img

haribote.img : haribote/ipl10.bin haribote/haribote.sys Makefile \
		beep/beep.hrb \
		timer/timer.hrb \
		primer/primer.hrb
	$(EDIMG)   imgin:../z_tools/fdimg0at.tek \
		wbinimg src:haribote/ipl10.bin len:512 from:0 to:0 \
		copy from:haribote/haribote.sys to:@: \
		copy from:haribote/ipl10.nas to:@: \
		copy from:beep/beep.hrb to:@: \
		copy from:timer/timer.hrb to:@: \
		copy from:primer/primer.hrb to:@: \
		imgout:haribote.img

img :
	$(MAKE) -C haribote
	$(MAKE) -C apilib
	$(MAKE) -C beep
	$(MAKE) -C timer
	$(MAKE) -C primer
	$(MAKE) haribote.img

run :
	$(MAKE) img
	$(COPY) haribote.img ..\z_tools\qemu\fdimage0.bin
	$(MAKE) -C ../z_tools/qemu

clean :
	$(MAKE) -C haribote		clean
	$(MAKE) -C apilib		clean
	$(MAKE) -C beep 		clean
	$(MAKE) -C timer		clean
	$(MAKE) -C primer		clean
	-$(DEL) haribote.img