# Author: Henry Wilt
# Class: CS274
# Feburay 17th, 2021

	.globl main 

	.text 
	
main:
	# Printing out first message
	li	$v0, 4 		# syscall 4 is print string
	la	$a0, msg1	# the message "I am compliling code. I am a complier!"
	syscall
	
	# Printing out a new line
	la	$a0, newline	# new line
	syscall
	
	# these will be are constants
	li $t0, 9	# int i = 9
	li $t1, 10	# int j = 10
	li $t2, 88	# int k = 88
	li $t3, 109	# int q = 109
	
	# int r = i+j – (k+q);
	add $t4, $t0, $t1	# $t4 = i + j
	add $t5, $t2, $t3	# $t5 = k + q
	sub $t6, $t4, $t5	# $t6 = r = $t4 - $t5
	
	# Printing out int r
	la	$a0, msg2	# the message "r = "
	syscall
	
	li 	$v0, 1		# changes the call to registers/ integers
	move 	$a0, $t6	# prints the register $t6 which is r
	syscall
	
	# Printing out a new line
	li	$v0, 4		# changes the call to string
	la	$a0, newline	# new line
	syscall
	
	# int q = q / 2
	div $t3, $t3, 2		# divides q by 2 and sets it back to q
	
	# Printing out int q
	la	$a0, msg3	# the message "q = "
	syscall
	
	li 	$v0, 1		# changes the call to registers/ integers
	move 	$a0, $t3	# prints the register $t6 which is r
	syscall
	
	# Printing out a new line
	li	$v0, 4		# changes the call to string
	la	$a0, newline	# new line
	syscall
	
	# int k = k * 4
	mul $t2, $t2, 4		# mulitplys k by 4 which is set back into $t2
	
	# Printing out int k
	la	$a0, msg4	# the message "k = "
	syscall
	
	li 	$v0, 1		# changes the call to registers/ integers
	move 	$a0, $t2	# prints the register $t6 which is r
	syscall
	
	
	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exitx

	.data
	
msg1:	.asciiz	"I am compiling code.  I am a compiler!"
msg2:	.asciiz	"r =   "
msg3:	.asciiz	"q =   "
msg4:	.asciiz	"k =   "
newline:   .asciiz	"\n"