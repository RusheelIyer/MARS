.data

#strings
startwert:	.asciiz "Startwert: "
newline:	.asciiz "\n"
schrittweite:	.asciiz "Schrittweite: "
anzahl:		.asciiz "Anzahl: "
summe:		.asciiz "Summe: "
comma:		.asciiz ", "

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
	
	la $a0, startwert #print startwert with text and newline
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	
	la $a0, schrittweite #print Schrittweite with text and newline
	syscall
	move $a0, $t1
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	
	la $a0, startwert #print Anzahl with text and newline
	syscall
	move $a0, $t2
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	
loop:	beqz $t2, end
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, comma
	li $v0, 4
	syscall
	add $s0, $s0, $t0
	add $t0, $t0, $t1
	subi $t2, $t2, 1
	b loop
	
end:	la $a0, newline
	li $v0, 4
	syscall
	la $a0, summe
	syscall
	move $a0, $s0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
