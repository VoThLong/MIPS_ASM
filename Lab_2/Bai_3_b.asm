.data
    larger:  .asciiz "So lon hon: "
    Tong:    .asciiz "Tong: "
    Hieu:    .asciiz "Hieu: "
    Tich:    .asciiz "Tich: "
    Thuong:  .asciiz "Thuong: "
    newline: .asciiz "\n"

.text
.globl main
main:
    # Nhap so thu nhat
    li $v0, 5
    syscall
    move $t0, $v0  # Luu so thu nhat vao $t0

    # Nhap so thu hai
    li $v0, 5
    syscall
    move $t1, $v0  # Luu so thu hai vao $t1

    li $v0, 4
    la $a0, larger
    syscall

    # So sanh 2 so
    slt $t2, $t0, $t1  # Neu $t0 < $t1, $t2 = 1
    beq $t2, $zero, print_t0
    move $a0, $t1
    j print_larger
print_t0:
    move $a0, $t0
print_larger:
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Tinh tong
    add $t3, $t0, $t1
    li $v0, 4
    la $a0, Tong
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Tinh hieu
    sub $t3, $t0, $t1
    li $v0, 4
    la $a0, Hieu
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Tinh tich
    mul $t3, $t0, $t1
    li $v0, 4
    la $a0, Tich
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Tinh va in thuong
    li $v0, 4
    la $a0, Thuong
    syscall
    beq $t1, $zero, zero_div  # Neu $t1 = 0, nhay den zero_div
    div $t0, $t1              # Chia $t0 cho $t1
    mflo $t2                  # Lay phan nguyen vao $t2
    j print_quot
zero_div:
    li $t2, 0                 # Gan thuong = 0 neu chia cho 0
print_quot:
    move $a0, $t2
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Ket thuc
    li $v0, 10
    syscall

.end