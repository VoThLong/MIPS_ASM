.data
sum: .word 0
.text
.globl main
main:

    addi $s0, $zero, 0  # khởi tạo biến đếm i = 0

    li, $v0, 5
    syscall
    move $s1, $v0       # lưu n vào $s1

Loop_Start:
    beq $s0, $s1, Loop_End  # nếu i == n thì thoát vòng lặp

    addi $s0, $s0, 1        # i = i + 1
    add $t0, $t0, $s0       # t0 = t0 + i
    j Loop_Start            # quay lại đầu vòng lặp

Loop_End:
    sw $t0, sum             # lưu kết quả vào biến sum

    li $v0, 1               # in kết quả
    lw $a0, sum
    syscall

    li $v0, 10              # thoát chương trình
    syscall
exit:
.end