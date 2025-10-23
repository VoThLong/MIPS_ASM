# Chương trình mẫu: Vòng lặp WHILE
# Tính tổng các số từ 1 đến n

.data
    n: .word 10
    msg1: .asciiz "Tinh tong tu 1 den "
    msg2: .asciiz "\nKet qua: "

.text
.globl main

main:
    # Load n
    lw $t1, n           # $t1 = n
    
    # In thông báo
    li $v0, 4
    la $a0, msg1
    syscall
    
    li $v0, 1
    move $a0, $t1
    syscall
    
    # Khởi tạo
    li $t0, 1           # $t0 = i
    li $t2, 0           # $t2 = sum
    
while_loop:
    # Điều kiện: i <= n
    bgt $t0, $t1, end_while
    
    # Thân vòng lặp: sum += i
    add $t2, $t2, $t0
    
    # Tăng i
    addi $t0, $t0, 1
    
    # Quay lại vòng lặp
    j while_loop
    
end_while:
    # In kết quả
    li $v0, 4
    la $a0, msg2
    syscall
    
    li $v0, 1
    move $a0, $t2
    syscall
    
    # Kết thúc
    li $v0, 10
    syscall
