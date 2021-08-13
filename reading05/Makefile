CC=	gcc
CFLAGS=	-Wall -g -std=gnu99
LIBS=	

test:	
	@$(MAKE) -sk test-quiz test-program

program:    program.c
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

test-quiz:
	../.scripts/check.py

test-program: program
	curl -sLO https://raw.githubusercontent.com/nd-cse-30341-fa21/cse-30341-fa21-assignments/master/reading05/test_program.sh
	chmod +x test_program.sh
	./test_program.sh

clean:
	rm -f program
