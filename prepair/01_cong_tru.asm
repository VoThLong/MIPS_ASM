# Chương trình mẫu: Phép cộng và trừ
# Tính toán: (a + b) - c

.data
    a: .word 10
    b: .word 20
    c: .word 5
    result_add: .word 0
    result_sub: .word 0
    msg1: .asciiz "Ket qua cong: "
    msg2: .asciiz "\nKet qua tru: "
    newline: .asciiz "\n"

.text
.globl main

main:
    # Load các giá trị
    lw $t0, a           # $t0 = a
    lw $t1, b           # $t1 = b
    lw $t2, c           # $t2 = c
    
    # Phép cộng: a + b
    add $t3, $t0, $t1   # $t3 = a + b
    sw $t3, result_add  # Lưu kết quả
    
    # In kết quả cộng
    li $v0, 4
    la $a0, msg1
    syscall
    
    li $v0, 1
    move $a0, $t3
    syscall
    
    # Phép trừ: (a + b) - c
    sub $t4, $t3, $t2   # $t4 = (a + b) - c
    sw $t4, result_sub  # Lưu kết quả
    
    # In kết quả trừ
    li $v0, 4
    la $a0, msg2
    syscall
    
    li $v0, 1
    move $a0, $t4
    syscall
    
    # Kết thúc chương trình
    li $v0, 10
    syscall
