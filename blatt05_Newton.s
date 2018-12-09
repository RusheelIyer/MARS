#
# Karlsruher Institut fuer Technologie
# Institut fuer Technische Informatik (ITEC) 
# Vorlesung Rechnerorganisation
# 
# Autor(en):
# Matrikelnummer: 2091489
# Tutoriumsnummer: 8
# Name des Tutors: Daniel Meyer
#


        .data
        # space for the polynomials
                        .align 3
polynomial:             .space 40       # conventions: starting with a0 to a4                   
derivedPoly:            .space 40       # for a0 + a1*x + a2*x^2 + a3*x^3 + a4*x^4
        # the polynomial for which you have to find the null points for the given start values below
testPoly:               .double 2, -0.5, -2.2, 0.0, 0.25

        # algorithm values
maxRounds:              .word 30
epsilon:                .double 0.00001
# - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! -
# write your found solutions for given start values here
x0:                     .double -5.1    # found solution: 
x1:                     .double -0.8    # found solution: 
x2:                     .double 1       # found solution: 
x3:                     .double 3.5     # found solution: 

        # help values
null:                   .double 0
eins:                   .double 1

        # strings 
readFactorsPrompt:      .asciiz "Please insert polynomial factors for polynomial a0 + a1*x + a2*x^2 + a3*x^3 + a4*x^4."
readNextFactor:         .asciiz "\nnext factor: "
newLine:                .asciiz "\n"
startValue:             .asciiz "\nStart newton's method with start value: "
noSolutionFound:        .asciiz "Did not converge. No solution found."
solutionFound:          .asciiz "The found solution is: "
polyPrint:              .asciiz "\nPolynomial factors: "
comma:          .asciiz ", "
 
        .text
        .globl main
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#       MAIN            MAIN            MAIN            MAIN            MAIN            #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
main:           jal alignStackPointer   # align stackpointer to multiple of 8
        # to read in a polynomial uncomment the polynomial lines and comment those with test polynomial
                #la $a0, polynomial
                #jal readFactors
                
        # print the polynomial
                #la $a0, polynomial
                la $a0, testPoly
                jal printPolynomial
                
        # first we need to compute the derived polynomial, since we need it in the algorithm
                #la $a0, polynomial
                la $a0, testPoly
                la $a1, derivedPoly
                jal derive                      # - ! - implement this subroutine               
        # print the derived polynomial to see whether it was computed correctly
                #la $a0, polynomial
                la $a0, derivedPoly
                jal printPolynomial
                                
        # now we can run the newton subroutine with our start values                    
                la $a2, x0
                #la $a0, polynomial
                la $a0, testPoly
                la $a1, derivedPoly
                jal newtonsMethod               # - ! - implement this subroutine
                
                la $a2, x1
                #la $a0, polynomial
                la $a0, testPoly
                la $a1, derivedPoly
                jal newtonsMethod
                
                la $a2, x2
                #la $a0, polynomial
                la $a0, testPoly
                la $a1, derivedPoly
                jal newtonsMethod
                
                la $a2, x3
                #la $a0, polynomial
                la $a0, testPoly
                la $a1, derivedPoly
                jal newtonsMethod
                                
                li $v0, 10
                syscall

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# Subroutine: newtonsMethod                                                             #
#       The subroutine runs newton's method for given polynomial f and start value.     #
#                                                                                       #
# Parameters:                                                                           #
#       $a0 - address of polynomial f                                                   #
#       $a1 - address of derived polynomial f'                                          #
#       $a2 - address of x_0, start value for algorithm                                 #
# Output:                                                                               #
#       $f0 - the solution of the algorithm, null point of given polynomial (hopefully) #
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
newtonsMethod:          # prepare a new stackframe for the subroutine
                subu $sp, $sp, 24
                sw $s0, 20($sp)
                sw $s1, 16($sp)
                sw $s2, 12($sp)
                sw $ra, 8($sp)
                sw $fp, 4($sp)
                addu $fp, $sp, 24

                # store arguments in caller-save registers
                move $s0, $a0           
                move $s1, $a1
                move $s2, $a2

                # possible register use: 
                # s0 = &f, s1 = &f', s2 = &x0
                # f0 = x_n, f2= f(x_n), f4 = f'(x_n), $s3 = n, $s4 = maxRounds
                l.d $f0, ($s2)          # load x_0 in $f0
                # print start value
                la $a0, startValue
                jal printString
                mov.d $f12, $f0
                jal printDouble
                la $a0, newLine
                jal printString
                
# - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! -
# implement newton's method here. if it did not converge, abort with error message, else print out solution
# (see predefined strings and helping methods at the end for easy printing)
# use your implementation of the subroutine evalutePolynomial

        # you may implement the following version of newton's method 
        # while (|f(x_n)| > epsilon) {
        #     x_(n+1) = x_n - f(x_n) / f'(x_n)
        #     n++
        #     if (n >= maxRounds) {
        #       abort, did not converge
        #     }
        # }
        # return x_(n)

        # YOUR CODE HERE

# - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - 
                # restore the old stackframe and return to the calling function
                lw $s0, 20($sp)
                lw $s1, 16($sp)
                lw $s2, 12($sp)
                lw $ra, 8($sp)
                lw $fp, 4($sp)
                addu $sp, $sp, 24
                jr $ra
                
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# Subroutine: evaluatePolynomial                                                        #                                                                       #
#       The subroutine evaluates the polynomial on the given x coordinate.              #
#                                                                                       #
# Parameters:                                                                           #
#       $a0 - start address of polynomial factors                                       #
#       $f0 - value x at which polynomial will be evaluated                             #
# Output:                                                                               #
#       $f12 - the computed value                                                       #
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
evaluatePolynomial: 
                # prepare a new stackframe for the subroutine
                subu $sp, $sp, 48
                s.d $f0, 48($sp)        # to make it easier for newton method
                s.d $f2, 40($sp)        # we store the floating point registers
                s.d $f4, 32($sp)        # to restore it after the evaluation
                s.d $f6, 24($sp)
                s.d $f8, 16($sp)
                sw $ra, 8($sp)
                sw $fp, 4($sp)
                addu $fp, $sp, 48

# - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! -
# implement the evaluation of the polynomial given with address at $a0 at value in $f0
        # for (i = 0; i <= 4; i++) {
        #    f2 += a0[i] * (x^i);       
        # }

        # YOUR CODE HERE
        li $s0, 4
        li $s1, 0 # i = 0
        add $s2, $zero, $a0
loop:	bgt $s1, $s0, restore # jump to label if i > 4
	l.d $f10, eins # f10 = x^i
	li $t2, 1
exp:	bgt $t2, $s1, incr # loop till >i
	mul.d $f10, $f10, $f0
	addi $t2, $t2, 1
	b exp
incr:	mul $t0, $s1, 8
	add $a0, $t0, $s2 # a0 = a0[i]
	l.d $f14, ($a0)
	mul.d $f12, $f14, $f10
	addi $s1, $s1, 1
	b loop
restore:

                
# - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ -                 
                # restore the old stackframe and return to the calling function
                l.d $f0, 48($sp)        
                l.d $f2, 40($sp)        # note that this restores the floating point registers
                l.d $f4, 32($sp)        # f0 - f9
                l.d $f6, 24($sp)        # return value has to be stored in f12
                l.d $f8, 16($sp)
                lw $ra, 8($sp)
                lw $fp, 4($sp)
                addu $sp, $sp, 48
                jr $ra            

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# Subroutine: derive                                                                    #                                                                       #
#       The subroutine derives the polynomial of degree 4 at $a0.                       #
#       Stores the derived polynomial at $a1.                                           #
#                                                                                       #
# Parameters:                                                                           #
#       $a0 - address of polynomial f                                                   #
#       $a1 - address where the derived polynomial f' will be stored                    #
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
derive: 
                # prepare a new stackframe for the subroutine
                subu $sp, $sp, 8
                sw $ra, 8($sp)
                sw $fp, 4($sp)
                addu $fp, $sp, 8
# - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! - ! -
# implement the derive subroutine here
# hint: you can use mtc1.d $t0, $f0 to move int at $t0 to double $f0/1 
# and then cvt.d.w $f0, $f0 to convert it to double
        # for (i = 1; i <= 4; i++) {
        #       b[i - 1] = (i) * a[i]
        # }


        # YOUR CODE HERE
        
        li $t0, 1 # i = 1
        li $t1, 0 # i - 1
        li $s0, 4
        add $s1, $zero, $a0 #s1 = start address of polynomials
        add $s2, $zero, $a1 #s2 = start address of derived polynomials
        
