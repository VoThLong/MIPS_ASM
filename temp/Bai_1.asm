.data
array1: .word   5, 6, 7, 8, 1, 2, 3, 9, 10, 4
size1: .word   10
array2:.byte   1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
size2: .word   16
array3: .space  32
size3:  .word   8

.text
.globl main
main:
	la $s0, array1
	add $s1,$zero, $s0
	lw $t1, size1
	addi $t0, $zero, 0
loop:
	beq $t0, $t1, end_loop
	
	sll $t2, $t0, 2
	add $s1, $s1, $t2
	
	lw $a0, 0($s1)
	li $v0, 1
	syscall 
	
	add $s1, $zero, $s0
	addi $t0, $t0, 1
	j loop
	
end_loop: