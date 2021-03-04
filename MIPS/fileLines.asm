#--------------------------------------------------------------
#
#	Lab 4 Helper - Extracting bytes from a string
#	Ann Marie V. Schilling
#
#	CS174 - Computer Architecture and Machine Organization
#	
#	This program will extract each byte from a null terminated
# 	string and print it out to the screen on its own line.
#--------------------------------------------------------------


	# Declare main as a global function
	.globl main 

	# Start the code
	.text 		

# The label 'main' represents the starting point

main:
	# -----------------------------------------------------------------------
	#				s.o.println functionality
	# -----------------------------------------------------------------------
	# -- 	This part prints the entire string on its own line and a newline after
	#	So, essentially a s.o.println(toPrint)
	
	la 	$s0,toPrint	# put  address of first char in string into register
	li	$v0, 4		# system call code for print null terminated string
	la	$a0, ($s0)	# load address of first char in message
	syscall
	
	# Print string End of Line
	li	$v0, 4		#system call code for print NT string
	la	$a0, EOL	#load address of first char in message
	syscall
	
	# -----------------------------------------------------------------------
	# Iterating through the string and printing each character on its own line
	# -----------------------------------------------------------------------
	
	# -- This part will loop through the string printing each character on its own line
	#    until it hits the null terminator AKA string terminator AKA \0  AKA ASCII 0
	# Initialize loop counter and terminating value before loop starts
	li   	$t0,0			#  $t0 will hold the value 0 AKA the null terminator
	lb 	$t1,($s0)		#  current byte in $t1
	
	# Start the loop a-runnin'
Loop:	beq 	$t0,$t1,open		#  if current byte == null terminator, we're at end of string,  go to next part of program
	# otherwise....		
	# Print current character
	li	$v0, 11			# system call code for print single character
	lb	$a0,($s0)		# load character to print
	syscall				# print that sucker
	
	# Print newline character
	li	$v0, 4			# system call code for print NT string
	la	$a0, EOL		# load string to print
	syscall

	# Get the next character in the string
	addi	$s0,$s0,1		# move pointer (aka index) to next byte in string
	lb 	$t1,($s0)		# load char at new index
	j	Loop			# jump to top of loop

	# -----------------------------------------------------------------------
	#  Read in a file, iterate though, printing each line out to the screen
	#  with an exclamation point at the end of each line
	# -----------------------------------------------------------------------

	# -- Open the file we are going to read	
open:	li   $v0, 13       # system call for open file
  	la   $a0, inFile # input file name
  	li   $a1, 0        # Open for reading (flags are 0: read, 1: write)
  	li   $a2, 0        # mode is ignored
  	syscall            # open a file (file descriptor returned in $v0)
  	move $s6, $v0      # save the file descriptor 		
	
	# -- Read data from the file and into the buffer.  Assume max file size is 2048
read:	li	$v0,14		# read from file sys call
	move	$a0, $s6	# put file descriptor in $a0
	la	$a1, readBuffer	# data will be read from file into memory
	li	$a2, 2048	# number of bytes to read
	syscall
	
	# -- Close the input file 
	#	We're done with it, no need to take up OS resources by leaving it open
closeIn:
  	li   $v0, 16       # system call for close file
  	move $a0, $s6      # file descriptor to close
  	syscall  
  	


  	# -- This part will loop through the buffer printing each line with a  ! at the end
	#    until it hits the null terminator AKA end of file  AKA \0  AKA ASCII 0  
	#    
	
	
	# Initialize loop counter, EOL registers and terminating value before loop starts
	li   	$t0,0			#  $t0 will hold the value 0 AKA the null terminator
	la	$a1, readBuffer		#  data will be read from file into memory (the data section)
	lb 	$t1,($a1)		#  $a1 is address of buffer, load current byte in $t1
	
	#  end of Line (EOL) is actually comprised of two characters, "carriage return" CR and "line feed" LF.
	#  Together they are known as CRLF.  We will consider ourselves at EOL if we read in a LF character
	#  so we load its ASCII 0xA into a register to compare
	li 	$t2, 0xA
	
	# Start the loop a-runnin'
pLoop:	beq 	$t0,$t1,Exit		#  if current byte == null terminator, we're at end of file, exit
	# otherwise....		
	
	# --- If we're at the end of line, print an exclamation point
	bne	$t1, $t2, notEOL	#  branch away if not at end of line 
	li	$v0,11			#  load sys id for print character
	li	$a0,0x21		#  we're printing an exclamation point (bang) before printing the EOL
	syscall
	
	
	# Print current character
notEOL:	li	$v0, 11			# system call code for print single character
	lb	$a0,($a1)		# load character to print
	syscall				# print that sucker

	# Get the next character in the string
	addi	$a1,$a1,1		# move pointer (aka index) to next byte in string
	lb 	$t1,($a1)		# load char at new index
	j	pLoop			# jump to top of loop



Exit:	# Landing spot for end of loop

	# Exit the program by means of a syscall.
	# There are many syscalls - pick the desired one
	# by placing its code in $v0. The code for exit is "10"
	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit

	# All memory structures are placed after the
	# .data assembler directive
	.data

	# The .word assembler directive reserves space
	# in memory for a single 4-byte word (or multiple 4-byte words)
	# and assigns that memory location an initial value
	# (or a comma separated list of initial values)

toPrint:.asciiz	"jai guru deva om"
EOL:.asciiz "\n"
readBuffer:.space 2048				# where the data will be stored when we read it in
message:.asciiz "Please give a message: "
count: 	.asciiz "How many times would you like to print message to file?  Value must be on [0,75]"
inFile:	.asciiz	"calm.txt"			# name for input file
outFile:.asciiz "shouted.txt"			# name for output file
