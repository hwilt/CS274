.text
.globl main
main:
# print number 1
li $a0, 1   # number to print
li $v0, 1   # syscall number for printing integer
syscall

li	$t0,5
li	$t5,0		# int spaces = 0
Loop_printSpace5:
	li	$v0,11		# print_character syscall code = 11
	li	$a0,32		# 32 is the ascii code for whitespace
	syscall
	addi	$t5,$t5,1	# increments space by 1
	slt	$s1,$t5,$t0	# compares spaces to rows	
	bne	$s1,$zero,Loop_printSpace5

# print number 2
li $a0, 2
li $v0, 1
syscall

li $v0, 10 		# Sets $v0 to "10" to select exit syscall
syscall 
