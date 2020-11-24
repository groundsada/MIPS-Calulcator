# MIPS - Calculator
# Author: groundsada
# Github: github.com/groundsada

#register variables:
#$t0 is user menu option
#$s0 is operand 1
#$s1 is operand 2
#$s2 is result of calculation



# text section
.text
	.globl main
main:
	#print welcoming message
	li $v0, 4
	la $a0, welcome
	syscall

printMenu:
	#print menu options
	li $v0, 4
	la $a0, menu
	syscall

	#read menu option int
	li $v0, 5
	syscall
	move $t0, $v0	#chosen menu option is stored in $t0
	beq $t0, 1, addition	
	beq $t0, 2, multiAdd
	beq $t0, 3, subtraction
	beq $t0, 4, multiSub
	beq $t0, 5, multiplication
	beq $t0, 6, multiMult
	beq $t0, 7, division
	beq $t0, 8, multiDiv
	beq $t0, 9, mod
	beq $t0, 10, square
	beq $t0, 11, power
	beq $t0, 12, factorial
	beq $t0, 13, sumNtoM	
	beq $t0, 14, boolAnd
	beq $t0, 15, boolOr
	beq $t0, 16, boolXor
	beq $t0, 17, boolNor
	beq $t0, 18, exit

	#in case user inputs invalid integer, print invalid message and reprint menu
	li $v0, 4
	la $a0, selInvalid
	syscall
	j printMenu

addition:
	#print addition message
	li $v0, 4
	la $a0, sel1
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A


	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	add $s2, $s0, $s1

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu


multiAdd:
	#print multiple operand addition message
	li $v0, 4
	la $a0, sel2
	syscall

	#print please enter the number of operands
	li $v0, 4
	la $a0, enterOperands
	syscall

	#read $s0
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = number of operands, which is the number of repetitions
	# A + B is 2 additions (0+A) then (answer +B)
	
	li $s2 , 0			#$s2 is the answer, we initialize it to 0
	multiAddLoop:
		#print please enter operand
		li $v0, 4
		la $a0, enterOp
		syscall

		#read operand
		li $v0, 5
		syscall
		move $s1, $v0		#$s0 = operand

		#add operand to sum
		add $s2, $s2, $s1	#result =result + operand

		addi $s0, -1		#loop repetitions -1

		#loop condition
		bgt	$s0, 0, multiAddLoop	#if repetitions > 0, go to loop again

	
	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu


subtraction:
	#print subtraction message
	li $v0, 4
	la $a0, sel3
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A

	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	sub $s2, $s0, $s1	#s2 = A - B

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu


multiSub:
	#print mulitple operand subtraction message
	li $v0, 4
	la $a0, sel4
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A, A is loaded into result ($s2) then each operand is subtracted from $s2
	li $v0, 5
	syscall
	move $s2, $v0		#we initialize $s2 which is the answer to A, then we subtract each operand from A

	#print please enter the number of operands you want subtracted from A
	li $v0, 4
	la $a0, enterMultiSubOperands
	syscall

	#read $s0
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = number of operands, which is the number of repetitions

	
	multiSubLoop:
		#print please enter operand
		li $v0, 4
		la $a0, enterOp
		syscall

		#read operand
		li $v0, 5
		syscall
		move $s1, $v0		#$s0 = operand

		#subtract operand from the result
		sub $s2, $s2, $s1	#result =result - operand

		addi $s0, -1		#loop repetitions -1

		#loop condition
		bgt	$s0, 0, multiSubLoop	#if repetitions > 0, go to loop again

	
	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu


multiplication:
	#print multiplication message
	li $v0, 4
	la $a0, sel5
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A

	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	mult $s0, $s1	#s2 = A * B
	mflo $s2

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

	
multiMult:
	#print multiple operand multiplcation message
	li $v0, 4
	la $a0, sel6
	syscall

	#print please enter the number of operands
	li $v0, 4
	la $a0, enterOperands
	syscall

	#read $s0
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = number of operands, which is the number of repetitions
	# A * B is 2 multiplications (1*A) then (answer *B)
	
	li $s2 , 1			#$s2 is the answer, we initialize it to 1
	multiMultLoop:
		#print please enter operand
		li $v0, 4
		la $a0, enterOp
		syscall

		#read operand
		li $v0, 5
		syscall
		move $s1, $v0		#$s0 = operand

		#add operand to sum
		mult $s2, $s1	#result * operand
		mflo $s2		#store in result

		addi $s0, -1		#loop repetitions -1

		#loop condition
		bgt	$s0, 0, multiMultLoop	#if repetitions > 0, go to loop again

	
	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu


