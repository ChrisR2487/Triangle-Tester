		.data
choice:		.word 0 	# declare variable of type .word and initialize it to 0	

prompt1: 	.asciiz "Please enter 3 positive integers by pressing <enter> after each:\n"		# String variables
prompt2:	.asciiz "Do you want to test more integers? (Type 0 to quit, 1 to run again.): "
trueLabel:	.asciiz "The integers DO form a triangle!\n"
falseLabel:	.asciiz "The integers do NOT form a triangle!\n"
error:		.asciiz "Invalid entry!\n"
newLine:	.asciiz "\n"

		.text
		.globl main
main:		
		addi $s4, $zero, -1 	# $s4 is -1 to avoid problems with loop conditional
		
		loop:
			beq $s4, 0, exit

			li $v0, 4			# Load system call code to print a string
				
			la $a0, prompt1			# Load address of "prompt"
			syscall				# Print contents of "prompt"
			# num1
			li $v0, 5			# Get user input for "num1"
			syscall				# Read the integer into $v0
			move $s0, $v0			# Copy contents of $v0 into $s0
			ble $s0, 0, printError		# If user input <= 0 print error
			# num2
			li $v0, 5			# Get user input for "num2"
			syscall				# Read the integer into $v0
			move $s1, $v0			# Copy contents of $v0 into $s1
			ble $s1, 0, printError		# If user input <= 0 print error
			# num3
			li $v0, 5			# Get user input for "num3"
			syscall				# Read the integer into $v0
			move $s2, $v0			# Copy contents of $v0 into $s2
			ble $s2, 0, printError		# If user input <= 0 print error
					
			add $s3, $s0, $s1		# $s3 = $s1 + $s2
		
			ble $s3, $s2, else		# If $s3 <= $s2 branch to "else"
			j isTriangle			# Jump over else body when the above conditonal is false
			
	else: 		li $v0, 4			# Load system call code to print a string
			la $a0, falseLabel		# Load address of "falseLabel"
			syscall				# Print contents of "falseLabel"
			j userChoice			# Jump to "userChoice" to prompt user if they want to test more integers
		
	isTriangle:	li $v0, 4			# Load system call code to print a string
			la $a0, trueLabel		# Load address of "trueLabel"
			syscall				# Print contents of "trueLabel"
		
	userChoice:	li $v0, 4			# Load system call code to print a string
			la $a0, prompt2			# Load address of "prompt2"
			syscall				# Print contents of "prompt2"
		
			li $v0, 5			# Get user input for program restart
			syscall				# Read the integer into $v0
			
			move $s4, $v0			# Copy contents of $v0 into $s2
			sw $s4, choice			# Store contents of $s4 into "choice"
			
			j loop				# Jump to start of loop to check user input 
			
		exit:
		li $v0, 10			# load system call to exit
		syscall				# terminate program
													
					
printError:	li $v0, 4			# Load system call code to print a string
		la $a0, error			# Load address of "error"
		syscall				# Print contents of "error"
		j main				# Jump to "main" to restart program
		
printNewLine: 	li $v0, 4			# Load system call code to print a string
		la $a0, newLine			# Load address of "newLine"
		syscall				# Print contents of "newLine"

							
		
