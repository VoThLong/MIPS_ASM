.data
arr: .word 1, 2, 3, 4, 5, 6, 7, 8
.text
la $s3, arr
addi $s1, $zero, 0
addi $s0, $zero, 0
la $t0, ($s3)
loop:
	slti $s6, $s0, 8
	beq $s6 $zero, endloop
	
	lw $t2, 0($t0)
	
	add $s1, $s1, $t2
	addi $s0, $s0, 1
	sll $t3, $s0, 2
	add $t0, $s3, $t3
	j loop
endloop:
srl $s2, $s1, 3
exit: