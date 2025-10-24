# Bài 3a: Nhập mảng n phần tử
# 1. Xuất ra min, max
# 2. Xuất ra tổng
# 3. Nhập chỉ số, xuất phần tử
#
# Cấu trúc thanh ghi (Register map)
# $s0: n (số lượng phần tử)
# $s1: Con trỏ địa chỉ gốc của mảng (Base address)
# $s2: Con trỏ duyệt mảng (Current pointer)
# $s3: Biến đếm i (cho các vòng lặp)
# $t0: Giá trị min
# $t1: Giá trị max
# $t2: Giá trị tổng (sum)
# $t3: Giá trị phần tử hiện tại (current_element)
# $t4: Chỉ số (index) người dùng nhập
# $t5: Offset (số byte cần nhảy)

.data
array_space:  .space 400     # Cấp phát bộ nhớ cho 100 số nguyên (100 * 4 bytes)
prompt_n:     .asciiz "Nhap so phan tu n (toi da 100): "
prompt_element: .asciiz "Nhap phan tu thu "
prompt_index: .asciiz "\n(3) Nhap chi so can tim: "
result_min:   .asciiz "\n(1) Gia tri nho nhat (min): "
result_max:   .asciiz "\n(1) Gia tri lon nhat (max): "
result_sum:   .asciiz "\n(2) Tong cac phan tu: "
result_index: .asciiz "Gia tri tai chi so do: "
colon:        .asciiz ": "
newline:      .asciiz "\n"

.text
.globl main
main:
    # --- PHẦN 1: NHẬP N VÀ NHẬP MẢNG ---

    # 1.1. Nhập n (số lượng phần tử)
    li $v0, 4
    la $a0, prompt_n
    syscall
    
    # <<< PHẦN ĐÃ SỬA THEO YÊU CẦU CỦA BẠN >>>
    # Đọc số nguyên (syscall code 5)
    addi $v0, $zero, 5      # $v0 = 0 + 5 (Lệnh thật thay cho 'li $v0, 5')
    syscall
    # $v0 bây giờ chứa số người dùng nhập
    add $s0, $v0, $zero     # $s0 = $v0 (Gán n, dùng lệnh thật)
    
    # (Bỏ qua kiểm tra n <= 0 hoặc n > 100 cho đơn giản)
    
    # 1.2. Vòng lặp nhập n phần tử
    la $s1, array_space     # $s1 = Địa chỉ gốc của mảng
    add $s2, $s1, $zero     # $s2 = $s1 (Khởi tạo con trỏ duyệt, dùng lệnh thật)
    add $s3, $zero, $zero   # $s3 = 0 (Khởi tạo biến đếm i, dùng lệnh thật)

loop_input:
    beq $s3, $s0, end_loop_input   # if (i == n) thì kết thúc nhập

    # In "Nhap phan tu thu i: "
    li $v0, 4
    la $a0, prompt_element
    syscall
    
    li $v0, 1
    move $a0, $s3           # In $s3 (chỉ số i)
    syscall
    
    li $v0, 4
    la $a0, colon
    syscall
    
    # Đọc số nguyên người dùng nhập
    li $v0, 5
    syscall
    
    # Lưu giá trị vào bộ nhớ
    # $v0 chứa giá trị (value)
    # $s2 chứa địa chỉ (address)
    sw $v0, 0($s2)          # array[i] = value
    
    # Cập nhật cho lần lặp tiếp theo
    addi $s2, $s2, 4        # Di chuyển con trỏ đến word tiếp theo
    addi $s3, $s3, 1        # i++
    j loop_input
    
end_loop_input:
    
    # --- PHẦN 2: TÌM MIN, MAX, SUM ---
    
    # Reset con trỏ và biến đếm
    add $s2, $s1, $zero     # $s2 = $s1 (Reset con trỏ duyệt về gốc, dùng lệnh thật)
    add $s3, $zero, $zero   # $s3 = 0 (Reset biến đếm i, dùng lệnh thật)
    
    # Khởi tạo giá trị
    lw $t0, 0($s2)          # min = array[0]
    lw $t1, 0($s2)          # max = array[0]
    add $t2, $zero, $zero   # $t2 = 0 (Khởi tạo tổng = 0, dùng lệnh thật)

loop_calc:
    beq $s3, $s0, end_loop_calc   # if (i == n) thì kết thúc tính toán
    
    # Tải phần tử hiện tại
    lw $t3, 0($s2)          # $t3 = current_element = array[i]
    
    # Tính tổng
    add $t2, $t2, $t3       # sum = sum + current_element
    
    # So sánh min
    blt $t3, $t0, new_min   # if (current_element < min) jump to new_min
    j check_max             # Bỏ qua new_min
new_min:
    add $t0, $t3, $zero     # min = current_element (Cập nhật min, dùng lệnh thật)
    
check_max:
    # So sánh max
    bgt $t3, $t1, new_max   # if (current_element > max) jump to new_max
    j continue_calc         # Bỏ qua new_min
new_max:
    add $t1, $t3, $zero     # max = current_element (Cập nhật max, dùng lệnh thật)

continue_calc:
    # Cập nhật cho lần lặp tiếp theo
    addi $s2, $s2, 4        # Di chuyển con trỏ
    addi $s3, $s3, 1        # i++
    j loop_calc

end_loop_calc:

    # --- PHẦN 3: IN KẾT QUẢ MIN, MAX, SUM ---
    
    # In Min
    li $v0, 4
    la $a0, result_min
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    
    # In Max
    li $v0, 4
    la $a0, result_max
    syscall
    li $v0, 1
    move $a0, $t1
    syscall
    
    # In Sum
    li $v0, 4
    la $a0, result_sum
    syscall
    li $v0, 1
    move $a0, $t2
    syscall

    # --- PHẦN 4: NHẬP CHỈ SỐ, XUẤT PHẦN TỬ ---
    
    li $v0, 4
    la $a0, prompt_index
    syscall
    
    li $v0, 5
    syscall
    add $t4, $v0, $zero     # $t4 = $v0 (Lưu chỉ số index, dùng lệnh thật)
    
    # (Bỏ qua kiểm tra index < 0 hoặc index >= n cho đơn giản)
    
    # Tính địa chỉ
    # address = base + (index * 4)
    sll $t5, $t4, 2         # $t5 = offset = index * 4
    add $s2, $s1, $t5       # $s2 = address = $s1 (base) + $t5 (offset)
    
    # Tải giá trị
    lw $t3, 0($s2)          # $t3 = array[index]
    
    # In kết quả
    li $v0, 4
    la $a0, result_index
    syscall
    
    li $v0, 1
    move $a0, $t3
    syscall

    # --- PHẦN 5: KẾT THÚC ---
    li $v0, 10
    syscall