loopD:	bgt $t0, $s0, restoreD
	mul $t2, $t0, 8
	mul $t3, $t1, 8
	add $a0, $t2, $s1 # a0 = a[i]
	add $a1, $t3, $s2 # a1 = b[i-1]
	mtc1.d $t0, $f0 #make i a double
	cvt.d.w $f0, $f0
	l.d $f2, ($a0)
	mul.d $f2, $f2, $f0
	s.d $f2, ($a1)
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	b loopD

restoreD:

# - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - ^ - 
 
                # restore the old stackframe and return to the calling function
                lw $ra, 8($sp)
                lw $fp, 4($sp)
                addu $sp, $sp, 8
                jr $ra
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# Subroutine: readFactors                                                               #
#       The subroutine asks for the polynomial factors and stores them at given address.#
#                                                                                       #
# Parameters:                                                                           #
#       $a0 - start address of where to store the factors                               #
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
readFactors: 
                # prepare a new stackframe for the subroutine
                subu $sp, $sp, 8
                sw $ra, 8($sp)
                sw $fp, 4($sp)
                addu $fp, $sp, 8
                
                move $s0, $a0
                la $a0, readFactorsPrompt
                jal printString
                        
        # for (i = 0; i <= 4; i++) {
        #    a[i] =  readDouble 
        # }
                li $s1, 4               # 4
                li $s2, 0               # i = 0
        loopR:  bgt $s2, $s1, outR      # i > 4 ? out : go on
                
                la $a0, readNextFactor
                jal printString
                
                mul $t3, $s2, 8         # i * 8 since we handle double
                add $a0, $t3, $s0       # &a[i]
                jal readAndStoreDouble
                
                addi $s2, $s2, 1        # i++
                j loopR
        outR:           

                # restore the old stackframe and return to the calling function
                lw $ra, 8($sp)
                lw $fp, 4($sp)
                addu $sp, $sp, 8
                jr $ra
                
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# Subroutine: printPolynomial                                                           #                                                                       #
#       The subroutine prints the factors of the polynomial given in $a0.               #
#                                                                                       #
# Parameters:                                                                           #
#       $a0 - start address of polynomial factors                                       #
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
printPolynomial:
                # prepare a new stackframe for the subroutine
                subu $sp, $sp, 20
                sw $s0, 20($sp)
                sw $s1, 16($sp)
                sw $s2, 12($sp)
                sw $ra, 8($sp)
                sw $fp, 4($sp)
                addu $fp, $sp, 20
                
                move $s0, $a0           # save poly start address
                
                la $a0, polyPrint       # print polynomial string
                jal printString
                
                li $s1, 4               # 4
                li $s2, 0               # i = 0
        ploop:  
                mul $t3, $s2, 8         # i * 8 since we handle double
                add $t3, $t3, $s0       # &a[i]
                l.d $f12, 0($t3)                # a[i]
                jal printDouble
                
                beq $s2, $s1, pout      # i = 4 ? out : go on   to not print comma
                la $a0, comma           # print comma
                jal printString
                
                addi $s2, $s2, 1        # i++
                ble $s2, $s1, ploop     # i <= 4 ? loop : go on
                
        pout:   # restore the old stackframe and return to the calling function
                lw $s0, 20($sp)
                lw $s1, 16($sp)
                lw $s2, 12($sp)
                lw $ra, 8($sp)
                lw $fp, 4($sp)
                addu $sp, $sp, 20
                jr $ra

# - - some more little helping subroutines  - - - - - - - - - - - - - - - - - - - - - - #
# prints string with start address in $a0
printString:    li $v0, 4
                syscall
                jr $ra
                
# prints double at $f12
printDouble:    li $v0, 3
                syscall
                jr $ra

# reads double and stores it at $a0     
readAndStoreDouble:
                li $v0, 7
                syscall
                s.d $f0, 0($a0)
                jr $ra

# aligns stack pointer to multiple of 8
alignStackPointer:
                li $t0, 8
                div $sp, $t0
                mfhi $t0
                sub $sp, $sp, $t0
                jr $ra
