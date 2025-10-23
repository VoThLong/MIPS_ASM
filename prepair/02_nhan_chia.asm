# Chương trình mẫu: Phép nhân và chia
# Tính toán: a * b và a / b

.data
    a: .word 20
    b: .word 4
    msg1: .asciiz "Phep nhan: "
    msg2: .asciiz " * "
    msg3: .asciiz " = "
    msg4: .asciiz "\nPhep chia: "
    msg5: .asciiz " / "
    msg6: .asciiz " = "
    msg7: .asciiz "\nSo du: "

.text
.globl main

main:
    # Load các giá trị
    lw $t0, a           # $t0 = a
    lw $t1, b           # $t1 = b
    
    # Phép nhân: a * b
    mult $t0, $t1       # HI:LO = a * b
    mflo $t2            # $t2 = kết quả nhân (phần thấp)
    
    # In phép nhân
    li $v0, 4
    la $a0, msg1
    syscall
    
    li $v0, 1
    move $a0, $t0
    syscall
    
    li $v0, 4
    la $a0, msg2
    syscall
    
    li $v0, 1
    move $a0, $t1
    syscall
    
    li $v0, 4
    la $a0, msg3
    syscall
    
    li $v0, 1
    move $a0, $t2
    syscall
    
    # Phép chia: a / b
    div $t0, $t1        # LO = thương, HI = số dư
    mflo $t3            # $t3 = thương
    mfhi $t4            # $t4 = số dư
    
    # In phép chia
    li $v0, 4
    la $a0, msg4
    syscall
    
    li $v0, 1
    move $a0, $t0
    syscall
    
    li $v0, 4
    la $a0, msg5
    syscall
    
    li $v0, 1
    move $a0, $t1
    syscall
    
    li $v0, 4
    la $a0, msg6
    syscall
    
    li $v0, 1
    move $a0, $t3
    syscall
    
    # In số dư
    li $v0, 4
    la $a0, msg7
    syscall
    
    li $v0, 1
    move $a0, $t4
    syscall
    
    # Kết thúc
    li $v0, 10
    syscall
