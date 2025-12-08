.data
arr: .word 1, 2, 3, 4, 5, 6, 7, 8
.text
la	$s3, arr
addi   $s1, $zero, 0      
addi   $s0, $zero, 0     
loop:   
        slti  $t0, $s0, 8            
        beq   $t0, $zero, exit
        sll   $t1, $s0, 2            
        add   $t1, $t1, $s3         
        lw    $t2, ($t1)            
        add   $s1, $s1, $t2     
        addi  $s0, $s0, 1  
        j     loop
exit:
        srl   $s2, $s1, 3