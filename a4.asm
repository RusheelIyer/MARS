.data

newline:	.asciiz "\n"
startwert:	.asciiz "Startwert: "
schrittweite:	.asciiz "Schrittweite: "
anzahl:		.asciiz "Anzahl: "
comma:		.asciiz ", "
summe:		.asciiz "Summe: "

.text
.globl main

main:	li $v0, 5
	syscall
	move $s0, $v0
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	li $v0, 5
	syscall
	move $s2, $v0
		
	la $a0, startwert
	li $v0, 4
	syscall
	move $a0, $s0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, schrittweite
	li $v0, 4
	syscall
	move $a0, $s1
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, anzahl
	li $v0, 4
	syscall
	move $a0, $s2
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	
	li $t0, 1
	move $t1, $s0
	move $t2, $s0
loop:	bge $t0, $s2, end
	move $a0, $t1
	li $v0, 1
	syscall
	la $a0, comma
	li $v0, 4
	syscall
	add $t1, $t1, $s1
	add $t2, $t2, $t1
	addi $t0, $t0, 1
	j loop

end:	move $a0, $t1
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	
	la $a0, summe
	li $v0, 4
	syscall
	move $a0, $t2
	li $v0, 1
	syscall