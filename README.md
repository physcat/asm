Programming from the ground up - Assembly
============================================

Programming from the ground up is a brilliant open book on assembly
language.

Here is the source for some of the examples in the book:
(The code starts in Chapter 3)

The book's examples are for 32 bit (i386) Linux.  
64 bit adapted examples can be found in the x86_64 folder.  
ARM versions in the arm folder.

Note about ARM - I've only tested these on the Raspberry Pi and my 
Nokia N9 phone. Cross compiling from my laptop also created binaries 
that worked great on both, so far.

Chapter 3
---------
	exit.s
	maximum.s

Chapter 4
---------
	power.s
	factorial.s

Pre - Chapter 5
---------------
Chapter 5 has a monster of a long example. I would have preferred smaller
examples myself. But then I liked the way K&R did things.
Here are some small examples I would have enjoyed doing. (So I did them)

	Small Examples/
	hello.s		- prints "hello world to stdout"
	numargs.s	- introduces the number of arguments, argc
	strlen.s	- returns the length of a c-style string
	args.s		- prints out all the command line arguments argv
	cat.s		- will echo the contens of a text file


Chapter 5
---------
	 toupper.s

Chapter 6
---------
Reading and writing basic records.
