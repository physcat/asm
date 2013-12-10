# enable these if you are cross compiling
AS=arm-linux-gnu-as
LD=arm-linux-gnu-ld
ASFLAGS=-gstabs
all: exit helloworld


exit.o: exit.s
	$(AS) -o exit.o exit.s $(ASFLAGS)

exit: exit.o
	$(LD) -o exit exit.o


helloworld.o: helloworld.s
	$(AS) -o helloworld.o helloworld.s

helloworld: helloworld.o
	$(LD) -o helloworld helloworld.o

clean:
	-rm *.o exit helloworld
