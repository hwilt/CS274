# Author: Henry Wilt
# CS274
# March 30th, 2021

	.globl main 
	
	.text 
	
main:
#---------Function 1-------------
	# Print out the name of the function
	li	$v0,4		# sycall command - string print
	la	$a0,func1	# load func
	syscall
	la	$a0,newline	# load newline
	syscall
	
	# Print out array
	la	$a0,array	# loads the array for the first procedure
	la	$a1,arraysz	# loads the size of the array for the first procedure
	jal	printArray	# jumpts to the print array method and stores the next instruction in $ra
	
	# Call method
	la	$a0,array	# loads the array for the first procedure
	la	$a1,arraysz	# loads the size of the array for the first procedure
	jal 	findMinMax	# jumps to the find min & max and stores the next instruction in $ra
	
	move	$t0,$v0		# sets the max to $t0
	move	$t1,$v1		# sets the min to $t1
	
	# Printing out the max
	li	$v0,4		# syscall command - print string
	la	$a0,msgMAX	# load string to be printed
	syscall
	li	$v0,1		# syscall command - print int
	move	$a0,$t0		# move the max to be printed
	syscall
	li	$v0,4		# sycall command - string print
	la	$a0,newline	# load newline
	syscall
	
	# Printing out the min
	li	$v0,4		# syscall command - print string
	la	$a0,msgMIN	# load string to be printed
	syscall
	li	$v0,1		# syscall command - print int
	move	$a0,$t1		# move the min to be printed
	syscall
	li	$v0,4		# sycall command - string print
	la	$a0,newline	# load newline
	syscall
	
	# Print out array
	la	$a0,array	# loads the array for the first procedure
	la	$a1,arraysz	# loads the size of the array for the first procedure
	jal	printArray	# jumpts to the print array method and stores the next instruction in $ra

	# Print out new line
	li	$v0,4		# sycall command - string print
	la	$a0,newline	# load newline
	syscall
	
#---------Function 2------------
	
	# Print out the name of the function
	li	$v0,4		# sycall command - string print
	la	$a0,func2	# load func
	syscall
	la	$a0,newline	# load newline
	syscall
	
	# Print orginial String
	li	$v0,4		# syscall command - print string
	la	$a0,msgOrginial	# load string to be printed
	syscall
	la	$a0,string	# load string to be printed
	syscall
	la	$a0,newline
	syscall
	
	# Call method
	la	$a0,string	# loads the string 
	jal 	CapString	# jumps to the capstring method and stores the next instruction in $ra
	move	$t0,$v0		# moves the capitizedString into $t0
	
	# Print orginial String
	li	$v0,4		# syscall command - print string
	la	$a0,msgOrginial	# load string to be printed
	syscall
	la	$a0,string	# load string to be printed
	syscall
	la	$a0,newline
	syscall
	
	# Print Capitalized String
	li	$v0,4			# syscall command - print string
	la	$a0,msgCapitalized	# load string to be printed
	syscall
	la	$a0,($t0)		# load string to be printed
	syscall
	la	$a0,newline
	syscall
	
	# Print out new line
	li	$v0,4		# sycall command - string print
	la	$a0,newline	# load newline
	syscall
	
#---------Function 3-------------
	
	# Print out the name of the function
	li	$v0,4		# sycall command - string print
	la	$a0,func3	# load func
	syscall
	la	$a0,newline	# load newline
	syscall
	
	# Call the method
	jal 	userAsking	# jumps to the first procedure and stores the next instruction in $ra
	la	$t0,($v0)	# $t0 = input
	la	$v0,($v1)	# $t1 = value
	
	# Echo the input
	
	# Print Decimal Value or "Improper Input"
	


	li $v0, 10 		# Sets $v0 to "10" to select exit syscall
	syscall

#--------------PrintArray-------------------------
	# Prints the array
	# 
	# Arguments:
	# $a0 - array
	# $a1 - size of array
	# no returns
printArray:
	# Register Map:
	# $t3 - size
	# $t1 - array
	# $t2 - loop counter
	
	lw	$t3,($a1)	# set the size
	la	$t1,($a0)	# set address of array
	li	$t2,1		# set loop counter
	
	printLoop:
		beq	$t2,$t3, printEnd	# check if at end of array
		# printing out the element
		li	$v0,1			# syscall command - int print
		lw	$a0,($t1)		# load word
		syscall
		# print new line
		li	$v0,11			# sycall command - character print
		li	$a0,44			# load newline
		syscall
		
		addi	$t2,$t2,1		# increment loop counter by 1
		addi	$t1,$t1,4		# increment array pointer
		j	printLoop		# repeat loop
	printEnd:
		# printing out last element
		li	$v0,1			# syscall command - int print
		lw	$a0,($t1)		# load word
		syscall
	# print a newline
	li	$v0,4		# sycall command - string print
	la	$a0,newline	# load newline
	syscall	
	jr	$ra		# Returns to the main method


#--------------findMinMax-------------------------
	# Finds the Min & Max in an Array
	# 
	# Arguments:
	# $a0 - array
	# $a1 - size of array
	#
	# Returns:
	# $v0 - max
	# $v1 - min
