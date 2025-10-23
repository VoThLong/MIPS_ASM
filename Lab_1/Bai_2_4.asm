.data
string1: .asciiz "Print this.\n" # Chuỗi ký tự kết thúc bằng null
.text
main: 
li $v0, 4 # Mã lệnh hệ thống để in chuỗi ký tự
la $a0, string1 # Tải địa chỉ của chuỗi ký tự vào $a0
syscall # Gọi hệ thống để thực hiện lệnh in chuỗi ký tự