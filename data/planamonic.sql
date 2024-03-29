create database PLANAMONIC
use planamonic

create table contries
(
	contryID int primary key not null,
	contryName nvarchar(50) not null 
)

create table cabintypes
(
	cabintypeID int primary key not null,
	cabintypeName nvarchar(50) not null
)
/*Máy bay*/
create table aircrafts
(
	aircraftID int primary key not null,
	aircraftName nvarchar(50) not null,
	/*kieuloai*/
	makemodel nvarchar(50) not null,
	/*số chỗ*/
	totalseats int not null,
	/**số ghế thường*/
	economyseats int not null,
	/*ghế thương gia*/
	businessseats int not null
)
create table offices
(
	officeID int primary key not null,
	contryID int not null,
	title nvarchar(50 )not null,
	phone int not null,
	contact nvarchar(50) not null
	constraint fk1 foreign key(contryID) references contries(contryID) on update cascade on delete cascade 
)
/*Sân bay*/
create table airports
(
	airportID int primary key not null,
	contryID int not null,
	LATACode nvarchar(50) not null,
	airportName nvarchar(50) not null,
	constraint fk2 foreign key(contryID) references contries(contryID) on update cascade on delete cascade 
)

create table users
(
	userID int not null primary key,
	officeID int not null,
	email varchar(50) not null,
	pass varchar(50) not null,
	fristname nvarchar(50) not null,
	lastname nvarchar(50) not null,
	birthdate datetime not null,
	active nvarchar(50) not null,
	constraint fk3 foreign key(officeID) references offices(officeID) on update cascade on delete cascade 
)

/*lộ trình*/
create table lotrinh
(
	routeID int not null primary key,
	/*diemden */
	departureairportID int not null,
	arrivalairportID int not null,
	/* khoảng cách*/
	distance float not null,
	flighttime time not null,
	constraint fk4 foreign key(departureairportID) references airports(airportID) on update cascade on delete cascade, 
	constraint fk5 foreign key(arrivalairportID) references airports(airportID)
	)
/*kế hoạch bay*/
create table schedules
(
	scheduleID int not null primary key,
	ngay date not null,
	thoigian time not null,
	aircraftID int not null,
	routeID int not null,
	flightnumber varchar(50) not null,
	economyprice float not null,
	/*xác nhận*/
	confirmed nvarchar(50) not null,
	constraint fk6 foreign key(aircraftID) references aircrafts(aircraftID) on update cascade on delete cascade ,
	constraint fk7 foreign key(routeID) references lotrinh(routeID) on update cascade on delete cascade 
)

create table tickets
(
	ticketID int not null primary key,
	userID int not null,
	scheduleID int not null,
	cabintypeID int not null,
	/*passport: hộ chiếu*/
	passportnumber int not null,
	passportcontryID int not null,
	bookingreference nvarchar(50) not null,
	confirmed nvarchar(50) not null,
	constraint fk8 foreign key(passportcontryID) references contries(contryID) on update cascade on delete cascade ,
	constraint fk9 foreign key(userID) references users(userID) ,
	constraint fk10 foreign key(scheduleID) references schedules(scheduleID)  ,
	constraint fk11 foreign key(cabintypeID) references cabintypes(cabintypeID) on update cascade on delete cascade 
)
