create table if not EXISTS cars (
    id serial,
    car_model VARCHAR(25) NOT NULL UNIQUE,
    car_year int not null,
    color VARCHAR(15) NOT NULL,
    price INT NOT NULL
);

insert into
    cars (car_model, car_year, color, price)
values
    ('Damas', 2011, 'Yellow', 6000),
    ('Gentra', 2021, 'Orange', 9000),
    ('Nexia', 2011, 'Blue', 8000),
    ('Cobolt', 2018, 'Gray', 16000),
    ('Captiva', 2007, 'Black', 24000),
    ('Lasetti', 2009, 'Blue', 7500),
    ('Orlando', 2012, 'Black', 14000),
    ('Matiz', 1999, 'Orange', 5000),
    ('Spark', 2008, 'Blue', 7000),
    ('Tiko', 1996, 'Yellow', 3000),
    ('Ravon', 2006, 'Orange', 8000),
    ('Cruz', 2001, 'Yellow', 15000),
    ('Tacuma', 2004, 'Yellow', 17000),
    ('Malibu', 2021, 'Orange', 25000),
    ('Tahoe', 2021, 'Yellow', 86000),
    ('Traiblazer', 2023, 'Red', 63000),
    ('Equonix', 2018, 'Black', 22000),
    ('Treker', 2022, 'Black', 23000),
    ('Epica', 2006, 'Blue', 9600),
    ('Traverce', 2020, 'Orange', 42000);

create table users (
    id SERIAL,
    username VARCHAR(50) NOT NULL,
    car_id INT,
    dollor int
);

insert into
    users (username, car_id, dollor)
values
    ('Ivan', null, 45000),
    ('Blisse', 3, 12000),
    ('Jemmie', 8, null),
    ('Ky', 13, 10000),
    ('Sharon', null, 80000),
    ('Murielle', 8, 60000),
    ('Karalynn', null, 50000),
    ('Killy', 6, null),
    ('Rochell', 9, 50000),
    ('Emmaline', null, 19000);

mashinalarning narxini % da oshiruvchi PROCEDURE tuzing masalan: call car_percentage(25) hamma mashinaning narxi 25 % oshsin [😎(GM)] 
mashinalarning qaysi ranglisi kopligini topuvchi function tuzing masalan: car_color() -> Black mashinani sotib oluvchi function tuzing masalan: get_car(4, 11) bo''lsa 4 - user 11 - carni sotib olmoqda 
            puli yetsa oldin va ma''lumotlar o''zgarsin;
            user 4 ning car_id 11 ga pilidan mashinaning puli ayrilsin.
            11 mashina o''chib ketsin;

client kiritgan yil oralig''idagi mashinalarni topib bering.
    masalan : car_year(1999,2020) Matiz, Spark ....

o''chirilgan userlar keshga saqlansin trigger bilan.mashina sotuvchi funcsiya tuzing masalan: car_shop(5, 8) shunda 5 - userning puli 8 - userning mashinasiga yetsa ularning mashinasini almashtirib pillarini ham hisob kitobini qilsin.mashinaning modelini o''zgarishini eshituvchi  trigger tuzing unda modeli o''zgargan mashinani arxiv tablga saqlab ketsin masalan: 1 car
update
    Deluxe bo''lsa  carId  oldModel newModel price bo''lib saqlansin;



-- create  function fn()
-- returns TEXT
-- language plpgsql
-- AS $$ 
--     begin 
--     return 'hello';
--     end
-- $$;

-- 1-misol

-- create  function fn(firstname varchar(15) , age int , gender varchar(12))
-- returns TEXT
-- language plpgsql
-- AS $$ 
--     begin 
--     return firstname || ' ' || age || ' ' || gender;
--     end
-- $$;

-- 2-misol

-- create or replace function fn(firstname varchar(15) , age int , gender varchar(12))
-- returns varchar(10)
-- language plpgsql
-- AS $$ 
--     begin 
--     return firstname || ' ' || age || ' ' || gender;
--     end
-- $$;


-- create or replace function fn(firstname varchar(15) , age int = 25, gender varchar(12) default 'male')
-- returns varchar(10)
-- language plpgsql
-- AS $$ 
-- declare total int default 1200;

--     begin 
--     return firstname || ' ' || age || ' ' || gender;
--     end
-- $$;

-- create or replace function carPrice(carModel VARCHAR)
-- returns int
-- language plpgsql
-- AS $car$ 
-- declare total int;
--     begin 
--     total =  (select price from cars where car_model ilike ( concat ('%',carModel , '%'))  );
--     delete from cars where car_model ilike (concat ('%', carModel, '%'));
--     return  total;
--     end
-- $car$;

-- select carPrice('mas');


-- create or replace function xolat( yosh int)
-- returns varchar
-- language plpgsql
-- AS $$ 
-- declare kishi varchar default 'salom';
--     begin 
--     if yosh between 1 and 25
--     then kishi = kishi || ' uka';
--     elsif yosh between 25 and 55
--     then kishi = kishi ||  ' oka';
--     else kishi =  'as'  || kishi || 'u alaykum doda ';
--     end if;
--     return  kishi;
--     end
-- $$;



-- create or replace function total()
-- returns varchar
-- language plpgsql
-- AS $$ 
-- declare jami int default 0;
-- years varchar default '>>:';
-- car cars%ROWTYPE;
--     begin 
--     for car in (select * from cars)
--     loop
--     if car.car_year % 2 = 0
--     then years = years || car.car_year || ',';
--     end if;
--     end loop;
--     return  years;
--     end
-- $$;




create or replace function for_trigger()
returns trigger
language plpgsql
as $$
begin
 insert into cash (car_id,car_model, car_year, color, price) values 
 (old.id,old.car_model, old.car_year, old.color, old.price);
 raise info 'deleted' ;
 return old;
end
$$;




create table cash(
    id serial,
    car_id int not null,
    car_model VARCHAR(25) NOT NULL UNIQUE,
    car_year int not null,
    color VARCHAR(15) NOT NULL,
    price INT NOT NULL
);
-- ========================== trigger========================-----

-- create TRIGGER trigger_name
-- [before || after ] [insert || update || delete || truncate]
-- on table_name
--  execute [function  || PROCEDURE ] [function_name || PROCEDURE_name]


-- create or replace TRIGGER myTrigger
-- after insert 
-- on cars
-- FOR EACH ROW
-- execute function for_trigger();

create or replace TRIGGER myTrigger
before delete 
on cars
FOR EACH ROW
execute function for_trigger();

insert into cars (car_model, car_year, color, price) values
    ('lexus2', 2011, 'Yellow', 6000);

delete from cars where id = 3;
-- ========================== trigger========================-----






-- ========================procudure====================--
create or  plpgsql
AS $$ replace procedure pro(  )
language
declare total int default 0;
    begin 
 select sum(price)
 into total
 from cars;
 raise  info 'total';
    end
$$;