division:
	#print division message
	li $v0, 4
	la $a0, sel7
	syscall

	divLoop:
	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A

	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	beq $s1, 0, divByZero

	#calculations:
	div $s0, $s1	#s2 = A / B
	mflo $s2

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

	divByZero:
		#print can't divide by zero
		li $v0, 4
		la $a0, divZero
		syscall
		j divLoop
multiDiv:
	#print multiple operand division message
	li $v0, 4
	la $a0, sel8
	syscall
	
	multiDivFromTop:
	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A, A is loaded into result ($s2) then $s2 is divided by each operand
	li $v0, 5
	syscall
	move $s2, $v0		#we initialize $s2 which is the answer to A, then we divide $s2 by each operand

	#print please enter the number of operands you want subtracted from A
	li $v0, 4
	la $a0, enterMultiDivOperands
	syscall

	#read $s0
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = number of operands, which is the number of repetitions

	
	multiDivLoop:
		#print please enter operand
		li $v0, 4
		la $a0, enterOp
		syscall

		#read operand
		li $v0, 5
		syscall
		move $s1, $v0		#$s0 = operand

		beq $s1, 0, mutliDivByZero

		#divide result by operand
		div $s2, $s1	#result = result / operand
		mflo $s2

		addi $s0, -1		#loop repetitions -1

		#loop condition
		bgt	$s0, 0, multiDivLoop	#if repetitions > 0, go to loop again

	
	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

	mutliDivByZero:
		#print can't divide by zero
		li $v0, 4
		la $a0, divZero
		syscall
		j multiDivFromTop
mod:
	#print modulo message
	li $v0, 4
	la $a0, sel9
	syscall
	
	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A

	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	div $s0, $s1	#s2 = A % B
	mfhi $s2

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu
square:
	#print square message
	li $v0, 4
	la $a0, sel10
	syscall
	
	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A

	#calculations:
	mult $s0, $s0	#s2 = A * A
	mflo $s2

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu
power:
	#print power message
	li $v0, 4
	la $a0, sel11
	syscall
	
	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A

	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B
	li $s2, 1			#$s2 is result, initialized to 1

	powerLoop:
		mult $s2, $s0	#s2 = $s2 * A
		mflo $s2

		addi $s1, -1		#loop repetitions -1

		#loop condition
		bgt	$s1, 0, powerLoop	#if repetitions > 0, go to loop again

	#calculations:
	

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

factorial:
	#print factorial message
	li $v0, 4
	la $a0, sel12
	syscall
	
	factorialLoop:
		#print please enter N
		li $v0, 4
		la $a0, enterN
		syscall

		#read N
		li $v0, 5
		syscall
		move $s0, $v0		#$s0 = N, which is also the number of repetition

		blt	$s0, 0, invalidFactorial
		blt $s0, 2, factorialOne	#either one or zero, N! = 1
		
		#else (N > 1)
		li $s2, 1			#$s2 is result, it is initialized to 1
		factorialCalculation:
			mult $s2, $s0
			mflo $s2
			addi $s0, $s0, -1
			bgt	$s0, 0, factorialCalculation
			#print result
			li $v0, 4
			la $a0, answer
			syscall
			li $v0, 1
			move $a0, $s2
			syscall
			
			j printMenu

	invalidFactorial:
		#print invalid msg
		li $v0, 4
		la $a0, invalidFac
		syscall
		j factorialLoop

	factorialOne:
		#print result
		li $v0, 4
		la $a0, answer
		syscall
		li $v0, 1
		li $a0, 1
		syscall
		
		j printMenu
	

sumNtoM:
	#print sum from n to m message
	li $v0, 4
	la $a0, sel13
	syscall

	sumLoop:
		#print please enter A
		li $v0, 4
		la $a0, enterA
		syscall

		#read A
		li $v0, 5
		syscall
		move $s0, $v0		#$s0 = A

		#print please enter B
		li $v0, 4
		la $a0, enterB
		syscall

		#read B
		li $v0, 5
		syscall
		move $s1, $v0		#$s1 = B

	ble	$s1, $s0, invalidSum

	#else, which means valid sum
	#calculations:
	li $s2, 0				#$s2 (result) is initialized to 0 (sum neutral)
	sumCalcLoop:
		add $s2, $s2 , $s0
		addi $s0, $s0, 1
		ble $s0, $s1, sumCalcLoop
	
	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

	invalidSum:
		#print invalid sum msg
		li $v0, 4
		la $a0, invalidSumMsg
		syscall
		j sumLoop

