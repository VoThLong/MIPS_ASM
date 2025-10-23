.data
array1: .word   5, 6, 7, 8, 1, 2, 3, 9, 10, 4
size1:  .word   10

array2: .byte   1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
size2:  .word   16

array3: .space  32     # Cần 32 bytes cho 8 phần tử word
size3:  .word   8

# SỬA LỖI 1: Tăng kích thước array3 để đủ chứa 8 phần tử word (8*4 = 32 bytes)
array3: .space  32     # Cần 32 bytes cho 8 phần tử word
size3:  .word   8

.text
.globl main
main:

la $s0, array1      # Load address of array1
la $s1, array2      # Load address of array2
la $s2, array3      # Load address of array3
add $t0, $zero, $zero
add $t1, $zero, $zero 
add $t2, $zero, $zero 
lw $t4, size1
lw $t5, size2
lw $t6, size3


loop1:
    beq $t0, $t4, end_loop1   # Check if we have processed all elements of array1

    lw $t3, 0($s0)               # Load element from array1
    move $a0, $t3               # Move element to $a0 for printing
    li $v0, 1                   # Print integer syscall
    syscall
    
    li $a0, 32
    li $v0, 11
    syscall

    addi $s0, $s0, 4            # Move to the next element in array1
    addi $t0, $t0, 1            # Increment counter
    j loop1                      # Repeat the loop
end_loop1:

li $a0, 10      # Nạp mã ASCII của '\n' (Line Feed) vào $a0
li $v0, 11      # syscall code for print_character
syscall

loop2:
    beq $t1, $t5, end_loop2   # Check if we have processed all elements of array2

    lb $t3, 0($s1)               # Load element from array2
    move $a0, $t3               # Move element to $a0 for printing
    li $v0, 1                   # Print integer syscall
    syscall
    
    li $a0, 32
    li $v0, 11
    syscall

    addi $s1, $s1, 1            # Move to the next element in array2
    addi $t1, $t1, 1            # Increment counter
    j loop2                      # Repeat the loop
end_loop2:

li $a0, 10      # Nạp mã ASCII của '\n' (Line Feed) vào $a0
li $v0, 11      # syscall code for print_character
syscall

la $s0, array1      # Load address of array1
la $s1, array2 + 15      # Load address of array2 (phần tử cuối)
la $s2, array3      # Load address of array3

loop3:
    beq $t2, $t6, end_loop3   # Check if we have processed all elements of array3

    lw $t3, 0($s0)             # Load element from array1
    lb $t7, 0($s1)             # Load element from array2

    add $t3, $t3, $t7           # Add elements
    sw $t3, 0($s2)              # Store result in array3

    addi $s0, $s0, 4            # Move to the next element in array1    
    # SỬA LỖI 2: MIPS không có lệnh subi, dùng addi với số âm
    addi $s1, $s1, -1           # Move to the previous element in array2
    # SỬA LỖI 3: array3 là mảng word nên tăng 4 bytes, không phải 8
    addi $s2, $s2, 4            # Move to the next element in array3 (word = 4 bytes)
    addi $t2, $t2, 1            # Increment counter
    j loop3                     # Repeat the loop
end_loop3:

li $a0, 10
li $v0, 11
syscall

# SỬA LỖI 4: Reset lại pointer và counter trước khi in array3
la $s2, array3      # Reset pointer về đầu array3
li $t2, 0           # Reset counter về 0 (dùng li, không phải lw)

loop4:
    beq $t2, $t6, end_loop4

    lw $t3, 0($s2)              # Load element from array3
    move $a0, $t3               # Move element to $a0 for printing
    li $v0, 1                   # Print integer syscall
    syscall

    li $a0, 32
    li $v0, 11
    syscall

    # SỬA LỖI 5: array3 là word nên tăng 4 bytes
    addi $s2, $s2, 4            # Move to the next element in array3 (word = 4 bytes)
    addi $t2, $t2, 1            # Increment counter
    j loop4                     # Repeat the loop
end_loop4:

# Kết thúc chương trình
li $v0, 10
syscall
