    .data
prompt1: .asciiz "Nhap gia tri cho var1: "
prompt2: .asciiz "Nhap gia tri cho var2: "
msg_greater: .asciiz "So lon hon la: "
msg_equal: .asciiz "Hai so bang nhau."
var1: .word 0
var2: .word 0

    .text
main:
    # Nhac va doc gia tri cho var1
    li $v0, 4           # syscall de in chuoi
    la $a0, prompt1     # nap dia chi cua prompt1 vao $a0
    syscall             # in loi nhac

    li $v0, 5           # syscall de doc so nguyen
    syscall             # doc so nguyen, ket qua luu trong $v0

    sw $v0, var1        # luu so nguyen vao var1

    # Nhac va doc gia tri cho var2
    li $v0, 4           # syscall de in chuoi
    la $a0, prompt2     # nap dia chi cua prompt2 vao $a0
    syscall             # in loi nhac

    li $v0, 5           # syscall de doc so nguyen
    syscall             # doc so nguyen, ket qua luu trong $v0
    
    sw $v0, var2        # luu so nguyen vao var2

    # So sanh hai so
    lw $t0, var1        # nap var1 vao $t0
    lw $t1, var2        # nap var2 vao $t1

    bgt $t0, $t1, print_var1 # neu var1 > var2, nhay den print_var1
    beq $t0, $t1, print_equal # neu var1 == var2, nhay den print_equal

    # Truong hop var2 > var1
    li $v0, 4
    la $a0, msg_greater
    syscall
    li $v0, 1
    move $a0, $t1       # in var2
    syscall
    j exit

print_var1:
    li $v0, 4
    la $a0, msg_greater
    syscall
    li $v0, 1
    move $a0, $t0       # in var1
    syscall
    j exit

print_equal:
    li $v0, 4
    la $a0, msg_equal
    syscall

exit:
    # Ket thuc chuong trinh
    li $v0, 10
    syscall