# Author: Henry Wilt
# Class: CS274
# March 2nd, 2021

	.globl	main
	
	.text

main:

	# Register Map
	
	# $s6 input file descriptor
	# $s7 output file descriptor
	# $t0 current byte
	# $t4 number of bytes read in from input file
	# $t5 count for each line
	# $t6 boolean if at start of file
	# $t7 boolean if at end of file
	

	# Open the file we are going to read	
open:	li   $v0, 13       # system call for open file
  	la   $a0, inFile   # input file name
  	li   $a1, 0        # Open for reading (flags are 0: read, 1: write)
  	li   $a2, 0        # mode is ignored
  	syscall            # open a file (file descriptor returned in $v0)
  	move $s6, $v0      # save the file descriptor 		
	
	# Read data from the file and into the buffer.  Assume max file size is 2048
read:	li	$v0,14		# read from file sys call
	move	$a0, $s6	# put file descriptor in $a0
	la	$a1, readBuffer	# data will be read from file into memory
	li	$a2, 2048	# number of bytes to read
	syscall
	
	# Save the number of characters we read to a register
  	move $t4, $v0		# $v0 contains the number of characters read from the file.
  	li   $v0,1		# printing out the number of characters read for a sanity check
  	move $a0, $t4
  	syscall
  	
	# Close the input file 
closeIn:
  	li   $v0, 16       # system call for close file
  	move $a0, $s6      # file descriptor to close
  	syscall  

	
	# Create and open the output file
	li	$t5,0	# line count
	li	$t6,0	# zero is true/ one is false ~~ at start of line
	li	$t7,1	# zero is true/one is false ~~ at end of line

  	# Open (for writing) a file.  If it exists, it will be clobbered (overwritten)
write: 	li   $v0, 13       # system call for open file
  	la   $a0, outFile  # output file name
  	li   $a1, 1        # Open for writing (flags are 0: read, 1: write)
  	li   $a2, 0        # mode is ignored
  	syscall            # open a file (file descriptor returned in $v0)
  	move $s7, $v0      # save the file descriptor 
  	
  	j	here
loop:	
	# if at the beginning of the line
	#	print out t5 + :_
	#	set boolean flag to false (start of line)
	# else if current char is == '\n'
	#	set boolean flag to true (end of line)
	# print next character
	# 
	
	bnez	$t6, beginningElse
	li   	$v0, 15       	# system call for write to file
  	move 	$a0, $s7      	# file descriptor 
  	move	$a1, $t5	# move the line count 
  	li	$a2, 4		# hardcoded byte 1 length since its only an int
  	syscall
  	la   	$a1, linedelim  # address of linedelim from which to write
  	li   	$a2, 8      	# hardcoded 2 bytes since :_
  	syscall            	# write to file
	addi	$t5,$t5,1	# add 1 to the line count after printing out the linedelim
	beginningElse:
	
	
	
  		
	#slti	$s1,$t0,$t4	# sets $s1 to zero if less than the number of bytes read from the file
	beqz	$s1, loop	# if $s1 is zero then loop again
  	
 here:
	# Write buffer to output file
   	li   $v0, 15       # system call for write to file
  	move $a0, $s7      # file descriptor 
  	la   $a1, readBuffer  # address of buffer from which to write
  	li   $a2, 2048      # hardcoded buffer length
  	syscall            # write to file

  	
 
  	# Close the output file 
closeOut:
  	li   $v0, 16       # system call for close file
  	move $a0, $s7      # file descriptor to close
  	syscall  
	
  

exit:	li	$v0,10
	syscall




.data

readBuffer:.space 2048				# where the data will be stored when we read it in
linedelim:.asciiz ": "				# line count ie ((num): ----text--)
EOL:	.asciiz "\n"
inFile:	.asciiz	"in.txt"			# name for input file
outFile:.asciiz "out.txt"			# name for output file






