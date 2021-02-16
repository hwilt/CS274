# Author: Henry Wilt
# Class: CS274
# Feburay 16th, 2021

	.globl main 

	.text 		

# The label 'main' represents the starting point
main:
	# Step 0 get input from user
	li	$v0,4		# print_string syscall code = 4
	la	$a0, msg1	# load the address of msg
	syscall
	li	$v0,5		# read_int syscall code = 5
	syscall			# Get input from user
	move	$t0,$v0		# saves results returned in $v0
	li	$v0,4		
	la	$a0, newline	# load the address of newline
	syscall

	# Step 1 subtract one from the number
	subi $t1, $t0, 1	# subtracts one from t0 which is the input
	la	$a0, step1	# load the address of msg step 1
	syscall
	li	$v0, 1
	move	$a0, $t1	# load the int into $a0, from the result
	syscall	
	li	$v0, 4
	la	$a0, newline	# load the address of newline
	syscall
	
	# Step 2 multiply the result by three
	mul	$t1, $t1, 3	# multplys the result of step 1 by 3
	la	$a0, step2	# load the address of msg step 2
	syscall
	li	$v0, 1
	move	$a0, $t1	# load the int into $a0, from the result
	syscall	
	li	$v0, 4
	la	$a0, newline	# load the address of newline
	syscall
	
	# Step 3 add twele to step 2 result
	addi	$t1, $t1, 12	# adds 12 to the result of step 2
	la	$a0, step3	# load the address of msg step 3
	syscall
	li	$v0, 1
	move	$a0, $t1	# load the int into $a0, from the result
	syscall	
	li	$v0, 4
	la	$a0, newline	# load the address of newline
	syscall
	
	# Step 4 divide the result by 3
	div	$t1, $t1, 3	# divides step 3 result by 3
	la	$a0, step4	# load the address of msg step 4
	syscall
	li	$v0, 1
	move	$a0, $t1	# load the int into $a0, from the result
	syscall	
	li	$v0, 4
	la	$a0, newline	# load the address of newline
	syscall

	# Step 5 add 5 to step 4 result
	addi	$t1, $t1, 5	# adds 5 to the result of step 4
	la	$a0, step5	# load the address of msg step 5
	syscall
	li	$v0, 1
	move	$a0, $t1	# load the int into $a0, from the result
	syscall	
	li	$v0, 4
	la	$a0, newline	# load the address of newline
	syscall

	# Step 6 subtracts the result of step 5 by the number inputed
	sub	$t1, $t1, $t0	# subtracts $t1 (result from step 5) by $t0 (number inputed)
	la	$a0, step6	# load the address of msg step 6
	syscall
	li	$v0, 1
	move	$a0, $t1	# load the int into $a0, from the result
	syscall	
	li	$v0, 4
	la	$a0, newline	# load the address of newline
	syscall
	
	# Step 7 prints the answer
	la	$a0, step7	# load the address of msg step 7
	syscall
	li	$v0, 1
	move	$a0, $t1	# load the int into $a0, from the result
	syscall	
	li	$v0, 4
	la	$a0, newline	# load the address of newline
	syscall


	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit


	.data

msg1:	.asciiz	"Input an integer:   "
step1:	.asciiz "Step 1 Result:   "
step2:	.asciiz "Step 2 Result:   "
step3:	.asciiz "Step 3 Result:   "
step4:	.asciiz "Step 4 Result:   "
step5:	.asciiz "Step 5 Result:   "
step6:	.asciiz "Step 6 Result:   "
step7:	.asciiz "Step 7 Result:   "
newline:   .asciiz	"\n"
