# Chương trình mẫu: Cấu trúc điều kiện IF-ELSE
# Kiểm tra số chẵn/lẻ

.data
    number: .word 17
    msg1: .asciiz "Kiem tra so: "
    msg_even: .asciiz "\nSo chan"
    msg_odd: .asciiz "\nSo le"

.text
.globl main

main:
    # Load số cần kiểm tra
    lw $t0, number
    
    # In số
    li $v0, 4
    la $a0, msg1
    syscall
    
    li $v0, 1
    move $a0, $t0
    syscall
    
    # Kiểm tra chẵn lẻ: n % 2
    li $t1, 2
    div $t0, $t1
    mfhi $t2            # $t2 = số dư
    
    # IF-ELSE: Kiểm tra số dư
    beqz $t2, even      # Nếu số dư = 0 thì chẵn
    
    # ELSE: Số lẻ
    li $v0, 4
    la $a0, msg_odd
    syscall
    j end
    
even:
    # IF: Số chẵn
    li $v0, 4
    la $a0, msg_even
    syscall
    
end:
    # Kết thúc
    li $v0, 10
    syscall
