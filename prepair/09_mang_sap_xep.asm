# Chương trình mẫu: Sắp xếp mảng tăng dần (Bubble Sort)

.data
    array: .word 64, 34, 25, 12, 22, 11, 90
    n: .word 7
    msg1: .asciiz "Mang truoc khi sap xep: "
    msg2: .asciiz "\nMang sau khi sap xep: "
    space: .asciiz " "

.text
.globl main

main:
    # In mảng ban đầu
    li $v0, 4
    la $a0, msg1
    syscall
    
    jal print_array
    
    # Sắp xếp mảng
    jal bubble_sort
    
    # In mảng sau khi sắp xếp
    li $v0, 4
    la $a0, msg2
    syscall
    
    jal print_array
    
    # Kết thúc
    li $v0, 10
    syscall

# Hàm bubble_sort
bubble_sort:
    lw $t0, n           # $t0 = n
    li $t1, 0           # $t1 = i
    
outer_loop:
    bge $t1, $t0, end_outer
    
    li $t2, 0           # $t2 = j
    sub $t3, $t0, $t1   # $t3 = n - i
    addi $t3, $t3, -1   # $t3 = n - i - 1
    
inner_loop:
    bge $t2, $t3, end_inner
    
    # Tính địa chỉ array[j]
    la $t4, array
    sll $t5, $t2, 2     # $t5 = j * 4
    add $t4, $t4, $t5   # $t4 = &array[j]
    
    lw $t6, 0($t4)      # $t6 = array[j]
    lw $t7, 4($t4)      # $t7 = array[j+1]
    
    # So sánh và swap nếu cần
    ble $t6, $t7, no_swap
    
    # Swap
    sw $t7, 0($t4)
    sw $t6, 4($t4)
    
no_swap:
    addi $t2, $t2, 1
    j inner_loop
    
end_inner:
    addi $t1, $t1, 1
    j outer_loop
    
end_outer:
    jr $ra

# Hàm print_array
print_array:
    la $t0, array
    lw $t1, n
    li $t2, 0
    
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
    jr $ra
