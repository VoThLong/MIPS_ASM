# Chương trình mẫu: So sánh hai số
# So sánh a và b, in ra kết quả

.data
    a: .word 15
    b: .word 20
    msg1: .asciiz "So sanh "
    msg2: .asciiz " va "
    msg3: .asciiz "\nKet qua: "
    msg_equal: .asciiz "Hai so bang nhau"
    msg_greater: .asciiz "So thu nhat lon hon"
    msg_less: .asciiz "So thu nhat nho hon"

.text
.globl main

main:
    # Load các giá trị
    lw $t0, a           # $t0 = a
    lw $t1, b           # $t1 = b
    
    # In thông báo
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
    
    # So sánh a và b
    beq $t0, $t1, equal     # Nếu a == b
    bgt $t0, $t1, greater   # Nếu a > b
    blt $t0, $t1, less      # Nếu a < b
    
equal:
    li $v0, 4
    la $a0, msg_equal
    syscall
    j end
    
greater:
    li $v0, 4
    la $a0, msg_greater
    syscall
    j end
    
less:
    li $v0, 4
    la $a0, msg_less
    syscall
    
end:
    # Kết thúc
    li $v0, 10
    syscall
