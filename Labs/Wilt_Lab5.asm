

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
	li 	$s0, 18
	li 	$s1, 25			
	
	# Print $s0
	li	$v0,1		# print_int syscall code = 1
	move	$a0, $s0	# Load integer to print in $a0
	syscall
	
	# Print newline
	li	$v0,4		# print_string syscall code = 4
	la	$a0, lf
	syscall

	# Print $s1
	li	$v0,1		# print_int syscall code = 1
	move	$a0, $s1	# Load integer to print in $a0
	syscall
	
	# Print newline
	li	$v0,4		# print_string syscall code = 4
	la	$a0, lf
	syscall

	
	jal	m1		#call m1
	
	
	# Print $s0
	li	$v0,1		# print_int syscall code = 1
	move	$a0, $s0	# Load integer to print in $a0
	syscall
	
	# Print newline
	li	$v0,4		# print_string syscall code = 4
	la	$a0, lf
	syscall

	# Print $s1
	li	$v0,1		# print_int syscall code = 1
	move	$a0, $s1	# Load integer to print in $a0
	syscall
	
	# Print newline
	li	$v0,4		# print_string syscall code = 4
	la	$a0, lf
	syscall


	
	
	j Exit
	
m1:
	addi	$sp,$sp,-8	# move back the stack pointer by 8
	sw	$s0,4($sp)	# store $s0 in the stack by an offset of 4
	sw	$s1,0($sp)	# store $s1 in the stack by an offest of 0
	
	addi 	$s0, $s0,5
	add 	$s1,$s0,$s1
	
	lw	$s0,4($sp)	# load $s0 back from the stack by an offset of 4
	lw	$s1,0($sp)	# store $s1 back from the stack by an offest of 0
	addi	$sp,$sp,8	# move forward the stack pointer by 8
	
	jr $ra			# Return from m1





	
Exit:	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit


	.data

	# The .word assembler directive reserves space
	# in memory for a single 4-byte word (or multiple 4-byte words)
	# and assigns that memory location an initial value
	# (or a comma separated list of initial values)
	
result:	.word 12
lf:	.asciiz"\n"
