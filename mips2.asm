 .text
.globl main

main:	li $v0, 5 #read a
	syscall
	move $t0, $v0
	
	li $v0, 5 #read b
	syscall
	move $t1, $v0
	
	li $v0, 5 #read c
	syscall
	move $t2, $v0
	
loop:	beqz $t2, end
	move $a0, $t0
	li $v0, 1
	syscall
	add $s0, $s0, $t0
	add $t0, $t0, $t1
	subi $t2, $t2, 1
	b loop
	
end:	move $a0, $s0
	li $v0, 1
	syscall
	li $v0, 10
	syscall