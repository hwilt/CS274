# Author: Henry Wilt
# Class: CS274
# March 2nd, 2021

	.globl	main
	
	.text

main:

	# Register Map
	
	# $s6 input file descriptor
	# $s7 output file descriptor
	# $t4 number of bytes read in from input file
	# $t5 count for each line
	# $t6 start of line (boolean, 0 = true, 1 = false)
	

	# Open the file we are going to read	
open:	li   	$v0, 13       		# system call for open file
  	la   	$a0, inFile   		# input file name
  	li   	$a1, 0        		# Open for reading (flags are 0: read, 1: write)
  	li   	$a2, 0        		# mode is ignored
  	syscall           		# open a file (file descriptor returned in $v0)
  	move 	$s6, $v0     		# save the file descriptor 		
	
	# Read data from the file and into the buffer.  Assume max file size is 2048
read:	li	$v0,14			# read from file sys call
	move	$a0, $s6		# put file descriptor in $a0
	la	$a1, readBuffer		# data will be read from file into memory
	li	$a2, 32768		# number of bytes to read
	syscall
	
	# Save the number of characters we read to a register
  	move 	$t4, $v0		# $v0 contains the number of characters read from the file.
  	
	# Close the input file 
closeIn:
  	li   	$v0, 16       		# system call for close file
  	move 	$a0, $s6      		# file descriptor to close
  	syscall  
	
					
  	# Initialize loop counter and terminating value before loop starts
	la	$a2, writeBuffer	
	lb 	$t7,($a2)		#  $a2 is address of buffer, load current byte in $t7			
		
	# Initialize loop counter, EOL registers and terminating value before loop starts
	li   	$t0,0			#  $t0 will hold the value 0 AKA the null terminator
	la	$a1, readBuffer		#  data will be read from file into memory (the data section)
	lb 	$t1,($a1)		#  $a1 is address of buffer, load current byte in $t1
	
	#  end of Line (EOL) is actually comprised of two characters, "carriage return" CR and "line feed" LF.
	#  Together they are known as CRLF.  We will consider ourselves at EOL if we read in a LF character
	#  so we load its ASCII 0xA into a register to compare
	li 	$t2, 0xA
	
	# Initialize line number counter, and boolean isStart
	li	$t5, 0
	li	$t6, 0
	
	# colon and space in ascii
	li	$t8, 0x3a
	
	# Start the loop a-runnin'
Loop:	
	beq 	$t0,$t1,write		# if current byte == null terminator, we're at end of file, exit
	
	# if boolean start is true then branch to startline
	beqz	$t6,startLine		# branch away if at the start of line
	
	# --- If we're at the end of line, print an exclamation point
	bne	$t1, $t2, notEOL	# branch away if not at end of line 
	li	$t6, 0			# set boolean to true


	# moves the character from the readBuffer to storeBuffer
notEOL:	
	# store byte in the writebuffer
	sb	$t1,($a2)

	# Get the next character in the string
	addi	$a1,$a1,1		# move pointer (aka index) to next byte in string
	lb 	$t1,($a1)		# load char at new index
	addi	$a2,$a2,1		# move pointer (aka index) to next byte in string
	j	Loop			# jump to top of loop
	
	# stores (num) + :_ + text in writeBuffer
startLine:
	li	$t6,1			# set boolean to false
	
	# push to stack so you dont lose the line number count
	addi	$sp,$sp,-4		# push back 4 bytes to put the count on
	sw	$t5,0($sp)
	
	la	$a3, digits		# address of digit
	li	$s4, 0			# number of digits
	jal	lineNumber

	# pop back
	lw	$t5,0($sp)		# load back the line number count to $t5
	addi	$sp,$sp,4		# set stack back to normal
		
	# move :_ into writebuffer
	sb	$t8,($a2)		# stores ":" into the write buffer
	addi	$a2,$a2,2		# move pointer (aka index) to next byte in string
	
	addi	$t5,$t5,1		# up the count of lines + 1
	j	Loop

	# correctly puts the line numbers in order in ascii values
lineNumber:
	
	div	$s0,$t5,10		# find the modus of 10
	mfhi	$s0			# move the modus into $s0
	addi	$s0,$s0,0x30		# adds by 0x30 for the ascii values to line up correctly
	sw	$s0,0($a3)		# stores the number into the digits
	div	$t5,$t5,10		# divide so you lose the last digit of the number
	addi	$a3,$a3,-4		# move pointer (aka index) to next byte in string
	addi	$s4,$s4,1		# adds the number of digits by 1
	beqz	$t5,addToBuffer
	j lineNumber
addToBuffer:
	addi	$a3,$a3,4		# gets each digit of the number
	lb 	$s5,($a3)		# load that digit into $s5
	sb	$s5,($a2)		# stores the number into the writeBuffer
	addi	$a2,$a2,1		# move pointer (aka index) to next byte in string
	addi	$s4,$s4,-1		# subtract the number of digits by 1
	beqz	$s4,exit_LineNumber
	j	addToBuffer
exit_LineNumber:
	jr	$ra

  	
	#  -- Open (for writing) a file.  If it exists, it will be clobbered (overwritten)
write: 	li	$v0, 13       		# system call for open file
  	la   	$a0, outFile 		# output file name
  	li   	$a1, 1        		# Open for writing (flags are 0: read, 1: write)
  	li   	$a2, 0        		# mode is ignored
  	syscall            		# open a file (file descriptor returned in $v0)
  	move 	$s7, $v0      		# save the file descriptor   	
  	
	# -- Write buffer to output file
   	li   	$v0, 15       		# system call for write to file
  	move 	$a0, $s7      		# file descriptor 
  	la 	$a1, writeBuffer	# address of buffer from which to write
  	li  	$a2, 32768      	# hardcoded buffer length
  	syscall            		# write to file

closeOut:# -- Close the output file 
  	li   	$v0, 16       		# system call for close file
  	move 	$a0, $s7      		# file descriptor to close
  	syscall   

Exit:	li	$v0,10
	syscall




	.data

digits:		.space 		16
readBuffer:	.space 		32768			# where the data will be stored when we read it in
writeBuffer:	.space 		32768			# where the data will be stored to write it.
EOL:		.asciiz		"\n"
inFile:		.asciiz		"in.txt"		# name for input file
outFile:	.asciiz 	"out.txt"		# name for output file
