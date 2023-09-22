-- 1. Tạo database Trigger_Demo

create database Trigger_Demo;
use Trigger_Demo;

-- 2. Tạo bảng Product bao gồm các trường: productId(pk), productName, price(float)

create table Product(
	ProductId int primary key auto_increment ,
    ProductName varchar(100) unique not null,
    Price float
);

 -- 3. Tạo 1 trigger được kích hoạt trước khi sự kiện insert được xảy ra trên bảng Product,
    -- để chặn xử lý chặn insert các dữ liệu có price nhỏ hơn 0
    
DELIMITER //
create trigger BeforeInsertProduct before insert on Product for each row
BEGIN
	if(NEW.price < 0) then
		signal SQLSTATE '02000' set MESSAGE_TEXT = 'The price entered is less than 0';
    end if;
END //
DELIMITER ;
insert into Product(ProductName, Price)
values('Trái cây', 15000),('Quần áo',25000);    

-- 4. Tạo 1 trigger được kích hoạt trước khi sự kiện update được xảy ra trên bảng Product,
    -- để xử lý gán lại price = 0 nếu như price cập nhật < 0
    
DELIMITER //
create trigger BeforeUpdateProduct before update on Product for each row
BEGIN 
	if(NEW.price < 0) then
		set NEW.price = 0;
    end if;
END //
DELIMITER ;
update Product
set Price = -1000 where ProductId = 1;
select * from Product;