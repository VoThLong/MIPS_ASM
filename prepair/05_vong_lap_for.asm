# Chương trình mẫu: Vòng lặp FOR
# In các số từ 1 đến 10

.data
    msg1: .asciiz "Vong lap FOR: In tu 1 den 10\n"
    space: .asciiz " "

.text
.globl main

main:
    # In thông báo
    li $v0, 4
    la $a0, msg1
    syscall
    
    # Khởi tạo: i = 1
    li $t0, 1           # $t0 = i
    li $t1, 10          # $t1 = n (giới hạn)
    
for_loop:
    # Điều kiện: i <= 10
    bgt $t0, $t1, end_loop
    
    # Thân vòng lặp: In i
    li $v0, 1
    move $a0, $t0
    syscall
    
    li $v0, 4
    la $a0, space
    syscall
    
    # Tăng i: i++
    addi $t0, $t0, 1
    
    # Quay lại vòng lặp
    j for_loop
    
end_loop:
    # Kết thúc
    li $v0, 10
    syscall
