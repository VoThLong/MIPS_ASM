.data
array: .space 400
prompt_n:     .asciiz "Nhap so phan tu n (toi da 100): "
prompt_element: .asciiz "Nhap phan tu thu "
prompt_index: .asciiz "\n(3) Nhap chi so can tim: "
result_min:   .asciiz "\n(1) Gia tri nho nhat (min): "
result_max:   .asciiz "\n(1) Gia tri lon nhat (max): "
result_sum:   .asciiz "\n(2) Tong cac phan tu: "
result_index: .asciiz "Gia tri tai chi so do: "
colon:        .asciiz ": "
newline:      .asciiz "\n"
.text
.globl main
main:

    # Nhập n
    li $v0, 4
    la $a0, prompt_n
    syscall

    addi $v0, $zero, 5          # syscall đọc số nguyên
    syscall
    add $s0, $v0, $zero         # $s0 = n

    la $s1, array        # $s1 = &array[0]
    add $s2, $s1, $zero      # $s2 = $s1
    add $s3, $zero, $zero     # $s3 = i = 0

input_loop:
    beq $s3, $s0, end_input_loop   # if (i == n) thì kết thúc nhập

    li $v0, 4
    la $a0, prompt_element
    syscall

    li $v0, 1
    move $a0, $s3           # In i
    syscall

    li $v0, 4
    la $a0, colon
    syscall

    li $v0, 5
    syscall
    sw $v0, 0($s2)          # array[i] = value

    addi $s2, $s2, 4        # Di chuyển con trỏ đến word tiếp theo
    addi $s3, $s3, 1        # i++
    j input_loop

end_input_loop:

#      --- PHAN 2: TIM MAX, MIN SUM ---

# RESET CON TRO
    add $s2, $s1, $zero     # $s2 = &array[0]
    add $s3, $zero, $zero   # i = 0

    # khoi tao gia tri
    lw $t0, 0($s2)          # max = array[0]
    lw $t1, 0($s2)          # min = array[0]
    add $t2, $zero, $zero   # sum = 0

loop_max_min_sum:
    beq $s3, $s0, end_loop_max_min_sum   # if (i == n) thi ket thuc

    lw $t3, 0($s2)          # t3 = array[i]

    add $t2, $t2, $t3       # sum = sum + array[i]
    blt $t3, $t1, new_min   # if (array[i] < min) jump to new_min
    j check_max             # Bo qua new_min
new_min:
    add $t1, $t3, $zero     # min = array[i]
check_max:
    bgt $t3, $t0, new_max   # if (array[i] > max) jump to new_max
    j continue_calc         # Bo qua new_max
new_max:
    add $t0, $t3, $zero     # max = array[i]
continue_calc:
    addi $s2, $s2, 4        # Di chuyển con trỏ đến word tiếp theo
    addi $s3, $s3, 1        # i++
    j loop_max_min_sum

end_loop_max_min_sum:

    # In ket qua
    li $v0, 4
    la $a0, result_min
    syscall
    move $a0, $t1           # min
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, result_max
    syscall
    move $a0, $t0           # max
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, result_sum
    syscall
    move $a0, $t2           # sum
    li $v0, 1
    syscall

# ---NHAP CHI SO - XUAT PHAN TU ---

    li $v0, 4
    la $a0, prompt_index
    syscall

    li $v0, 5
    syscall
    add $t4, $v0, $zero     # t4 = index

    la $s2, array           # Reset con tro ve dau mang
    sll $t5, $t4, 2         # t5 = index * 4
    add $s2, $s2, $t5       # Tinh dia chi array[index]
    lw $t6, 0($s2)          # Load gia tri array[index]

    li $v0, 4
    la $a0, result_index
    syscall
    move $a0, $t6           # Gia tri tai chi so do
    li $v0, 1
    syscall

    li $v0, 10              # Ket thuc chuong trinh
    syscall
