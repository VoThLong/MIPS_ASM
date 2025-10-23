# Chương trình mẫu: Tìm phần tử lớn nhất trong mảng

.data
    array: .word 5, 12, 8, 20, 3, 15, 7
    n: .word 7
    msg1: .asciiz "Mang: "
    msg2: .asciiz "\nPhan tu lon nhat: "
    space: .asciiz " "

.text
.globl main

main:
    # In mảng
    li $v0, 4
    la $a0, msg1
    syscall
    
    la $t0, array       # $t0 = địa chỉ mảng
    lw $t1, n           # $t1 = n
    li $t2, 0           # $t2 = i
    
print_loop:
    bge $t2, $t1, end_print
    
    lw $t3, 0($t0)
    
    li $v0, 1
    move $a0, $t3
    syscall
    
    li $v0, 4
    la $a0, space
    syscall
    
    addi $t0, $t0, 4
    addi $t2, $t2, 1
    
    j print_loop
    
end_print:
    # Tìm max
    la $t0, array       # Reset địa chỉ
    lw $t3, 0($t0)      # $t3 = max (khởi tạo = phần tử đầu)
    li $t2, 1           # $t2 = i (bắt đầu từ 1)
    addi $t0, $t0, 4    # Chuyển sang phần tử thứ 2
    
find_max:
    bge $t2, $t1, end_find
    
    lw $t4, 0($t0)      # $t4 = array[i]
    
    # So sánh với max
    ble $t4, $t3, skip
    move $t3, $t4       # Cập nhật max
    
skip:
    addi $t0, $t0, 4
    addi $t2, $t2, 1
    
    j find_max
    
end_find:
    # In kết quả
    li $v0, 4
    la $a0, msg2
    syscall
    
    li $v0, 1
    move $a0, $t3
    syscall
    
    # Kết thúc
    li $v0, 10
    syscall
