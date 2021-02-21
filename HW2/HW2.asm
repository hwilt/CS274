# Author: Henry Wilt
# Class: CS274
# Feburay 28th, 2021

	.globl main 

	.text 
								
main:
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
	
	#check if number of rows is below zero
	slti	$s1,$t0,0	# sets $s1 to 0 if $t0 is greater than 0
	bne	$s1,$zero,rows	# if not equal to zero than goes and asks for a new number
	
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
	
	# $t8 = 2 * rows
	move 	$t8,$t0
	mul	$t8,$t8,2	# $t8 = 2 * $t8(rows)
	
	# $t9 = 2 * rows - 1
	sub	$t9,$t8,1	# $t9 = $t8(2 * rows) - 1
	
	# begining of the loop (starting conditions)
	li 	$t2, 1		# $t2 = i
	li 	$t3, 0		# $t3 = j 
	li 	$t4, 0		# $t4 = k
	li	$t5,0		# int spaces = 0
Loop_Main:
	beq 	$t0, $t2, Loop_Last	# checks if it's the last row
	# Printing out the Hollow Pyramid
	move	$t3,$t2		# sets j = i
	Loop_printSpace1:
		li	$v0,11		# print_character syscall code = 11
		li	$a0,32		# 32 is the ascii code for whitespace 
		syscall
		addi	$t3,$t3,1	# increments j by 1
		slt	$s1,$t3,$t0	# compares j to rows	
		bne	$s1,$zero,Loop_printSpace1
		
	Loop_whileHollow:
			beq	$t4,$zero,IF	# if k == 0 then go to IF
			mul	$t7,$t2,2	# i * 2
			sub	$t7,$t7,2	# $t7(i * 2) - 2
			bne	$t4,$t7,Else	# if k != 2 * i - 2 then go to else
		IF:
			li	$v0, 11 	# print_character syscall code = 11
			move	$a0, $t1	# moves character to printing
			syscall
			j	Exit		# skipping the false claim
		Else:
			li	$v0,11	 	# print_character syscall code = 11
			la	$a0,32		# 32 is the ascii code for whitespace
			syscall
		Exit:
		mul	$t7,$t2,2	# i * 2
		sub	$t7,$t7,1	# $t7(i * 2) - 1
		addi 	$t4,$t4,1	# increments k by 1
		bne	$t4,$t7,Loop_whileHollow		# checks if k != (2 * i - 1)
		
		
		
	# Printing out the Filled Pyramid 
	li	$t4, 0		# set k back to zero
	move	$t3,$t2		# sets j = i
	Loop_printSpace3:
		li	$v0,11		# print_character syscall code = 11
		la	$a0,32		# 32 is the ascii code for whitespace
		syscall
		addi	$t3,$t3,1	# increments j by 1	
		bne	$t3,$t8,Loop_printSpace3	# checks if j != rows * 2
		
	move	$t5,$t2		# int spaces = i
	Loop_printSpace4:
		li	$v0,11		# print_character syscall code = 11
		la	$a0,32		# 32 is the ascii code for whitespace
		syscall
		addi	$t5,$t5,1	# increments spaces by 1	
		bne	$t5,$t0,Loop_printSpace4 	# checks if spaces != rows
	
	Loop_whileFilled:
		li	$v0, 11 	# print_character syscall code = 11
		move	$a0, $t1	# moves character to printing
		syscall
		mul	$t7,$t2,2	# i * 2
		sub	$t7,$t7,1	# $t7(i * 2) - 1
		addi 	$t4,$t4,1	# increments k by 1
		bne	$t4,$t7,Loop_whileFilled		# checks if k != (2 * i - 1)	
	
	li	$v0,4		
	la	$a0, newline	# load the address of newline
	syscall
	li	$t4, 0		# set k back to zero
	addi	$t2,$t2,1	# increments i by 1
	j	Loop_Main	# jumps back up to the top of the loop
	
Loop_Last:
	li 	$t2, 0		# i = 0
	Loop_printChar1:
		li	$v0, 11 	# print_character syscall code = 11
		move	$a0, $t1	# moves character to printing
		syscall	
		addi	$t2,$t2,1	# increments i by 1
		slt	$s1,$t2,$t9	# checks if i < 2 * rows - 1
		bne	$s1,$zero,Loop_printChar1 

	li	$t5,0		# int spaces = 0
	Loop_printSpace5:
		li	$v0,11		# print_character syscall code = 11
		li	$a0,32		# 32 is the ascii code for whitespace
		syscall
		addi	$t5,$t5,1	# increments space by 1	
		bne	$t5,$t0,Loop_printSpace5	# if spaces != rows then loop again
	
	li 	$t2, 0		# i = 0
	Loop_printChar2:
		li	$v0, 11 	# print_character syscall code = 11
		move	$a0, $t1	# moves character to printing
		syscall	
		addi	$t2,$t2,1	# increments i by 1
		slt	$s1,$t2,$t9	# checks if i < 2 * rows - 1
		bne	$s1,$zero,Loop_printChar2
	
	
	li $v0, 10 		# Sets $v0 to "10" to select exit syscall
	syscall 
	
	
	.data
	
msg1:	.asciiz		"Enter the number of rows: "
msg2:	.asciiz		"Enter the character for the pyramid: "
newline: 	.asciiz		"\n"
