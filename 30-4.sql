create database CineMagic;

use CineMagic;

create table Movies (
	movie_id int primary key auto_increment,
    title varchar(255) not null,
    duration_minutes int not null,
    age_restriction int not null check(0 or 13 or 16 or 18) default 0
);

create table Rooms (
	room_id int primary key auto_increment,
    room_name varchar(255) not null,
    max_seats int not null check(max_seats < 60),
    room_status varchar(30) not null default('active')
);

create table Showtimes (
	showtime_id int primary key auto_increment,
    show_time int not null,
	ticket_price decimal(12, 0) not null check(ticket_price > 0),
    room_id int,
    movie_id int,
    foreign key (room_id) references Rooms(room_id),
    foreign key (movie_id) references Movies(movie_id)
);

create table Bookings (
	booking_id int primary key auto_increment,
    customer_name varchar(255) not null,
	phone varchar(15) not null,
    booking_date date not null,
    showtime_id int,
    foreign key (showtime_id) references Showtimes(showtime_id)
);

-- 1/5
insert into Movies (title, duration_minutes, age_restriction)
values 
    ('Deadpool & Wolverine', 127, 18),         
    ('Dune: Part Two', 166, 13),               
    ('Kung Fu Panda 4', 94, 0),                
    ('Godzilla x Kong: The New Empire', 115, 13); 
    
insert into Rooms (room_name, max_seats, room_status)
values 
    ('Phòng Chiếu 1 - IMAX', 55, 'active'),      
    ('Phòng Chiếu 2 - 3D', 45, 'active'),         
    ('Phòng Chiếu 3 - Standard', 50, 'maintenance'); 
    
insert into Showtimes (show_time, ticket_price, room_id, movie_id)
values 
    (1800, 120000, 1, 1),
    (1930, 95000, 2, 2),  
    (2030, 150000, 1, 4), 
    (1500, 85000, 2, 3), 
    (2230, 120000, 1, 1); 
    

insert into Bookings (customer_name, phone, booking_date, showtime_id)
values 
    ('Nguyễn Văn An', '0987654321', '2026-05-02', 1),
    ('Trần Thị Bình', '0912345678', '2026-05-02', 1), 
    ('Lê Hoàng Bách', '0923456789', '2026-05-02', 2), 
    ('Phạm Thu Cúc', '0934567890', '2026-05-02', 2), 
    ('Hoàng Tôn', '0945678901', '2026-05-02', 3),  
    ('Ngô Kiến Huy', '0956789012', '2026-05-02', 3),  
    ('Vũ Cát Tường', '0967890123', '2026-05-02', 4),   
    ('Đặng Thu Thảo', '0978901234', '2026-05-02', 4),  
    ('Bùi Tiến Dũng', '0989012345', '2026-05-02', 5),  
    ('Trịnh Thăng Bình', '0990123456', '2026-05-02', 5);
    
-- 2/5 
-- 1. Phòng chiếu số 1 điều hòa bị hỏng., hãy chuyển trạng thái phòng này thành đang bảo trì. 
update Rooms set room_status = 'maintenance' where room_id = 1;

-- Vì phòng 1 bảo trì, tất cả các Lịch chiếu đang xếp ở phòng 1 bắt buộc phải chuyển sang phòng 2. 
-- Vì phòng 2 đã có chiếu nên sẽ chuyển qua phòng 4
insert into Rooms (room_id, room_name, max_seats, room_status)
values (4, 'Phòng Chiếu 4 - Dự phòng', 50, 'active');

update Showtimes set room_id = 4 where room_id = 1;

-- 3. Một vị khách có số điện thoại là 0987654321 gọi điện xin hủy toàn bộ vé đã đặt, 
-- hãy hủy toàn bộ vé của khách hàng này.

set SQL_SAFE_UPDATES = 0;
delete from Bookings where phone = 0987654321;
set SQL_SAFE_UPDATES = 1;

-- 4. Rạp quyết định ngừng chiếu bộ phim có mã là 3, 
-- Hãy gỡ bỏ hoàn toàn bộ phim này khỏi hệ thống mà không bị lỗi.

delete from Bookings where showtime_id = 4;
delete from Showtimes where showtime_id = 4;
delete from Movies where movie_id = 3;

