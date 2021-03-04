#--------------------------------------------------------------
#
#	Lab 4 - Capitalizing a file
#	Ann Marie V. Schilling
#
#	CS174 - Computer Architecture and Machine Organization
# 	
#--------------------------------------------------------------

	.globl	main
	
	.text

main:

	# Register Map
	
	# $s6 input file descriptor
	# $s7 output file descriptor
	# $t0 current byte
	# $t4 number of bytes read in from input file
	

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
	
  	# -- Save the number of characters we read to a register
  	# -- ** Part 1 of Lab 4  If -1 is returned, there was an error.  Alert user and exit the program.
  	#	if no error, continue
  	move $t4, $v0		# $v0 contains the number of characters read from the file.
  	li   $v0,1		# printing out the number of characters read for a sanity check
  	move $a0, $t4
  	syscall
	
closeIn:# -- Close the input file 
  	li   $v0, 16       # system call for close file
  	move $a0, $s6      # file descriptor to close
  	syscall  

#-----	Create and open the output file


  	#  -- Open (for writing) a file.  If it exists, it will be clobbered (overwritten)
write: 	li   $v0, 13       # system call for open file
  	la   $a0, outFile  # output file name
  	li   $a1, 1        # Open for writing (flags are 0: read, 1: write)
  	li   $a2, 0        # mode is ignored
  	syscall            # open a file (file descriptor returned in $v0)
  	move $s7, $v0      # save the file descriptor 
  	
  	
   	# -- ** Part 2 of Lab 4  If -1 is returned, there was an error.  Alert user and exit the program.  
   	#    
  	#move $t4, $v0		#saving of return value
  	#li   $v0,1
  	#move $a0, $t4
  	#syscall	
  	
  	
  	# -- ** Part 3 of Lab 4
  	# --  	Iterate through readBuffer and capitalize all of the characters.  You need to do it byte
  	#	byte.  Remember, that registers hold 4-byte words.  See byteextract.asm for how to iterate
  	#	through a word's bytes.
  	
  	
  	
	# -- Write buffer to output file
   	li   $v0, 15       # system call for write to file
  	move $a0, $s7      # file descriptor 
  	la   $a1, readBuffer  # address of buffer from which to write
  	li   $a2, 2048      # hardcoded buffer length
  	syscall            # write to file
  	
  	
 
  	
closeOut:# -- Close the output file 
  	li   $v0, 16       # system call for close file
  	move $a0, $s7      # file descriptor to close
  	syscall  
	
  

exit:	li	$v0,10
	syscall




.data

readBuffer:.space 2048				# where the data will be stored when we read it in
message:.asciiz "Please give a message: "
count: 	.asciiz "How many times would you like to print message to file?  Value must be on [0,75]"
EOL:	.asciiz "\n"
inFile:	.asciiz	"calm.txt"			# name for input file
outFile:.asciiz "shouted.txt"			# name for output file






