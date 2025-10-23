.data
array1: .word   5, 6, 7, 8, 1, 2, 3, 9, 10, 4
size1: .word   10
array2:.byte   1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
size2: .word   16

# <<< PHẦN SỬA 1: SỬA LỖI TRONG FILE ĐỀ BÀI >>>
# Yêu cầu của đề là array3[i] = array2[i] + array2[15-i] (byte + byte)
# Kết quả của (byte + byte) có thể lớn hơn 255, nên PHẢI lưu bằng .word (4 bytes)
# Vì size3 = 8, nên ta cần 8 (phần tử) * 4 bytes = 32 bytes
array3: .space  32
size3:  .word   8

.text
.globl main
main:
# --- Khởi tạo các thanh ghi ---
la $s0, array1      # Con trỏ array1
la $s1, array2      # Con trỏ array2
la $s2, array3      # Con trỏ array3 (sẽ dùng sau)
li $t0, 0           # $t0 = biến đếm i cho loop1
li $t1, 0           # $t1 = biến đếm i cho loop2
li $t2, 0           # $t2 = biến đếm i cho loop3
lw $t4, size1       # $t4 = 10
lw $t5, size2       # $t5 = 16
lw $t6, size3       # $t6 = 8

# --- Yêu cầu 1: In array1 ---
loop1:
    beq $t0, $t4, end_loop1   # Dừng khi i == 10

    lw $t3, 0($s0)            # Load word (4 bytes)
    move $a0, $t3
    li $v0, 1
    syscall
    
    li $a0, 32                # In dấu cách
    li $v0, 11
    syscall

    addi $s0, $s0, 4          # Nhảy 4 bytes
    addi $t0, $t0, 1          # i++
    j loop1
end_loop1:

li $a0, 10      # In ký tự xuống dòng
li $v0, 11
syscall

# --- Yêu cầu 1: In array2 ---
loop2:
    beq $t1, $t5, end_loop2   # Dừng khi i == 16

    lb $t3, 0($s1)            # Load byte (1 byte)
    move $a0, $t3
    li $v0, 1
    syscall
    
    li $a0, 32                # In dấu cách
    li $v0, 11
    syscall

    addi $s1, $s1, 1          # Nhảy 1 byte
    addi $t1, $t1, 1          # i++
    j loop2
end_loop2:

li $a0, 10      # In ký tự xuống dòng
li $v0, 11
syscall

# --- <<< PHẦN SỬA 2: VIẾT LẠI HOÀN TOÀN LOOP3 VÀ LOOP4 >>> ---
# Yêu cầu 2: Gán array3[i] = array2[i] + array2[size2-1-i]

# Reset lại con trỏ cho đúng yêu cầu
la $s0, array2          # $s0 = con trỏ cho array2[i] (bắt đầu từ đầu)
la $s1, array2 + 15     # $s1 = con trỏ cho array2[15-i] (bắt đầu từ cuối)
la $s2, array3          # $s2 = con trỏ cho array3[i]

loop3_correct:
    beq $t2, $t6, end_loop3_correct   # Dừng khi $t2 (biến đếm i) == $t6 (size3 = 8)

    # 1. Tải 2 giá trị byte từ array2
    lb $t3, 0($s0)          # $t3 = array2[i]
    lb $t7, 0($s1)          # $t7 = array2[15-i] (dùng $t7 để không ghi đè $t3)

    # 2. Tính tổng
    add $t3, $t3, $t7       # $t3 = $t3 + $t7 (Kết quả là 1 số nguyên)

    # 3. Lưu kết quả (dưới dạng word 4-byte) vào array3
    sw $t3, 0($s2)          # array3[i] = kết quả

    # 4. Di chuyển các con trỏ
    addi $s0, $s0, 1        # Tới array2[i+1] (nhảy 1 byte)
    subi $s1, $s1, 1        # Tới array2[15-(i+1)] (lùi 1 byte)
    addi $s2, $s2, 4        # Tới array3[i+1] (nhảy 4 bytes vì lưu word)
    addi $t2, $t2, 1        # i++
    
    j loop3_correct
end_loop3_correct:

# --- In array3 để kiểm tra kết quả ---
li $t2, 0           # Reset biến đếm i = 0
la $s2, array3      # Reset con trỏ $s2 về đầu array3

loop4_print:
    beq $t2, $t6, end_loop4_print # Dừng khi i == 8

    # array3 bây giờ là mảng .word, nên ta dùng lw
    lw $t3, 0($s2)            # Load kết quả (word 4 bytes) từ array3
    move $a0, $t3
    li $v0, 1
    syscall
    
    li $a0, 32                # In dấu cách
    li $v0, 11
    syscall

    addi $s2, $s2, 4          # Nhảy 4 bytes (sang kết quả tiếp theo)
    addi $t2, $t2, 1          # i++
    j loop4_print
end_loop4_print:

li $a0, 10      # In ký tự xuống dòng
li $v0, 11
syscall

li $v0, 5
syscall
move $t9, $v0  # Lưu số nguyên vừa nhập vào $t9

li $v0, 5
syscall
move $t8, $v0  # Lưu số nguyên vừa nhập vào $t8

la $s0, array1      # Con trỏ array1
la $s1, array2      # Con trỏ array2
la $s2, array3      # Con trỏ array3 (sẽ dùng sau)
li $t0, 0           # $t0 = biến đếm i cho loop1
li $t1, 0           # $t1 = biến đếm i cho loop2
li $t2, 0           # $t2 = biến đếm i cho loop3

if:
    beq $t9, 1, equal_one
    beq $t9, 2, equal_two
    beq $t9, 3, equal_three


equal_one:

    sll $t7, $t8, 2        # $t7 = $t8 * 4 (vì array1 là .word)
    add $s0, $s0, $t7       # Tính địa chỉ
    lw $t3, 0($s0)
    move $a0, $t3
    li $v0, 1
    syscall
    j end_if
equal_two:
    sll $t7, $t8, 0        # $t7 = $t8 * 1 (vì array2 là .byte)
    add $s1, $s1, $t7       # Tính địa chỉ
    lb $t3, 0($s1)
    move $a0, $t3
    li $v0, 1
    syscall
    j end_if
equal_three:
    sll $t7, $t8, 2        # $t7 = $t8 * 4 (vì array3 là .word)
    add $s2, $s2, $t7       # Tính địa chỉ
    lw $t3, 0($s2)
    move $a0, $t3
    li $v0, 1
    syscall
    j end_if
end_if:


# --- Kết thúc chương trình ---
li $v0, 10
syscall
