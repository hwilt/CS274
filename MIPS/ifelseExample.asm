# If statement demo

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
foo:	li $t1, 8		# int i =8;
	li $t2, 9		# int j=9;
	li $t3, 2		# int g=2;
	li $t4, 1		# int h=1;
	
	#The following code implements:
	#if (i==j){
        #	f = g+h;	//Call this the "true" clase
        # }else{
        #       f = g-h;	//Call this the "false" clause
        # }
	
	bne $t1,$t2, Else	# if i and j are not equal, branch to "false" clause	
	add $s0,$t3,$t4		# if i and j were equal, no branch occured, "true" clause executes
	j Exit			# after executing the "true clause" skip the "false" clause
Else:	sub $s0,$t3,$t4		# "false" clause code
Exit:				# landing spot after the "true" clause has been executed

	# Now for the output.... 
	# Print string msg1
	li	$v0, 4		#system call code for print NT string
	la	$a0, msg1	#load address of first char in message
	syscall
	
	# Print value in register
	li	$v0, 1		#system call for print integer
	move	$a0, $s0	#put value to print in register
	syscall

	# Exit the program by means of a syscall.
	# There are many syscalls - pick the desired one
	# by placing its code in $v0. The code for exit is "10"
	#li $v0, 10 # Sets $v0 to "10" to select exit syscall
	#syscall # Exit

	# All memory structures are placed after the
	# .data assembler directive
	.data

	# The .word assembler directive reserves space
	# in memory for a single 4-byte word (or multiple 4-byte words)
	# and assigns that memory location an initial value
	# (or a comma separated list of initial values)
result:	.word 12
msg1:	.asciiz	"f:  "
