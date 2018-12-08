.text
.globl main
main:	addi $v0, $zero, 5
	syscall
	add $s0, $zero, $v0
	
	sub $a0, $zero, $s0
	addi $v0, $zero, 1
	syscall
	
	abs $a0, $a0
	li $v0, 1
	syscall
	
	li $t0, 3
	mul $a0, $s0, $t0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall