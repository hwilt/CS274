# Author: Henry Wilt
# Class: CS274
# Feburay 28th, 2021

	.globl main 

	.text 

																													
main:
	jal 	proc1		# jumps to the first procedure and stores the next instruction in $ra
	
	# Register Map
	# $t0 = triangle height
	# $t1 = triangle character
	# move return values into arguments for procedure 2
	move	$a0,$v0
	move	$a1,$v1
	
	
	jal	proc2		# jumps to the second procedurer and stores the next instruction in $ra
	

	li $v0, 10 		# Sets $v0 to "10" to select exit syscall
	syscall 
	
	
	
	#--------------Procedure 1-------------------------
	# asks the user for the height of triangles
	# if less than 0 then ask again and add one if even
	# asks the user what character for the triangles
	# 
	# no arguments
	# $v0 - height of triangles
	# $v1 - character for triangles
proc1:
rows:
	# Getting the number of rows from user
	li	$v0,4		# print_string syscall code = 4
	la	$a0, msg1	# load the address of msg
	syscall
	li	$v0,5		# read_int syscall code = 5
	syscall			# Gets input from user
	move	$t0,$v0		# $t0 = rows
	li	$v0,4		
	la	$a0, newline	# load the address of newline
	syscall
	
	#if(rows <= 0){
	#	ask for the number of rows again
	#}
	# check if number of rows is below zero
	slti	$s1,$t0,0	# sets $s1 to 0 if $t0 is greater than 0
	bne	$s1,$zero,rows	# if not equal to zero than goes and asks for a new number
	
	#if(rows % 2 == 0){
	#	rows++;
	#}
	# checks if rows is even then add 1
	li	$t6,2
	div	$t0,$t6		# rows % 2 = high value
	mfhi	$t6		# gets the high value (remindar)
	bnez	$t6,e		# branch to e if remindar does not equal 0
	addi	$t0,$t0,1	# adding 1 to the row
	e:			# skip over the addition
		
	# Getting the character to be used for the pyramid from user
	li	$v0,4		# print_string syscall code = 4
	la	$a0, msg2	# load the address of msg
	syscall
	li	$v0,12		# read_character syscall code = 12
	syscall			# Gets input from user
	move	$t1,$v0		# saves results returned in $v0
	li	$v0,4		
	la	$a0, newline	# load the address of newline
	syscall
	
	
	# moving the height into $v0
	move	$v0,$t0
	# moving the character into $v1
	move	$v1,$t1
	
	jr	$ra		# Returns to the main method
	
	#--------------Procedure 2-------------------------
	# Take in an integer for the height and a character
	# for the triangle and will print a hollow triangle
	# into a file called "triangleHollow.txt"
	# 
	# $a0 - height for triangle
	# $a1 - character for triangle
	# no returns
proc2:
	# Register Map
	# $a1 = hollow buffer 
	# $t0 = triangle height
	# $t1 = triangle character (ascii)
	# $t3 = EOL
	# $t4 = Space (ascii)
	# $t5 = int i
	# $t6 = int j
	# $t7 = int k
	# $t8 = 2 * rows - 1
	# $s6 = Text file descriptor (for hollow)
	
	
	# store the height in the stack
	addi	$sp,$sp,-4	# move stack pointer back
	sw	$t0,0($sp)	# save $t0 or the height
		
	move	$t0,$a0
	move	$t1,$a1
	
	# Initialize loop counter, EOL registers before loop starts
	#li   	$t0,0			# $t0 will hold the value 0 AKA the null terminator
	la	$a1, hollowBuffer	# data will be written to file from memory (the data section)
	li 	$t3, 0xA		# end of line character
	li	$t4, 0x20		# space character
	
	#int i, j, k = 0; 
    	#for (i = 1; i <= rows; i++){ 
        #	for (j = i; j < rows; j++) { 
        #    		cout << " "; 
        #	} 
        #	while (k != (2 * i - 1)) { 
        #    		if (k == 0 || k == 2 * i - 2) 
        #        		cout << "character"; 
        #    		else
        #        		cout << " "; 
        #    		k++; 
        #	} 
        #	k = 0; 
        #	cout << endl; // print next row 
    	#} 
    	#for (i = 0; i < 2 * rows - 1; i++) { 
        #	cout << "character"; 
    	#} 
	
	li	$t5, 1
	li	$t6, 0
	li	$t7, 0
	# $t8 = 2 * rows - 1
	move 	$t8,$t0
	mul	$t8,$t8,2		# $t8 = 2 * $t8(rows)
	sub	$t8,$t8,1		# $t8 = $t8(2 * rows) - 1
	
