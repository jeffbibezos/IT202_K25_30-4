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
