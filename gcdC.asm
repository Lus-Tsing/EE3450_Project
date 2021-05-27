#####################################################
#    EE3450 Computer Architecture - Spring 109      #
#    Project: Find Greatest Common Divisors (GCD)   #
#    Binary GCD (gcdC.asm)                          #
#####################################################

.data

msg1: .asciiz "Please give 2 integers separated by enter:\n"
msg2: .asciiz "The greatest common divisor is "

.text

.globl main
main: 

	li $v0, 4 			# prepare syscall 4 (print string)
	la $a0, msg1 		# argument: msg1
	syscall

	li $v0, 5 			# prepare syscall 5 (get int)
	syscall
    move $s0, $v0

	li $v0, 5 			# prepare syscall 5 (get int)
	syscall
    move $s1, $v0

    ###########################
    #
    move	$a0, $s0
	move	$a1, $s1
	jal		gcd			# jump to gcd and save position to $ra
	move	$s0, $v0
    #
    ###########################

	li $v0, 4 			# prepare syscall 4 (print string)
	la $a0, msg2 		# argument: msg2 
	syscall

	li $v0, 1 			# prepare syscall 1 (print int)
	move $a0, $s0 		# argument: gcd value
	syscall

exit:

	li $v0, 10 			# terminate program run and
	syscall 			# Exit
	

gcd: 
	addi 	$s2, $0, 1				# s2 is true

	# check_a_even = (a & 1) == 0;
	andi 	$t0, $a0, 1
	xor		$t0, $t0, $0			# save check_a_even to $t0
	
	#check_b_even = (b & 1) == 0;
	andi 	$t1, $a1, 1
	xor		$t1, $t1, $0			# save check_b_even to $t1

	# equal
	beq		$a0, $a1, equal			# whether a = b
	# a and b are even
	and		$t2, $t0, $t1
	beq		$s2, $t2, ab_even		# whether a, b are even
	# a is even
	beq		$t0, $s2, a_even		# wether a is even
	# b is even
	beq		$t1, $s2, b_even		# wether b is even
	# a is bigger
	bgt		$a0, $a1, ret_a_bigger	# whether a is bigger than b
	# b is bigger
	bgt		$a1, $a0, ret_b_bigger	# whether b is bigger than a

equal:
	move	$v0, $a0				# return a
	jr		$ra						# jump to $ra

a_even:
	addi	$sp, $sp, -4			# make room for stack push. we must do this before recursive call.
	srl		$a0, $a0, 1				# shift a by 1 bit
	sw		$ra, 0($sp)				# push return address to the stack.
	jal		gcd						# do recursive 
	lw		$ra, 0($sp)				# pop return address from the stack.
	addi	$sp, $sp, 4				# restore the stack
	j		ret						# jump to ret


b_even:
	addi	$sp, $sp, -4			# make room for stack push. we must do this before recursive call.
	srl		$a1, $a1, 1				# shift a by 1 bit
	sw		$ra, 0($sp)				# push return address to the stack.
	jal		gcd						# do recursive
	lw		$ra, 0($sp)				# pop return address from the stack.
	addi	$sp, $sp, 4				# restore the stack
	j		ret						# jump to ret


ab_even:
	addi	$sp, $sp, -4			# make room for stack push. we must do this before recursive call.
	srl		$a0, $a0, 1				# shift a by 1 bit
	srl		$a1, $a1, 1				# shift b by 1 bit
	sw		$ra, 0($sp)				# push return address to the stack.
	jal		gcd						# do recursive
	lw		$ra, 0($sp)				# pop return address from the stack.
	addi	$sp, $sp, 4				# restore the stack
	sll		$v0, $v0, 1				# shift left the return number by 1 bit
	j		ret						# jump to ret

ret_a_bigger:
	addi	$sp, $sp, -4			# make room for stack push. we must do this before recursive call.
	sub		$a0, $a0, $a1			# a = a - b
	sw		$ra, 0($sp)				# push return address to the stack.
	jal		gcd						# do recursive
	lw		$ra, 0($sp)				# pop return address from the stack.
	addi	$sp, $sp, 4				# restore the stack
	j		ret						# jump to ret
	

ret_b_bigger:
	addi	$sp, $sp, -4			# make room for stack push. we must do this before recursive call.
	sub		$a1, $a1, $a0			# b = b - a
	sw		$ra, 0($sp)				# push return address to the stack.
	jal		gcd						# do recursive
	lw		$ra, 0($sp)				# pop return address from the stack.
	addi	$sp, $sp, 4				# restore the stack
	j		ret						# jump to ret


ret:
	jr		$ra						# jump to $ra