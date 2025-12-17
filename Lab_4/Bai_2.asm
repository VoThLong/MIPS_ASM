.text
main:
    # 1. Chuẩn bị 4 tham số đầu (a,b,c,d) vào thanh ghi
    li $a0, 10      # a
    li $a1, 5       # b
    li $a2, 3       # c
    li $a3, 2       # d
    
    # 2. Chuẩn bị tham số 5, 6 (e,f) vào STACK
    # Giả sử e = 8, f = 4
    li $t0, 8       # t0 tạm giữ e
    li $t1, 4       # t1 tạm giữ f
    
    addi $sp, $sp, -8   # Mở rộng stack 8 byte để chứa e và f
    sw   $t0, 0($sp)    # Cất e vào stack
    sw   $t1, 4($sp)    # Cất f vào stack
    
    # 3. Gọi hàm
    jal proc_example
    
    # 4. Dọn dẹp Stack của Main (Quan trọng!)
    # Sau khi hàm về, e và f trên stack không còn dùng nữa, phải trả lại chỗ
    addi $sp, $sp, 8    
    
    # --- In kết quả ---
    # In $v0 (kết quả 1)
    move $a0, $v0
    li $v0, 1
    syscall
    
    # In dấu phẩy hoặc xuống dòng... (Tùy chọn)
    
    # In $v1 (kết quả 2)
    move $a0, $v1
    li $v0, 1
    syscall

    # Thoát
    li $v0, 10
    syscall

# ---------------------------------------------------------
proc_example:
    # --- PROLOGUE: Lưu biến cục bộ ---
    addi $sp, $sp, -8    # Mở rộng stack thêm 8 byte cho s0, s1
    sw   $s0, 0($sp)     # Lưu $s0
    sw   $s1, 4($sp)     # Lưu $s1
    
    # Lúc này:
    # 0($sp) là $s0
    # 4($sp) là $s1
    # 8($sp) chính là e (tham số 5)
    # 12($sp) chính là f (tham số 6)

    # --- TÍNH TOÁN 1: (a+b) - (c+d) ---
    add  $t0, $a0, $a1   # a + b
    add  $t1, $a2, $a3   # c + d
    sub  $s0, $t0, $t1   # s0 = Kết quả 1
    
    # --- TÍNH TOÁN 2: (e - f) ---
    # Phải lấy e, f từ Stack ra trước
    lw   $t2, 8($sp)     # Lấy e (cách sp hiện tại 8 byte)
    lw   $t3, 12($sp)    # Lấy f (cách sp hiện tại 12 byte)
    
    sub  $s1, $t2, $t3   # s1 = e - f (Lưu vào biến cục bộ s1 theo đề bài)

    # --- CHUẨN BỊ TRẢ VỀ ---
    move $v0, $s0        # Trả về kq1
    move $v1, $s1        # Trả về kq2

    # --- EPILOGUE: Khôi phục ---
    lw   $s0, 0($sp)
    lw   $s1, 4($sp)
    addi $sp, $sp, 8     # Thu hồi 8 byte của hàm
    
    jr   $ra