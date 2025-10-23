    .data 
var1: .word 23 # Khai báo biến var1 với giá trị ban đầu là 23
    .text
__start:
    lw $t1, var1         # Load giá trị từ var1 vào $t1
    addi $t1, $t1, 5     # Cộng 5 vào giá trị trong $t1
    sw $t1, var1        # Lưu giá trị mới trở lại var1