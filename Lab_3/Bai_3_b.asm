.data
A:  .space 400        # Cấp phát bộ nhớ cho 100 số nguyên (100 * 4 bytes)
prompt_n:   .asciiz "Nhap so phan tu n (toi da 100): "
prompt_i:   .asciiz "Nhap chi so i: "
prompt_j:   .asciiz "Nhap gia tri j: "
.text
.globl main
main:

    li $v0, 4
    la $a0, prompt_n
    syscall

    li $v0, 5
    syscall
    add $t0, $v0, $zero     # $t0 = n

    la $s3, A

    add $t1, $zero, $zero   # $t0 = k = 0

# Nhập mảng A
input_loop:
    beq $t1, $t0, end_input_loop

    li $v0, 5
    syscall
    sw $v0, 0($s3)

    addi $s3, $s3, 4
    addi $t1, $t1, 1
    j input_loop

end_input_loop:

la $s3, A        # Reset con trỏ mảng A

li $v0, 4
la $a0, prompt_i
syscall

li $v0, 5
syscall
add $s0, $v0, $zero     # $s0 = i

li $v0, 4
la $a0, prompt_j
syscall

li $v0, 5
syscall
add $s1, $v0, $zero     # $s1 = j

sll $t2, $s0, 2         # $t2 = i * 4
add $s3, $s3, $t2       # $s3 = &
    
if:
    bge $s1, $s0, else

    sw $s0, 0($s3)
    j end_if

else:

    sw $s1, 0($s3)
    j end_if

end_if:

li $v0 , 1
lw $a0, 0($s3)
syscall

li $v0, 10
syscall