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
	move	$t0,$v0		# $t0 = input
	move	$t1,$v1		# $t1 = value
	
	# Echo the input
	li	$v0,4
	la	$a0,binaryEcho	# load the address of the string
	syscall
	move	$a0,$t0		# move the input into the argument for the printout
	syscall
	
	# Print Decimal Value or "Improper Input"
	bne	$t9,-1,correct_input	# branch if $t9 which is the key to see if its improper != -1
	improper_input:
	li	$v0,4
	la	$a0,improper	# load the address of the string
	syscall
	j	Exit_Program
	correct_input:
	li	$v0,4
	la	$a0,decimalEcho	# load the address of the string
	syscall
	li	$v0,1
	move	$a0,$t1		# move the input into the argument for the printout
	syscall
	
	
	Exit_Program:
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
	
	# print out the message to ask for the binary digit
	li	$v0,4
	la	$a0,msgBinary	# loads the address of the string to be printed
	syscall
	# read the incoming string of binary digits
	li	$v0,8
	la	$a0,binary	# loads the address of the buffer
	li	$a1,32		# loads the max number of character to be read
	syscall
	
	# check if the input is proper
	lb	$t0,($a0)	# binary value pointer
	for_check:
		beq	$t0,0xA,Exit_check	# branch if current byte equals newline character
		beq	$t0,0x30,if_check	# branch if current byte equals 0
		bne	$t0,0x31,else_check	# branch if current byte equals 1
		if_check:
			addi	$a0,$a0,1	# move pointer (aka index) to next byte in string
			lb 	$t0,($a0)	# load char at new index
			j	for_check	# jump back up to the for start
		else_check:
			li	$t9,-1		# improper value key to -1
			j	return
	Exit_check:
	la	$a0,binary	# load the address of the binary value into $v0
	# moving the stack pointer
	addi	$sp,$sp,-4	# move the stack pointer down
	sw	$ra,($sp)	# store the return address
	
	# calling the conversion
	jal	convertBtD	# jumps to convert method and stores the return address
	
	# popping the stack
	lw	$ra,($sp)	# pop
	addi	$sp,$sp,4	# move stack pointer back
	
	return:
	# return values in shape
	move	$v1,$v0		# move the decimal value from $v0 to $v1
	la	$v0,binary	# load the address of the binary value into $v0

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
	# Register Map:
	# $t0 = binary value pointer
	# $t1 = decimal value
	# $t2 = 0 in ascii (0x30)
	# $t3 = 1 in ascii (0x31)
	# $t4 = newline in ascii (0xA)
	# $t5 = length of the binary value
	# $t6 = i or starting for
	# $t7 = base
	# $t8 = boolean true(1) if negative
	
	# create pointer for the binary
	lb	$t0,($a0)	# binary value pointer
	li	$t1,0		# decimal value 
	li	$t2,0x30	# '0' character
	li	$t3,0x31	# '1' character
	li 	$t4,0xA		# newline character
	li	$t5,0		# length of string
	
	# get the length of the binary digit
	# int length = 0;
	# while(!binary.getChar(i).equals('0xA')){
	#	length++;
	#	next character;
	# }
	for_Length:
		beq	$t0,$t4,Exit_Length	# branch if current byte equals newline character
		addi	$t5,$t5,1	# add 1 to the length
		addi	$a0,$a0,1	# move pointer (aka index) to next byte in string
		lb 	$t0,($a0)	# load char at new index
		j	for_Length	# jump back up to the for start
	Exit_Length:
	# if(first byte not equal 1)
	la	$a0,binary	# load the address of the binary value into $a0
	lb	$t0,($a0)	# binary value pointer
	j	notTwos
	
	# I can not for the life of me figure out how to convert to unsinged correctly
	# this is how far I have gotten on it below
	
	beq	$t0,$t2,notTwos	# branch if first character is equal to 0
	li	$t8,1
	
	
	# convert Two's to unsigned
	li	$t6,1
	convert_Twos:
		beq	$t6,$t5,exit_Convert_Twos
		beq	$t0,$t2,convert_1	# branch if current byte equals 0
		bne	$t0,$t3,reset_Loop	# branch if current byte does not equal 1
		sb	$t2,($a0)	# change byte from a 1 to a 0
		j	reset_Loop
		convert_1:
		sb	$t3,($a0)	# change byte from a 0 to a 1
		reset_Loop:
		addi	$a0,$a0,1	# move pointer (aka index) to next byte in string
		lb 	$t0,($a0)	# load char at new index
		addi	$t6,$t6,1	# increment i by 1
		j	convert_Twos	# jump back up to the for start
	exit_Convert_Twos:
		bne	$t0,$t3,adding_0	# branch if current byte does not equal 1
		sb	$t3,($a0)
		addi	$a0,$a0,-1	# move pointer (aka index) to next byte in string
		lb 	$t0,($a0)	# load char at new index
		j	adding_Twos
		adding_0:
		sb	$t3,($a0)
		addi	$a0,$a0,-1	# move pointer (aka index) to next byte in string
		lb 	$t0,($a0)	# load char at new index
		j	reset_for_conversion
	adding_Twos:
		addi	$a0,$a0,-1	# move pointer (aka index) back a byte in string
		lb 	$t0,($a0)	# load char at new index
		j	convert_Twos	# jump back up to the for start
	
	
	reset_for_conversion:
	# reset the pointer
	la	$a0,binary	# load the address of the binary value into $a0
	lb	$t0,($a0)	# binary value pointer
	
	
	# this is where the code for the unsigned binary works again
	
	# for loop to get through the unsigned binary string
	# int base = 1
	# for(int i = 0; i < length;i++){
	#	if(current byte == ('1')){
	#		decimal += base
	#	}
	#	base = base * 2
	# 	move byte to next one
	# }
	notTwos:
		li	$t7,1		# $t7 = 1 (starting base)
		add	$a0,$a0,$t5	# moves the pointer to the last byte
		addi	$a0,$a0,-1
		lb	$t0,($a0)	# binary value pointer
		li	$t6,0
	
	notTwos_Loop:		# go to notTwos if there is no 1 in the front of the binary string
		bgt	$t6,$t5,Exit_Method	# branch if i < length	
		bne	$t0,$t3,Else_notTwos	# branch if current byte is not 1
		add	$t1,$t1,$t7		# $t1 (decimal value) = decimal value + base
		Else_notTwos:
		mul	$t7,$t7,2		# multiply base by 2
		addi	$t6,$t6,1	# increments i by 1
		addi	$a0,$a0,-1	# move pointer (aka index) back next byte in string
		lb 	$t0,($a0)	# load char at new index
		j	notTwos_Loop	# jump back up
	Exit_Method:

	move	$v0,$t1		# set return value to the decimal value
	jr	$ra		# Returns to the main method


	.data
	
msgBinary:	.asciiz		"Enter a unsigned Binary Number (32 binary digits max): "
binaryEcho:	.asciiz		"The input was: "
decimalEcho:	.asciiz		"The decimal conversion is: "
improper:	.asciiz		"Improper input!"
binary:		.space		255				# space for the user input of binary
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
