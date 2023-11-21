# labWeek01_NguyenThanhSon_20106421
Có 2 loại account chính: account admin và account user
  - Addmin: son password: 123
  - User: cam password: 123
  - Một số acc count user khác có lưu trong database
    ![Screenshot (21)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/0dc9c635-343d-4973-a2e2-01437e221e53)

  - Nếu nhập sai email hoặc password sẽ báo lỗi
    ![Screenshot (23)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/90ffd0c0-d718-445c-95e3-d3b47a662c8a)

  - Nếu account phù hợp nhưng không được phân quyền user sẽ không thể đăng nhập được(Account test: phong password: 123).
    ![Screenshot (24)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/0c37f82e-5df9-4772-afb2-ac3fc42fbdfe)

  - Khi login thành công, một đối tượng Log được tạo và lưu vào database với loginTime là thời điểm hiện tại.
    ![Screenshot (28)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/2b967656-e2f5-4fd9-bffb-52062f81c8fe)

* Account admin:
  - Có thể xem danh sách các user với các quyền tương ứng
    ![Screenshot (16)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/da63778c-db59-4b0a-b67d-1d9b9bf88a3b)
    
  - Có thể lọc user theo role bằng cách chọn vào combobox và nhấn "Account From Role"
    ![Screenshot (17)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/6b89edd6-7f1e-4a4a-9117-85e1d0c52226)
    
  - Có thể thêm 1 user mới bằng cách nhấn vào Add account, khi thêm thành công sẽ tự động tạo tài khoản và phân quyền user. Khi đó tài khoản này có thể đăng nhập bằng id vừa tạo với password mặc định là 123.
    ![Screenshot (18)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/7219fd33-827e-436d-8dbc-86493cfe0bdd)
    ![Screenshot (19)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/32556aea-d446-4227-a03e-7a03e444392b)

  - Có thể update 1 user bằng cách nhấn vào nút Update bên cạnh user đó, điền thông tin(ngoại trừ id) và nhấn Update
    ![Screenshot (20)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/33451ddf-3893-40d2-8a52-975f4385e863)

  - Xoá 1 user bằng cách nhấn vào Delete bên cạnh user, sau đó chọn Yes trên dialog (update status = - 1)
    ![Screenshot (25)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/80a1d284-a179-46ed-8c7b-4e02e0a51a21)

  - Phân quyền/thu hồi quyền user bằng cách nhấn vào nút Grant bên cạnh user. Cột status sẽ thể hiện việc user đó đã được phân quyền này. Chọn vào các checkbox để thực hiện phân quyền hoặc thu hồi quyền của user.
    ![Screenshot (26)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/b7362374-d80f-4cb0-9d5c-d80b0c7f0fde)
    ![Screenshot (27)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/bb96b51e-52e2-47f1-bf53-8711f9937ecc)
    
  - Logout: nhấn vào nút Logout để quay trở quay trở về trang đăng nhập. Khi đó đối tượng Log được tạo lúc login sẽ update logoutTime thành thời điểm hiện tại và lưu xuống database.
    ![Screenshot (29)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/bc802dfb-202d-4665-990e-1b48151e3e9b)

* Account user:
  - Logout && Login giống với admin
  - Sau khi login thành công sẽ hiển thị thông tin và quyền của user.
    ![Screenshot (30)](https://github.com/son1105/labWeek01_NguyenThanhSon_20106421/assets/115455297/be9c860a-6b0f-4f5a-ad88-6e24ddb3d005)