forHollow:
	beq 	$t0, $t5, HollowLast	# checks if it's the last row
	move	$t6,$t5			# sets j = i
	forHollow_Spaces:
		addi	$a1,$a1,1	# increment the buffer to give whitespace
		addi	$t6,$t6,1	# increments j by 1
		blt	$t6,$t0,forHollow_Spaces
		
	whileHollow:
			beqz	$t7,IF		# if k == 0 then go to IF
			mul	$t9,$t5,2	# i * 2
			sub	$t9,$t9,2	# $t9 = (i * 2) - 2
			bne	$t7,$t9,Else	# if k != 2 * i - 2 then go to else
		IF:
			sb	$t1,($a1)	# store character in buffer
			addi	$a1,$a1,1	# increment the buffer
			j	Exit		# skipping the false claim
		Else:
			sb	$t4,($a1)	# store space in buffer
			addi	$a1,$a1,1	# increment the buffer
		Exit:
		mul	$t9,$t5,2		# i * 2
		sub	$t9,$t9,1		# $t9 = (i * 2) - 1
		addi 	$t7,$t7,1		# increments k by 1
		bne	$t7,$t9,whileHollow	# checks if k != (2 * i - 1)
		
		sb	$t3,($a1)	# store newline in the buffer
		addi	$a1,$a1,1	# increment the buffer	
		li	$t7, 0		# set k back to zero
		addi	$t5,$t5,1	# increments i by 1
		j	forHollow	# jumps back up to the top of the loop
HollowLast:
	li 	$t5, 0			# i = 0
	PrintHollowChars:
		sb	$t1,($a1)	# store character in the buffer
		addi	$a1,$a1,1	# increment the buffer	
		addi	$t5,$t5,1	# increments i by 1
		blt	$t5,$t8,PrintHollowChars	

	#  -- Open (for writing) a file.  If it exists, it will be clobbered (overwritten)
writeHollow: 	
	li	$v0, 13       		# system call for open file
  	la   	$a0, hollowText		# output file name
  	li   	$a1, 1        		# Open for writing (flags are 0: read, 1: write)
  	li   	$a2, 0        		# mode is ignored
  	syscall            		# open a file (file descriptor returned in $v0)
  	move 	$s7, $v0      		# save the file descriptor   	
  	
	# -- Write buffer to output file
   	li   	$v0, 15       		# system call for write to file
  	move 	$a0, $s7      		# file descriptor 
  	la 	$a1, hollowBuffer	# address of buffer from which to write
  	li  	$a2, 2048	      	# hardcoded buffer length
  	syscall            		# write to file

closeOutHollow:
	# -- Close the output file 
  	li   	$v0, 16       		# system call for close file
  	move 	$a0, $s7      		# file descriptor to close
  	syscall
	
	
	# Jump to procedure 3
	lw	$t0,0($sp)	# load $t0 or the height
	sw	$ra,0($sp)	# save $ra
	
	# move return values into arguments for procedure 2
	move	$a0,$t0
	move	$a1,$t1
		
	jal	proc3
	
	lw	$ra,0($sp)	# load $ra
	addi	$sp,$sp,4	# move stack pointer up
	
	# printing out Triangles Written to the terminal
	li 	$v0, 4
	la	$a0, newline
	syscall
    	la 	$a0, msg3
    	syscall
exitHollow:	
	jr	$ra
	
	
	#--------------Procedure 3-------------------------
	# Take in an integer for the height and a character
	# for the triangle and will print a solid triangle
	# into a file called "triangleSolid.txt"
	# 
	# $a0 - height for triangle
	# $a1 - character for triangle
	# no returns
