#####################################################

#    EE3450 Computer Architecture - Spring 109      #

#    Project: Find Greatest Common Divisors (GCD)   #

#    Iterative method (gcdB.asm)                    #

#####################################################



.data



msg1: .asciiz "Please give 2 integers separated by enter:\n"

msg2: .asciiz "The greatest common divisor is "



.text



.globl main

main: 



	li $v0, 4 		# prepare syscall 4 (print string)

	la $a0, msg1 # argument: msg1

	syscall



	li $v0, 5 		# prepare syscall 5 (get int)

	syscall

    move $s0, $v0



	li $v0, 5 		# prepare syscall 5 (get int)

	syscall

    move $s1, $v0



    ###########################

    #

	jal while

    #

    ###########################



	li $v0, 4 		# prepare syscall 4 (print string)

	la $a0, msg2 	# argument: msg2 

	syscall



	li $v0, 1 		# prepare syscall 1 (print int)

	move $a0, $s0 	# argument: gcd value

	syscall



exit:



	li $v0, 10 		# terminate program run and

	syscall 		# Exit

	



while:

	beq $s0 $s1 equal

	bgt $s0 $s1 a_big

	bgt $s1 $s0 b_big



equal:

	jr			$ra					# jump to $ra



a_big:

	sub		$s0 $s0 $s1

	j		while				# jump to while

	

b_big:

	sub		$s1 $s1 $s0

	j		while				# jump to while

	



	



	



