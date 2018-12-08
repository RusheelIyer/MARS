.text
.globl main

main:	li $v0, 5 #read x into $s0
	syscall
	move $s0, $v0
	
	li $v0, 5 #read exponent into $s1
	syscall
	move $s1, $v0
	
	li $t0, 1
	li $t1, 1
exp:	bgt $t1, $s1, end
	mul $t0, $t0, $s0
	addi $t1, $t1, 1
	b exp
end:	move $a0, $t0
	li $v0, 1
	syscall
	li $v0, 10
	syscall