proc3:
	# Register Map
	# $a1 = solid buffer 
	# $t0 = triangle height
	# $t1 = triangle character (ascii)
	# $t3 = EOL
	# $t4 = Space (ascii)
	# $t5 = int i
	# $t6 = int j
	# $t7 = int k
	# $t8 = 2 * rows
	# $s7 = Text file descriptor (for solid)
	
	move	$t0,$a0
	move	$t1,$a1
	
	# Initialize loop counter, EOL registers before loop starts
	#li   	$t0,0			# $t0 will hold the value 0 AKA the null terminator
	la	$a1, solidBuffer	# data will be written to file from memory (the data section)
	li 	$t3, 0xA		# end of line character
	li	$t4, 0x20		# space character
	
	li	$t5, 1			# set i to 1
	
	
        #for (int i = 1; i < rows; i++) { 
        #	if(i != rows){
        #   		for (int j = rows - i; j >= i; j--) { 
        #       		System.out.print(" "); 
        #   		} 
        #   		for (int j = 1; j <= i * 2 - 1; j++) { 
        #        		System.out.print("*"); 
        #   		} 
        #   		System.out.println(); 
        #	}
        #	else{
        #   		for (int j = 1; j <= i * 2 - 1; j++) { 
        #        		System.out.print("*"); 
        #   		}
        #	}
        #} 
	
forSolid:
	beq	$t5,$t0,SolidLast	# branch if the last row
	move	$t6, $t0		# set j to rows
	sub	$t6,$t6,$t5
	forSolid_Spaces:
		addi	$a1,$a1,1			# increment the buffer to give whitespace
		addi	$t6,$t6,-1			# deincrement j by 1
		bgt	$t6,$zero,forSolid_Spaces	# branch if j > 0
	
	li	$t7, 1			# set k to 1
	forSolid_Characters:
		sb	$t1,($a1)			# store character in the buffer
		addi	$a1,$a1,1			# increment the buffer	
		addi	$t7,$t7,1			# increment j by 1
		mul	$t8,$t5,2			# multiply i by 2
		addi	$t8,$t8,-1			# subtract i by 1
		ble	$t7,$t8,forSolid_Characters	# branch if j <= i
	
	newLineSolid:
		sb	$t3,($a1)			# store newline in the buffer
		addi	$a1,$a1,1			# increment the buffer	
	
	# incrementing and condition	
	addi	$t5,$t5,1		# increments i by 1
	ble	$t5,$t0,forSolid	# jumps back up to the top of the loop
	
SolidLast:
	li	$t7, 1			# set k to 1
	forSolid_Characters_Last:
		sb	$t1,($a1)				# store character in the buffer
		addi	$a1,$a1,1				# increment the buffer	
		addi	$t7,$t7,1				# increment j by 1
		mul	$t8,$t5,2				# multiply i by 2
		addi	$t8,$t8,-1				# subtract i by 1
		ble	$t7,$t8,forSolid_Characters_Last	# branch if j <= i	
	
	#  -- Open (for writing) a file.  If it exists, it will be clobbered (overwritten)
writeSolid: 	
	li	$v0, 13       		# system call for open file
  	la   	$a0, solidText		# output file name
  	li   	$a1, 1        		# Open for writing (flags are 0: read, 1: write)
  	li   	$a2, 0        		# mode is ignored
  	syscall            		# open a file (file descriptor returned in $v0)
  	move 	$s7, $v0      		# save the file descriptor   	
  	
	# -- Write buffer to output file
   	li   	$v0, 15       		# system call for write to file
  	move 	$a0, $s7      		# file descriptor 
  	la 	$a1, solidBuffer	# address of buffer from which to write
  	li  	$a2, 2048	      	# hardcoded buffer length
  	syscall            		# write to file

closeOutSolid:
	# -- Close the output file 
  	li   	$v0, 16       		# system call for close file
  	move 	$a0, $s7      		# file descriptor to close
  	syscall
  	
	jr	$ra
	
	
	.data

hollowText:	.asciiz		"triangleHollow.txt"
hollowBuffer:	.space		2048
solidText:	.asciiz		"triangleSolid.txt"
solidBuffer:	.space		2048
msg1:		.asciiz		"Enter the number of rows: "
msg2:		.asciiz		"Enter the character for the pyramid: "
msg3:		.asciiz		"TrianglesWritten!"
newline: 	.asciiz		"\n"
