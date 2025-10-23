.data
array1: .space  12  # Dành 12 bytes cho mảng array1 (3 phần tử kiểu word)

.text
__start:    
        la  $t0, array1     # Tải địa chỉ của array1 vào $t0
        li  $t1, 5          # Tải giá trị 5 vào $t1
        sw  $t1, 0($t0)     # Lưu giá trị 5 vào phần tử đầu tiên của array1
        li  $t1, 13         # Tải giá trị 13 vào $t1
        sw  $t1, 4($t0)     # Lưu giá trị 13 vào phần tử thứ hai của array1
        li  $t1, -7         # Tải giá trị -7 vào $t1
        sw  $t1, 8($t0)     # Lưu giá trị -7 vào phần tử thứ ba của array1
        
        # Kết thúc chương trình
        li  $v0, 10         # Syscall code cho exit
        syscall             # Thoát chương trình
