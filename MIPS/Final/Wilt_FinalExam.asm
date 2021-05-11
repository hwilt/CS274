# Author: Henry Wilt
# CS274
# May 11th, 2021

	.globl main
	
	.text
	
main:
	
	# Call to Procedure 1
	jal	procedure1	# jumps to the first procedure and stores the return address in $ra
	
	
	Exit_Program:
	li $v0, 10 		# Sets $v0 to "10" to select exit syscall
	syscall

#----------------GET INTEGERS FROM USER-------------------
	# Get 3 integers from the user. Call procedure 2
	# and have the integers as the arguments
	# print out the sum of the integers
	#
	# Arguments:
	# NONE
	#
	# Returns:
	# NONE
procedure1:
	# Register Map:
	# $t0 - first integer
	# $t1 - second integer
	# $t2 - third integer
	# $t3 - sum of all three integers

	# printing out the welcome message
	li	$v0,4		# syscall command - string print
	la	$a0,msgWELCOME	# loads the message
	syscall
	# read in the first integer
	li	$v0,5		# syscall command - integer read
	syscall
	move $t0,$v0		# set $t0 to the first integer
	
	# printing out the sum message
	li	$v0,4		# syscall command - string print
	la	$a0,msgINT2	# loads the message
	syscall
	# read in the first integer
	li	$v0,5		# syscall command - integer read
	syscall
	move $t1,$v0		# set $t1 to the second integer
	
	# printing out the sum message
	li	$v0,4		# syscall command - string print
	la	$a0,msgINT3	# loads the message
	syscall
	# read in the first integer
	li	$v0,5		# syscall command - integer read
	syscall
	move $t2,$v0		# set $t2 to the third integer
	
	# MOVING INTEGERS INTO THE ARGUMENTS
	move	$a0,$t0
	move	$a1,$t1
	move	$a2,$t2
	
	# moving the return address onto the stack
	addi	$sp, $sp, -4	# move the stack pointer dowwn
	sw	$ra,($sp)	# store the return address
	
	# calling procedure 2
	jal	procedure2
	
	# popping the stack
	lw	$ra,($sp)	# POP!
	addi	$sp,$sp,4	# move the stack pointer back up
	
	# MOVING RETURN INTO RIGHT REGISTER
	move	$t3,$v0		# set $t3 to the sum of integers
	
	# printing out the sum message
	li	$v0,4		# syscall command - string print
	la	$a0,msgSUM	# loads the message
	syscall
	# print out the sum
	li	$v0,1		# syscall command - integer print
	move	$a0,$t3		# setting $a0 to the sum
	syscall
	
			
	jr	$ra		# returns to the main method

#----------------------FIND MIN & LOOP----------------------------
	# Gets 3 integers in arguments, find the smallest integer
	# Have a loop go through printing "hello" that many times
	# Call procedure 3
	#
	# Arguments:
	# $a0 - integer 1
	# $a1 - integer 2
	# $a2 - integer 3
	#
	# Returns:
	# $v0 - sum of all intgers
procedure2:
	# Register Map:
	# $t0 - first integer
	# $t1 - second integer
	# $t2 - third integer
	# $t3 - sum of all three integers
	# $t4 - Smallest integer
	# $t5 - sum of first + second integer
	
	# MOVING ARGUMENTS INTO THE RIGHT REGISTERS
	move	$t0,$a0
	move	$t1,$a1
	move	$t2,$a2
	
	# Finding the MIN
	move	$t4,$t0		# move first integer to be the smallest
	blt	$t4,$t1,Else	# if smallest int < second int (go to else)
	move 	$t4,$t1		# change to the second integer
	Else:
	
	blt	$t4,$t2,End	# if smallest int < third int (go to else)
	move	$t4,$t2		# change to the third integer
	End:
	
	# Loop through til the smallest int and printing out "hello" each time
	
	loop:
		# printing out the hello
		li	$v0,4		# syscall command - string print
		la	$a0,msgHELLO	# loads the message
		syscall
		la	$a0,NEWLINE
		syscall
		addi	$t4,$t4,-1		# smallest int - 1
		bge	$t4,1,loop		# go to loop if smallest int > 0
	
	# MOVING REGISTERS TO ARGUMENTS
	add	$a0,$t0,$t1	# adding the first two ints and putting it in the first argument
	move	$a1,$t2		# moving the third int into the second argument
	
	
	# moving the return address onto the stack
	addi	$sp, $sp, -4	# move the stack pointer dowwn
	sw	$ra,($sp)	# store the return address
	
	# calling procedure 2
	jal	procedure3
	
	# popping the stack
	lw	$ra,($sp)	# POP!
	addi	$sp,$sp,4	# move the stack pointer back up
	
	jr	$ra		# returns to procedure 1


#---------------------ADDING-----------------------
	# Gets 2 integers in arguments, add them up
	# return the sum
	#
	# Arguments:
	# $a0 - sum of integers 1 + 2
	# $a1 - integer 3
	#
	# Returns:
	# $v0 - sum of all intgers
procedure3:
	# Register Map:
	# $t0 - sum of first + second integer
	# $t1 - third integer
	# $t2 - sum of all three integers
	
	# MOVING ARGUMENTS INTO THE RIGHT REGISTERS
	move	$t0,$a0
	move	$t1,$a1
	
	# ADD
	add	$t2,$t0,$t1	# adds the sum of the first two integers + the third integer

	# MOVE RETURN TO THE RIGHT REGISTER
	move	$v0,$t2
	
	jr	$ra		# returns to procedure 2

	.data
	
msgHELLO:	.asciiz		"hello"		# looping through the hello
msgWELCOME:	.asciiz		"Welcome to the final assignment, you will need to input 3 integers. \nPlease input your first integer now: "
msgINT2:	.asciiz		"Please input your second integer now: "
msgINT3:	.asciiz		"Please input your last integer now: "
msgSUM:		.asciiz		"The sum is: "
NEWLINE:	.asciiz		"\n"