findMinMax:
	# Register Map:
	# $t0 = current max
	# $t1 = current min
	# $t2 = int i
	# $t3 = array
	# $t4 = array size	
	
	# find max in java
	# public static int getMax(int[] inputArray){ 
	#	int maxValue = inputArray[0]; 
    	# 	for(int i=0;i < inputArray.length;i++){ 
      	# 		if(inputArray[i] > maxValue){ 
        # 			maxValue = inputArray[i]; 
      	# 		} 
    	# 	} 
    	# 	return maxValue; 
  	# }
		
  	getMax:
  		la	$t3,($a0)	# set address of array
  		lw	$t4,($a1)	# set the size
  		li	$t2,1		# int i = 1
  		lw	$t0,($t3)	# set starting max
  		getMax_For:
  			blt	$t3,$t0,Max_Else	# branch if current element is less than current max
  			lw	$t0,($t3)		# set current max
  			Max_Else:
  			addi	$t3,$t3,4		# increment by 4 to get to the next element
  			addi	$t2,$t2,1		# increment i by 1
  			ble	$t2,$t4,getMax_For	# branch if i is less than array length 
  	move	$v0,$t0		# set the first return register to current max	
  	  	  	
  	  	
  	# find min in java
	# public static int getMax(int[] inputArray){ 
	#	int minValue = inputArray[0]; 
    	# 	for(int i=1;i < inputArray.length;i++){ 
      	# 		if(inputArray[i] < minValue){ 
        # 			minValue = inputArray[i]; 
      	# 		} 
    	# 	} 
    	# 	return maxValue; 
  	# }
	
	getMin:
  		la	$t3,($a0)	# set address of array
  		lw	$t4,($a1)	# set the size
  		li	$t2,1		# int i = 1
  		lw	$t1,($t3)	# set starting min
  		getMin_For:
  			bgt	$t3,$t1,Min_Else	# branch if current element is less than current min
  			lw	$t1,($t3)		# set current max
  			Min_Else:
  			addi	$t3,$t3,4		# increment by 4 to get to the next element
  			addi	$t2,$t2,1		# increment i by 1
  			ble	$t2,$t4,getMin_For	# branch if i is less than array length 
  	move	$v1,$t1		# set the second return register to current max	
	jr	$ra		# Returns to the main method
	
	
	
	
#--------------CapString-------------------------
	# Capitalize the string
	# subtract 32 in ascii to get capitalized letters
	# only if the ascii is between 97-122 (ONLY!!)
	#
	# Arguments:
	# $a0 - string
	#
	# Returns:
	# $v0 - capitalized string
CapString:
	# Register Map:
	# $a0 = orginial string pointer
	# $t0 = orginial string current char
	# $t1 = capitalized string 
	# $t2 = null character
	
	# create pointers for both strings
	lb	$t0,($a0)		# orginial string current character
	la	$t1,capString		# capitalized string
	li 	$t2,0x0			# null character
	
	string_For:
		beq	$t2,$t0,IF_NULL		# branch if current character = end of line character
		blt	$t0,0x61,notLower 	# branch if current character < 0x61 or 'a'
		bgt	$t0,0x7A,notLower	# branch if current character > 0x7A or 'z'
		
		# subtract the current char by 32 to get the capitalized char
		subi	$t0,$t0,32		# subi
		
		sb	$t0,($t1)		# store char into the capitalized string
		addi	$a0,$a0,1		# move pointer (aka index) to next byte in string
		lb 	$t0,($a0)		# load char at new index
		addi	$t1,$t1,1		# move pointer (aka index) to next byte in string
		j	string_For		# jump back to the start of the loop
		notLower:
		sb	$t0,($t1)		# store char into the capitalized string
		addi	$a0,$a0,1		# move pointer (aka index) to next byte in string
		lb 	$t0,($a0)		# load char at new index
		addi	$t1,$t1,1		# move pointer (aka index) to next byte in string
		j	string_For		# jump back up to the start
	IF_NULL:
	
	# since we have move the address along for the capitalized string
	# we need to reset the current address back to the start
	la	$t1,capString
	
	# return values
	move	$v0,$t1
	jr	$ra		# Returns to the main method
	
	
#--------------User Input-------------------------
	# Ask user for a binary value in two's 
	# complement, calls another method that
	# finds the conversion to Decimal
	#
	# no arguments
	# 
	# Returns:
	# $v0 - binary value
	# $v1 - decimal value (-1 if not proper input)
userAsking:
	# moving the stack pointer
	addi	$sp,$sp,-4	# move the stack pointer down
	sw	$ra,($sp)	# store the return address
	
	# calling the conversion
	jal	convertBtD	# jumps to convert method and stores the return address
	
	# popping the stack
	lw	$ra,($sp)	# pop
	addi	$sp,$sp,4	# move stack pointer back
	
	# return values in shape
	move	$v1,$v0		# move the decimal value from $v0 to $v1
	move	$v0,$t0		# move the binary value into $v0
	
	
	return:
	jr	$ra		# Returns to the main method
	
#--------------Convert Binary to Decimal-------------------------
	# Convert Binary to Decimal
	# 
	# Arguments:
	# $a0 - Binary value
	# 
	# Returns:
	# $v0 - Decimal Value
convertBtD:

	jr	$ra		# Returns to the main method


	.data
	
binary:		.space		255				# space for the user input of binary
decimal:	.space		255				# space for the decimal
string:		.asciiz		"A quick brown fox jumps over the lazy dog."
capString:	.space		255
msgOrginial:	.asciiz		"Orginial: "
msgCapitalized:	.asciiz		"Capitalized: "
array:		.word		1,432,23,22,22,11,2,453		# arrray of integers, 8 words ie elements
arraysz:	.word		8				# array size
msgMAX:		.asciiz		"Max of Array: "
msgMIN:		.asciiz		"Min of Array: "
newline: 	.asciiz		"\n"
func1:		.asciiz		"Function 1:"
func2:		.asciiz		"Function 2:"
func3:		.asciiz		"Function 3:"
