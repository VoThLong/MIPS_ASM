.data
array .space 400
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

    li $v0, 5
    syscall
    add $s0, $v0, $zero         # $s0 = n

    la $s1, array        # $s1 = &array[0]
    add $s2, $s1, $zero      # $s2 = $s1
    add $s3, $zero, $zero     # $s3 = i = 0

input_loop:
    bqe 