# Bài 3b: Chuyển code C sang MIPS
# if (i < j) A[i] = i; else A[i] = j;
#
# Cấu trúc thanh ghi (Theo yêu cầu PDF)
# $s0: Biến i
# $s1: Biến j
# $s3: Địa chỉ nền (base address) của mảng A
#
# Các thanh ghi mình dùng thêm:
# $s2: n (số lượng phần tử)
# $s4: Con trỏ duyệt mảng (Current pointer)
# $s5: Biến đếm k (cho vòng lặp nhập)
# $t0: Dùng để tính offset (i * 4)
# $t1: Dùng để chứa địa chỉ &A[i]
# $t2: Dùng để chứa giá trị mới (i hoặc j) để in ra

.data
array_A:      .space 400     # Cấp phát bộ nhớ cho 100 số nguyên (100 * 4 bytes)
prompt_n:     .asciiz "Nhap so phan tu n (toi da 100): "
prompt_element: .asciiz "Nhap phan tu A["
prompt_i:     .asciiz "Nhap chi so i: "
prompt_j:     .asciiz "Nhap gia tri j: "
result_msg:   .asciiz "\nThuc thi: if (i < j) A[i] = i; else A[i] = j;\n"
result_msg2:  .asciiz "Gia tri A["
result_msg3:  .asciiz "] da duoc cap nhat thanh: "
bracket:      .asciiz "]: "
newline:      .asciiz "\n"

.text
.globl main
main:
    # --- PHẦN 1: NHẬP N VÀ MẢNG A ---
    
    # Nạp địa chỉ nền của A vào $s3 (theo yêu cầu)
    la $s3, array_A         # $s3 = Base address of A
    
    # 1.1. Nhập n (số lượng phần tử)
    li $v0, 4
    la $a0, prompt_n
    syscall
    
    li $v0, 5
    syscall
    add $s2, $v0, $zero     # <<< SỬA: $s2 = n (lưu kết quả syscall, thay cho 'move')
    
    # 1.2. Vòng lặp nhập n phần tử
    add $s4, $s3, $zero     # <<< SỬA: $s4 = $s3 (con trỏ duyệt, thay cho 'move')
    add $s5, $zero, $zero   # <<< SỬA: $s5 = k = 0 (thay cho 'li')

loop_input_b:
    beq $s5, $s2, end_loop_input_b   # if (k == n) thì kết thúc nhập

    # In "Nhap phan tu A[k]: "
    li $v0, 4
    la $a0, prompt_element
    syscall
    
    li $v0, 1
    move $a0, $s5           # Giữ 'move' cho syscall
    syscall
    
    li $v0, 4
    la $a0, bracket
    syscall
    
    # Đọc số nguyên người dùng nhập
    li $v0, 5
    syscall
    
    # Lưu giá trị vào bộ nhớ
    sw $v0, 0($s4)          # A[k] = value
    
    # Cập nhật cho lần lặp tiếp theo
    addi $s4, $s4, 4        # Di chuyển con trỏ đến word tiếp theo
    addi $s5, $s5, 1        # k++
    j loop_input_b
    
end_loop_input_b:
    
    # --- PHẦN 2: NHẬP i VÀ j ---
    
    # 2.1. Nhập i
    li $v0, 4
    la $a0, prompt_i
    syscall
    li $v0, 5
    syscall
    add $s0, $v0, $zero     # <<< SỬA: $s0 = i (lưu kết quả syscall, thay cho 'move')
    
    # 2.2. Nhập j
    li $v0, 4
    la $a0, prompt_j
    syscall
    li $v0, 5
    syscall
    add $s1, $v0, $zero     # <<< SỬA: $s1 = j (lưu kết quả syscall, thay cho 'move')
    
    # (Bỏ qua kiểm tra i < 0 hoặc i >= n cho đơn giản)

    # --- PHẦN 3: LOGIC C -> MIPS ---
    # if (i < j) A[i] = i; else A[i] = j;
    
    li $v0, 4
    la $a0, result_msg
    syscall

    # Tính địa chỉ &A[i] trước
    # offset = i * 4
    sll $t0, $s0, 2         # $t0 = $s0 * 4 
    # address = base + offset
    add $t1, $s3, $t0       # $t1 = &A[i] = $s3 (base) + $t0 (offset)
    
    # Thực hiện if (i < j)
    blt $s0, $s1, if_less   # if ($s0 < $s1) branch to if_less
    
    # --- Khối ELSE ---
    # (Nếu i >= j)
    # A[i] = j;
    sw $s1, 0($t1)          # Ghi giá trị của j ($s1) vào địa chỉ &A[i] ($t1)
    add $t2, $s1, $zero     # <<< SỬA: $t2 = j (lưu giá trị mới, thay cho 'move')
    j end_if_b              # Nhảy tới cuối
    
if_less:
    # --- Khối IF ---
    # (Nếu i < j)
    # A[i] = i;
    sw $s0, 0($t1)          # Ghi giá trị của i ($s0) vào địa chỉ &A[i] ($t1)
    add $t2, $s0, $zero     # <<< SỬA: $t2 = i (lưu giá trị mới, thay cho 'move')

end_if_b:
    
    # --- PHẦN 4: IN KẾT QUẢ CẬP NHẬT ---
    # In "Gia tri A[i] da duoc cap nhat thanh: [giá trị mới]"
    li $v0, 4
    la $a0, result_msg2
    syscall
    
    li $v0, 1
    move $a0, $s0           # Giữ 'move' cho syscall
    syscall
    
    li $v0, 4
    la $a0, result_msg3
    syscall
    
    li $v0, 1
    move $a0, $t2           # Giữ 'move' cho syscall
    syscall

    # --- PHẦN 5: KẾT THÚC ---
    li $v0, 10
    syscall

