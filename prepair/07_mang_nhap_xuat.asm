# Chương trình mẫu: Nhập và xuất mảng
# Nhập n phần tử, sau đó in ra

.data
    array: .space 40        # Mảng tối đa 10 phần tử (10 * 4 bytes)
    n: .word 0
    msg1: .asciiz "Nhap so phan tu (max 10): "
    msg2: .asciiz "Nhap phan tu thu "
    msg3: .asciiz ": "
    msg4: .asciiz "\nMang vua nhap: "
    space: .asciiz " "

.text
.globl main

main:
    # Nhập số phần tử
    li $v0, 4
    la $a0, msg1
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0       # $t0 = n
    sw $t0, n
    
    # Nhập các phần tử
    la $t1, array       # $t1 = địa chỉ mảng
    li $t2, 0           # $t2 = i (index)
    
input_loop:
    bge $t2, $t0, end_input
    
    # In thông báo
    li $v0, 4
    la $a0, msg2
    syscall
    
    # In index (i+1)
    li $v0, 1
    addi $a0, $t2, 1
    syscall
    
    li $v0, 4
    la $a0, msg3
    syscall
    
    # Nhập giá trị
    li $v0, 5
    syscall
    
    # Lưu vào mảng
    sw $v0, 0($t1)
    
    # Tăng địa chỉ và index
    addi $t1, $t1, 4
    addi $t2, $t2, 1
    
    j input_loop
    
end_input:
    # In mảng
    li $v0, 4
    la $a0, msg4
    syscall
    
    la $t1, array       # Reset địa chỉ mảng
    li $t2, 0           # Reset index
    
output_loop:
    bge $t2, $t0, end_output
    
    # Load và in phần tử
    lw $t3, 0($t1)
    
    li $v0, 1
    move $a0, $t3
    syscall
    
    li $v0, 4
    la $a0, space
    syscall
    
    # Tăng địa chỉ và index
    addi $t1, $t1, 4
    addi $t2, $t2, 1
    
    j output_loop
    
end_output:
    # Kết thúc
    li $v0, 10
    syscall
