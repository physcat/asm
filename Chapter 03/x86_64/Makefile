ASFLAGS=-gstabs
all: exit maximum

% : %.s

# the default rule calls $(CC) but that's not what we want right now
# so this empty rule will cancel the default.

%.o : %.[sS]
	$(AS) -o $@ $< $(ASFLAGS)

% : %.o
	$(LD) -o $@ $<


clean:
	-rm -rf exit.o exit maximum.o maximum

.PHONEY: clean all
