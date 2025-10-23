    .data
prompt1: .asciiz "Nhap gia tri cho var1: "
prompt2: .asciiz "Nhap gia tri cho var2: "
    .text
main:

    #hiển thị thông báo nhập giá trị cho var1
    li $v0, 4
    la $a0, prompt1
    syscall

    #nhập giá trị đầu:
    li $v0, 5
    syscall
    move $s0, $v0

    #hiển thị thông báo
    li $v0, 4
    la $a0, prompt2
    syscall

    #nhập giá trị sau:
    li $v0, 5
    syscall
    move $s1, $v0

    #so sánh:
    beq $t0, $t1, equal
    bne $t0, $t1, notequal

equal:
    add $s2, $t0, $t1
    j exit
notequal:
    sub $s2, $t0, $t1
    j exit
exit:
