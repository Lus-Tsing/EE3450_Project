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
    move	$a0, $s0	# move a into gcd function
	move	$a1, $s1	# move b into gcd function
	jal		gcd			# jump to gcd and save position to $ra
	move	$s0, $v0	# move the answer to $s0, then print it
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
	# a_even, b_even are variables indicating 
	# whether a and b are even or not
	# check gcdC.c for more details

	# a_even = (a & 1) == 0;
	# LSB of even num is 0, odd is 1
	# so andi with 1 can check LSB
	andi 	$t0, $a0, 1				# do (a & 1)
	xori	$t0, $t0, 1				# use xor to check even or not
									# if even save 1, else 0
									# save a_even to $t0
	
	#check_b_even = (b & 1) == 0;
	andi 	$t1, $a1, 1				# do (b & 1)
	xori	$t1, $t1, 1				# save check_b_even to $t1

	addi 	$s2, $0, 1				# $s2 is true (1)

	# a and b are even
	and		$t2, $t0, $t1			# both even -> $t2 = 1
									# else -> $t2 = 0
	beq		$s2, $t2, ab_even		# whether a, b are even

	beq		$t0, $s2, a_even		# whether a is even
	beq		$t1, $s2, b_even		# whether b is even
	beq		$a0, $a1, equal			# whether a = b
	bgt		$a0, $a1, ret_a_bigger	# whether a is bigger than b
	# b is bigger
ret_b_bigger:
	addi	$sp, $sp, -4			# make room for stack push. we must do this before recursive call.
	sub		$a1, $a1, $a0			# b = b - a
	sw		$ra, 0($sp)				# push return address to the stack.
	jal		gcd						# do recursive
	lw		$ra, 0($sp)				# pop return address from the stack.
	addi	$sp, $sp, 4				# restore the stack
ret:
	jr		$ra						# jump to $ra

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
	j		ret						# jump to label ret


b_even:
	addi	$sp, $sp, -4			# make room for stack push. we must do this before recursive call.
	srl		$a1, $a1, 1				# shift a by 1 bit
	sw		$ra, 0($sp)				# push return address to the stack.
	jal		gcd						# do recursive
	lw		$ra, 0($sp)				# pop return address from the stack.
	addi	$sp, $sp, 4				# restore the stack
	j		ret						# jump to label ret


ab_even:
	addi	$sp, $sp, -4			# make room for stack push. we must do this before recursive call.
	srl		$a0, $a0, 1				# shift a by 1 bit
	srl		$a1, $a1, 1				# shift b by 1 bit
	sw		$ra, 0($sp)				# push return address to the stack.
	jal		gcd						# do recursive
	lw		$ra, 0($sp)				# pop return address from the stack.
	addi	$sp, $sp, 4				# restore the stack
	sll		$v0, $v0, 1				# this case indicate a common divisor 2
									# shift left the return number by 1 bit to implement multipling 2
	j		ret						# jump to label ret

ret_a_bigger:
	addi	$sp, $sp, -4			# make room for stack push. we must do this before recursive call.
	sub		$a0, $a0, $a1			# a = a - b
	sw		$ra, 0($sp)				# push return address to the stack.
	jal		gcd						# do recursive
	lw		$ra, 0($sp)				# pop return address from the stack.
	addi	$sp, $sp, 4				# restore the stack
	j		ret						# jump to label ret
	