boolAnd:
	#print AND message
	li $v0, 4
	la $a0, sel14
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A


	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	and $s2, $s0, $s1

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu


boolOr:
	#print AND message
	li $v0, 4
	la $a0, sel15
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A


	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	or $s2, $s0, $s1

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

boolXor:
	#print XOR message
	li $v0, 4
	la $a0, sel16
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A


	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	xor $s2, $s0, $s1

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu
	
boolNor:
	#print NOR message
	li $v0, 4
	la $a0, sel17
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A


	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	nor $s2, $s0, $s1

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

exit:
	#print exit msg
	li $v0, 4
	la $a0, sel14
	syscall
	#exit the program
	li $v0 ,10
	syscall


	
# data section
.data
	welcome: .asciiz "Welcome to my MIPS calculator!"
	
	#menu option string
	menu: .asciiz "\n\nMenu options:\n1. Addition (C = A + B)\n2. Multiple Operand Addition (A + B + C...)\n3. Subtraction (C = A - B)\n4. Multiple Operand Subtraction (A - B - C - D...)\n5. Multiplication (C = A × B)\n6. Multiple Operand Multiplication (A × B × C × D...)\n7. Division (C = A / B)\n8. Multiple Operand Division (A / B / C / D...)\n9. Modulo (C = A % B)\n10. Square (C = A ^ 2)\n11. Power (C = A ^ B)\n12. Factorial (N! = N × (N-1) × (N-2)...×1)\n13. Sum(A,B) (C = A + A+1 + A+2 ... + B) where (A<B)\n14. AND (Bitwise Operation)\n15. OR (Bitwise Operation)\n16. XOR (Bitwise Operation)\n17. NOR (Bitwise Operation)\n18. Exit the Program\nPlease enter an option: "
	# I put all the menu options in one string in order to have simpler code by printing only one string to view menu

	#selection strings
	sel1: .asciiz "You have selected addition operation. A + B = C\n"
	sel2: .asciiz "You have selected multiple operand addition operation. A + B + C...\n"
	sel3: .asciiz "You have selected subtraction operation. A - B = C\n"
	sel4: .asciiz "You have selected multiple operand subtraction operation. A - B - C...\n"
	sel5: .asciiz "You have selected multiplication operation. A * B = C\n"
	sel6: .asciiz "You have selected multiple operand multiplication operation. A * B * C...\n"
	sel7: .asciiz "You have selected division operation. A / B = C\n"
	sel8: .asciiz "You have selected multiple operand division operation. A / B / C...\n"
	sel9: .asciiz "You have selected modulo operation. A % B = C\n"
	sel10: .asciiz "You have selected square operation. A ^ 2 = C\n"
	sel11: .asciiz "You have selected power operation. A ^ B = C\n"
	sel12: .asciiz "You have selected factorial operation. N!\n"
	sel13: .asciiz "You have selected sum(A,B) operation. A + A+1 + A+2 ... +B\n"
	sel14: .asciiz "You have selected AND operation. C = A && B\n"
	sel15: .asciiz "You have selected OR operation. C = A || B\n"
	sel16: .asciiz "You have selected XOR operation. C = A ∨ B\n"
	sel17: .asciiz "You have selected NOR operation. C = A ! B\n"
	sel18: .asciiz "You have selected exiting the program.\nProgram Terminated.\n"
	selInvalid: .asciiz "Invalid choice. Please try again.\n"

	answer: .asciiz "The answer is: "

	enterA: .asciiz "Please enter A: "
	enterB: .asciiz "Please enter B: "
	enterN: .asciiz "Please enter N: "
	enterOperands: .asciiz "Please enter the number of operands: "
	enterOp: .asciiz "Please enter an operand: "
	enterMultiSubOperands: .asciiz "Please enter the number of operands you want subtracted from A: "
	enterMultiDivOperands: .asciiz "Please enter the number of operands you want A divided by: "
	invalidFac: .asciiz "Invalid input. Pleasee enter a positive integer.\n"
	invalidSumMsg: .asciiz "Invalid input. Input must be B > A. Please try again.\n"
	divZero: .asciiz "Can't divide by zero. Please try again.\n"	
	ovf: .asciiz "Arithmetic Overflow. Operantion aborted."