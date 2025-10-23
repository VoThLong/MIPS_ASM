.data
    type_num:   .asciiz "Chu so"
    type_lower: .asciiz "Chu thuong"
    type_upper: .asciiz "Chu hoa"
    type_other: .asciiz "invalid type"
    newline:    .asciiz "\n"  # Sửa typo "mewline" thành "newline"

.text
.globl main
main:
    # Nhap ky tu
    li $v0, 12
    syscall
    add $t0, $v0, $zero  # Luu ky tu vao t0

    # In ki tu truoc (tru 1 ascii)
    li $v0, 11
    add $a0, $t0, $zero
    addi $a0, $a0, -1
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # In ki tu sau (cong 1 ascii)
    li $v0, 11
    add $a0, $t0, $zero
    addi $a0, $a0, 1
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Kiem tra loai ky tu (dung $t0 goc, khong cong them)
    li $v0, 4
    blt $t0, '0', other_type  # Neu ky tu < '0'
    bgt $t0, 'z', other_type  # Neu ky tu > 'z'
    blt $t0, 'A', check_num   # Neu ky tu <= 'A'
    bgt $t0, 'Z', check_lower # Neu ky tu > 'Z'

check_upper:
    la $a0, type_upper
    j print_type

check_lower:
    blt $t0, 'a', other_type  # Neu ky tu < 'a'
    bgt $t0, 'z', other_type  # Neu ky tu > 'z'
    la $a0, type_lower
    j print_type              # Xoa syscall o day de tranh in 2 lan

check_num:
    blt $t0, '0', other_type  # Neu ky tu < '0'
    bgt $t0, '9', other_type  # Neu ky tu > '9'
    la $a0, type_num
    j print_type

other_type:
    la $a0, type_other
    j print_type

print_type:
    li $v0, 4
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Ket thuc
    li $v0, 10
    syscall

.end