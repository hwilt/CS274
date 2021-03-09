# Author: Henry Wilt
# Class: CS274
# Feburay 28th, 2021

	.globl main 

	.text 
								
main:
input:
	# Getting the number of rows from user
	li	$v0,4		# print_string syscall code = 4
	la	$a0,askUser	# load the address of msg
	syscall
	li	$v0,5		# read_int syscall code = 5
	syscall			# Gets input from user
	move	$t0,$v0		# $t0 = input
	li	$v0,4		
	la	$a0,newline	# load the address of newline
	syscall
	
	# if(input > 1 && input < 50){
	#	print("Wrong Integer do you want to change?");
	#	//ask user again
	#	if(userSaysYes){
	#		//go ask for the input again
	#	}
	#	else{
	#		exit program
	#	}
	# }
	# check if the input is below 1 or greater than 50
	blt	$t0,1,ifUser	# branches to if part if input <= 1
	bgt	$t0,50,ifUser	# branches to if part if input >= 50
	j	loopStart
ifUser:
	la	$a0, askIfOk	# asks the users if they want to put a new int in
	syscall
	li	$v0,5		# read_int syscall code = 5
	syscall			# Gets input from user
	move	$t1,$v0		# $t0 = input
	beq	$t1,1,input	# if input = 1 go ask for new input
	li	$v0,4		
	la	$a0,msgOK	# load the address of msgOK
	syscall
	j Exit			# else go to exit
	

loopStart:
	# for(int i = 1; i <= 50; i++){
	#	sum += i;
	# 	print("Counter: <current value>");
	# 	print("Sum: <current sum>");
	# }
	# for loop
	li	$t1,1		# starting condition int i = 1
	li	$t2,0		# starting sum
loop:
	add	$t2,$t2,$t1
	# printing out counter
	li	$v0,4		
	la	$a0,msgCounter	# load the address of msgCounter
	syscall
	li	$v0,1		
	move	$a0,$t1		# moves the count to be able to print
	syscall
	li	$v0,4		
	la	$a0,newline	# load the address of newline
	syscall
	# printing out sum
	li	$v0,4		
	la	$a0,msgSum	# load the address of msgSum
	syscall
	li	$v0,1		
	move	$a0,$t2		# moves the sum to be able to print
	syscall
	li	$v0,4		
	la	$a0,newline	# load the address of newline
	syscall
	
	# increment
	addi	$t1,$t1,1	# i++
	ble	$t1,$t0,loop	# go back to start of loop if i is less than input from user
	
	
		
	
	
Exit:	
	li $v0, 10 		# Sets $v0 to "10" to select exit syscall
	syscall 
	
	
	.data
	
askUser:	.asciiz		"Enter an Integer from 1 to 50: "
askIfOk:	.asciiz		"The integer needs to be from 1-50, do you want to enter another interger.\nType 1 to enter again or 0 to not: "
msgOK:		.asciiz		"OK"
msgCounter:	.asciiz		"Counter: "
msgSum:		.asciiz		"Sum: "
newline: 	.asciiz		"\n"
