# base_flutter

Project này sẽ dựa trên cấu trúc Clean Architecture kết hợp với RxDart 

## Mô tả Cấu trúc
1. Tài nguyên
- Tài nguyên sẽ lưu trong thư mục assets
+ Thư mục "fonts": Lưu các font trong ứng dụng
+ Thư mục "icons": Lưu các icons nhỏ trong ứng dụng
+ Thư mục "images": Lưu các hình ảnh lớn trong ứng dụng

2. Source code
- Toàn bộ source code sẽ để trong thư mục lib
- Mô tả cấu trúc thư mục lib:

    2.1 domain
  - Thư mục này sẽ chứa các request độc lập. Chỉ nhận nhiệm vụ giao tiếp API và khai báo đối tượng
    2.1.1 entities
    - Thư mục này khai báo các Object model
    2.1.2 repositories
    - Thư mục này khai báo hàm để giao tiếp với API trong thư mục data/repositories
    2.1.3 use_cases
    - Thư mục này khai báo các hàm để giao tiếp với repositories và 
