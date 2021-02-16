# Author: Henry Wilt
# Class: CS274
# Feburay 16th, 2021

	.globl main 

	.text 		

# The label 'main' represents the starting point
main:



	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit


	.data

msg1:	.asciiz	"$t4:   "
newline:   .asciiz	"\n"