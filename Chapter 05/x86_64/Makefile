ASFLAGS=-gstabs #-32
LDLIBS=#-m elf_i386
all: toupper 

% : %.s
# the default rule calls $(CC) but that's not what we want right now
# so this empty rule will cancel the default.

%.o : %.[sS]
	$(AS) -o $@ $< $(ASFLAGS)

% : %.o
	$(LD) -o $@ $< $(LDLIBS)


clean:
	-rm -rf toupper *.o

.PHONEY: clean all
