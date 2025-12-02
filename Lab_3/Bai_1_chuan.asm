.data
# --- Khai báo dữ liệu ---
array1: .word   5, 6, 7, 8, 1, 2, 3, 9, 10, 4
size1:  .word   10

array2: .byte   1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
size2:  .word   16

# Array3 lưu tổng 2 byte, giá trị max có thể là 255+255 = 510 -> Cần dùng .word (4 bytes)
# Size là 8 phần tử * 4 bytes = 32 bytes
array3: .space  32  
size3:  .word   8

msg_arr1: .asciiz "\nArray 1 (Word): "
msg_arr2: .asciiz "\nArray 2 (Byte): "
msg_arr3: .asciiz "\nArray 3 (Result): "
newline:  .asciiz "\n"
space:    .asciiz " "
msg_in1:  .asciiz "\nNhap mang muon lay (1, 2, 3): "
msg_in2:  .asciiz "Nhap chi so (index): "
msg_out:  .asciiz "Gia tri tai index la: "

.text
.globl main

main:
    # --- Khởi tạo địa chỉ nền (Base Addresses) ---
    # Trong phương pháp này, $s0, $s1, $s2 SẼ KHÔNG THAY ĐỔI
    la $s0, array1      # Base array1
    la $s1, array2      # Base array2
    la $s2, array3      # Base array3

    # ==========================================
    # 1. IN ARRAY 1 (Kiểu Word - 4 bytes)
    # ==========================================
    li $v0, 4
    la $a0, msg_arr1
    syscall

    li $t0, 0           # $t0 = index i = 0
    lw $t1, size1       # $t1 = size = 10

loop1_print:
    beq $t0, $t1, end_loop1
    
    # Tính địa chỉ: Address = Base + (index * 4)
    sll $t2, $t0, 2     # $t2 = i * 4 (Offset)
    add $t3, $s0, $t2   # $t3 = Base + Offset
    
    lw $a0, 0($t3)      # Load word tại địa chỉ $t3
    li $v0, 1
    syscall

    li $v0, 4           # In dấu cách
    la $a0, space
    syscall

    addi $t0, $t0, 1    # i++ (Chỉ tăng index, KHÔNG tăng $s0)
    j loop1_print
end_loop1:

    # ==========================================
    # 2. IN ARRAY 2 (Kiểu Byte - 1 byte)
    # ==========================================
    li $v0, 4
    la $a0, msg_arr2
    syscall

    li $t0, 0           # Reset index i = 0
    lw $t1, size2       # size = 16

loop2_print:
    beq $t0, $t1, end_loop2
    
    # Tính địa chỉ: Address = Base + (index * 1)
    add $t2, $s0, $zero # (Sai, phải dùng $s1 cho array2) -> Fix bên dưới
    add $t3, $s1, $t0   # $t3 = Base ($s1) + Offset ($t0)
    
    lb $a0, 0($t3)      # Load byte tại địa chỉ $t3
    li $v0, 1
    syscall

    li $v0, 4           # In dấu cách
    la $a0, space
    syscall

    addi $t0, $t0, 1    # i++
    j loop2_print
end_loop2:

    # ==========================================
    # 3. TÍNH TOÁN ARRAY 3
    # array3[i] = array2[i] + array2[15 - i]
    # ==========================================
    
    li $t0, 0           # index i = 0
    lw $t1, size3       # size = 8

loop3_calc:
    beq $t0, $t1, end_loop3

    # --- Lấy array2[i] ---
    add $t2, $s1, $t0       # Địa chỉ = Base($s1) + i
    lb $t3, 0($t2)          # $t3 = array2[i]

    # --- Lấy array2[15 - i] ---
    li $t4, 15
    sub $t4, $t4, $t0       # $t4 = 15 - i (index ngược)
    add $t5, $s1, $t4       # Địa chỉ = Base($s1) + (15-i)
    lb $t6, 0($t5)          # $t6 = array2[15-i]

    # --- Tính tổng ---
    add $t7, $t3, $t6       # $t7 = Sum

    # --- Lưu vào array3[i] (Lưu Word) ---
    sll $t8, $t0, 2         # Offset array3 = i * 4
    add $t9, $s2, $t8       # Địa chỉ = Base($s2) + Offset
    sw $t7, 0($t9)          # Store Word vào array3

    addi $t0, $t0, 1        # i++
    j loop3_calc
end_loop3:

    # ==========================================
    # 4. IN ARRAY 3 (Kiểu Word - 4 bytes)
    # ==========================================
    li $v0, 4
    la $a0, msg_arr3
    syscall

    li $t0, 0           # Reset i = 0
    lw $t1, size3       # size = 8

loop4_print:
    beq $t0, $t1, end_loop4
    
    sll $t2, $t0, 2     # Offset = i * 4
    add $t3, $s2, $t2   # Address = Base($s2) + Offset
    
    lw $a0, 0($t3)      # Load Word
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t0, $t0, 1
    j loop4_print
end_loop4:

    # ==========================================
    # 5. NHẬP XUẤT THEO YÊU CẦU
    # ==========================================
    
    # Nhập mảng số mấy
    li $v0, 4
    la $a0, msg_in1
    syscall
    li $v0, 5
    syscall
    move $t8, $v0       # $t8 = Chọn mảng (1, 2, 3)

    # Nhập index
    li $v0, 4
    la $a0, msg_in2
    syscall
    li $v0, 5
    syscall
    move $t9, $v0       # $t9 = Index cần lấy

    # In câu dẫn kết quả
    li $v0, 4
    la $a0, msg_out
    syscall

    # Kiểm tra chọn mảng nào
    beq $t8, 1, case_arr1
    beq $t8, 2, case_arr2
    beq $t8, 3, case_arr3
    j end_program       # Nếu nhập sai thì thoát (hoặc xử lý lỗi tùy ý)

case_arr1: # array1 là .word (4 bytes)
    sll $t9, $t9, 2     # Offset = index * 4
    add $t0, $s0, $t9   # Address = Base($s0) + Offset
    lw $a0, 0($t0)
    j print_result

case_arr2: # array2 là .byte (1 byte)
    add $t0, $s1, $t9   # Address = Base($s1) + index (vì nhân 1)
    lb $a0, 0($t0)
    j print_result

case_arr3: # array3 là .word (4 bytes)
    sll $t9, $t9, 2     # Offset = index * 4
    add $t0, $s2, $t9   # Address = Base($s2) + Offset
    lw $a0, 0($t0)
    j print_result

print_result:
    li $v0, 1
    syscall

end_program:
    li $v0, 10
    syscall