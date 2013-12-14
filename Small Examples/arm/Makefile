# enable these if you are cross compiling
AS=arm-linux-gnu-as
LD=arm-linux-gnu-ld
ASFLAGS=-gstabs
all: hello

hello.o: hello.s
	$(AS) -o hello.o hello.s

hello: hello.o
	$(LD) -o hello hello.o

clean:
	-rm *.o hello
