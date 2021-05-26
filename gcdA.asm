#####################################################

#    EE3450 Computer Architecture - Spring 109      #

#    Project: Find Greatest Common Divisors (GCD)   #

#    Recursive method (gcdA.asm)                    #

#####################################################



.data



msg1: .asciiz "Please give 2 integers separated by enter:\n"

msg2: .asciiz "The greatest common divisor is "



.text



.globl main

main: 



	li		$v0, 4 			# prepare syscall 4 (print string)

	la		$a0, msg1 		# argument: msg1

	syscall



	li		$v0, 5 			# prepare syscall 5 (get int)

	syscall

    move	$s0, $v0



	li		$v0, 5 			# prepare syscall 5 (get int)

	syscall

    move	$s1, $v0

	

	# TODO

	move	$a0, $s0

	move	$a1, $s1

	jal		gcd				# jump to gcd and save position to $ra





	li		$v0, 4 			# prepare syscall 4 (print string)

	la		$a0, msg2 		# argument: msg2 

	syscall





	li		$v0, 1 			# prepare syscall 1 (print int)

	move	$a0, $s0 		# argument: gcd value

	syscall



exit:



	li		$v0, 10 		# terminate program run and

	syscall 				# Exit



gcd:

	beq		$a0, $a1, ret_same

	bgt		$a0, $a1, ret_a_bigger

	bgt		$a1, $a0, ret_b_bigger



ret_same:

	move	$s0, $a0

	j		ret						# jump to ret



ret_a_bigger:

	addi	$sp, $sp, -4			# make room for stack push. we must do this before recursive call.

	sub		$a0, $a0, $a1			# a = a - b

	sw		$ra, 0($sp)				# push return address to the stack.

	jal		gcd

	lw		$ra, 0($sp)				# pop return address from the stack.

	addi	$sp, $sp, 4				# restore the stack

	j		ret						# jump to ret

	



ret_b_bigger:

	addi	$sp, $sp, -4			# make room for stack push. we must do this before recursive call.

	sub		$a1, $a1, $a0			# b = b - a

	sw		$ra, 0($sp)				# push return address to the stack.

	jal		gcd

	lw		$ra, 0($sp)				# pop return address from the stack.

	addi	$sp, $sp, 4				# restore the stack

	j		ret						# jump to ret





ret:

	jr		$ra					# jump to $ra

		