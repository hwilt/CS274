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
	li	$a2, 2048		# number of bytes to read
	syscall
	
	# Save the number of characters we read to a register
  	move 	$t4, $v0		# $v0 contains the number of characters read from the file.
  	# li   $v0,1			# printing out the number of characters read for a sanity check
  	# move $a0, $t4
  	# syscall
  	
	# Close the input file 
closeIn:
  	li   	$v0, 16       		# system call for close file
  	move 	$a0, $s6      		# file descriptor to close
  	syscall  
	
  
  	
  		
  			
  				
	#  -- Open (for writing) a file.  If it exists, it will be clobbered (overwritten)
write: 	li	$v0, 13       		# system call for open file
  	la   	$a0, outFile 		# output file name
  	li   	$a1, 1        		# Open for writing (flags are 0: read, 1: write)
  	li   	$a2, 0        		# mode is ignored
  	syscall            		# open a file (file descriptor returned in $v0)
  	move 	$s7, $v0      		# save the file descriptor 
				
	# Initialize loop counter, EOL registers and terminating value before loop starts
	li   	$t0,0			#  $t0 will hold the value 0 AKA the null terminator
	la	$a1, readBuffer		#  data will be read from file into memory (the data section)
	lb 	$t1,($a1)		#  $a1 is address of buffer, load current byte in $t1
	
	#  end of Line (EOL) is actually comprised of two characters, "carriage return" CR and "line feed" LF.
	#  Together they are known as CRLF.  We will consider ourselves at EOL if we read in a LF character
	#  so we load its ASCII 0xA into a register to compare
	li 	$t2, 0xA
	
	# Initialize line number counter, and boolean isStart
	li	$t5, 1
	li	$t6, 0
	
	# Start the loop a-runnin'
pLoop:	
	beq 	$t0,$t1,write		# if current byte == null terminator, we're at end of file, exit
	
	# if boolean start is true then branch to startline
	beqz	$t6,startLine		# branch away if at the start of line
	
	# --- If we're at the end of line, print an exclamation point
	bne	$t1, $t2, notEOL	# branch away if not at end of line 
	li	$t6, 0			# set boolean to true


	# Print current character
notEOL:	
	#li	$v0, 11			# system call code for print single character
	#lb	$a0,($a1)		# load character to print
	#syscall				# print that sucker

	# Get the next character in the string
	addi	$a1,$a1,1		# move pointer (aka index) to next byte in string
	lb 	$t1,($a1)		# load char at new index
	j	pLoop			# jump to top of loop
	
	# prints out (num) + :_ + text
startLine:
	li	$t6,1			# set boolean to false
	#li	$v0,1			# load sys id for print int
	#move	$a0,$t5			# print out the count of lines.
	#syscall
	
	#li	$v0,4			# load sys id for print string
	#la	$a0,linedelim		# prints out the :_
	#syscall
	li   	$v0, 15       		# system call for write to file
  	move 	$a0, $s7      		# file descriptor
	move 	$a1,
	addi	$t5,$t5,1		# up the count of lines + 1
	j	pLoop
  	
  	
  	
	# -- Write buffer to output file
   	li   	$v0, 15       		# system call for write to file
  	move 	$a0, $s7      		# file descriptor 
  	move 	$a1, $t1  		# address of buffer from which to write
  	li  	$a2, 2048      		# hardcoded buffer length
  	syscall            		# write to file

closeOut:# -- Close the output file 
  	li   	$v0, 16       		# system call for close file
  	move 	$a0, $s7      		# file descriptor to close
  	syscall   
 

Exit:	li	$v0,10
	syscall




	.data


readBuffer:.space 2048				# where the data will be stored when we read it in
linedelim:.asciiz ": "				# line count ie ((num): ----text--)
EOL:	.asciiz "\n"
inFile:	.asciiz	"in.txt"			# name for input file
outFile:.asciiz "out.txt"			# name for output file
