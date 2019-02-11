.text

.globl main

main:	addi $v0, $zero, 5
	syscall
	add $s0, $v0, $zero
	
	sub $a0, $zero, $s0
	addi $v0, $zero, 1
	syscall
	
	#abs $a0, $s0
	bgez $s0, label
	sub $a0, $zero, $s0
	j label2
label:	add $a0, $zero, $s0
label2:	addi $v0, $zero, 1
	syscall
	
	addi $t0, $zero, 3
	mul $a0, $s0, $t0
	addi $v0, $zero, 1
	syscall
	
	addi $v0, $zero, 10
	syscall