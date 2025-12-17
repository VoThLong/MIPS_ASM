.data
arr_space: .space 40
.text
.globl main
main:
    addi $s1, $zero, 10
    add $s2, $zero, $zero
    add $s3, $zero, $zero
    add $s4, $zero, $zero
loop1:
    beq $s2, $s1, reset_$s2
    la $s0, arr_space
    sll $s3, $s2, 2
    add $s0, $s0, $s3
    li $v0, 5
    syscall
    add $s4, $zero, $v0
        sw $s4, 0($s0)
        addi $s2, $s2, 1
    j loop1
    
reset_$s2: add $s2, $zero, $zero

loop2:
    beq $s2, $s1, exit
    la $s0, arr_space
    sll $s3, $s2, 2
    add $s0, $s0, $s3
    lw $t1, 0($s0)
    addi $s2, $s2, 1

    add $a0, $zero, $t1
    li $v0, 1
    syscall
    j loop2
exit: