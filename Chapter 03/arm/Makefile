# enable these if you are cross compiling
AS=arm-linux-gnu-as
LD=arm-linux-gnu-ld
ASFLAGS=-gstabs
all: exit

exit.o: exit.s
	$(AS) -o exit.o exit.s $(ASFLAGS)

exit: exit.o
	$(LD) -o exit exit.o

clean:
	-rm *.o exit
