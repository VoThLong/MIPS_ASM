# Chương trình mẫu: Tìm kiếm phần tử trong mảng (Linear Search)

.data
    array: .word 10, 23, 45, 12, 67, 34, 89, 56
    n: .word 8
    key: .word 67
    msg1: .asciiz "Mang: "
    msg2: .asciiz "\nTim kiem phan tu: "
    msg3: .asciiz "\nTim thay tai vi tri: "
    msg4: .asciiz "\nKhong tim thay!"
    space: .asciiz " "

.text
.globl main

main:
    # In mảng
    li $v0, 4
    la $a0, msg1
    syscall
    
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
    # In phần tử cần tìm
    li $v0, 4
    la $a0, msg2
    syscall
    
    lw $t3, key
    li $v0, 1
    move $a0, $t3
    syscall
    
    # Tìm kiếm
    la $t0, array       # $t0 = địa chỉ mảng
    lw $t1, n           # $t1 = n
    lw $t2, key         # $t2 = key
    li $t3, 0           # $t3 = i
    
search_loop:
    bge $t3, $t1, not_found
    
    lw $t4, 0($t0)      # $t4 = array[i]
    
    # So sánh với key
    beq $t4, $t2, found
    
    addi $t0, $t0, 4
    addi $t3, $t3, 1
    
    j search_loop
    
found:
    # Tìm thấy
    li $v0, 4
    la $a0, msg3
    syscall
    
    li $v0, 1
    move $a0, $t3
    syscall
    
    j end
    
not_found:
    # Không tìm thấy
    li $v0, 4
    la $a0, msg4
    syscall
    
end:
    # Kết thúc
    li $v0, 10
    syscall
