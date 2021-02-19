# Author: Henry Wilt
# Class: CS274
# Feburay 17th, 2021

	.globl main 

	.text 
	
main:
	
	
	
	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit
	
	
	.data
	
newline:   .asciiz	"\n"