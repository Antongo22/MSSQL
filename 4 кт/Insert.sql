INSERT INTO [dbo].[Employee] ([Name_Employee], [Surname_Employee], [Patronymic_Employee], [Login_Employee], [Password_Employee])
VALUES 
('Иван', 'Иванов', 'Иванович', 'em_IvanovII', 'Pa$$w0rd'),
('Пётр', 'Петров', 'Петрович', 'em_PetrovPP', 'Pa$$w0rd'),
('Алексей', 'Алексеев', 'Алексеевич', 'em_Alekseev', 'Pa$$w0rd');
GO

insert into [dbo].[Client] (
    [Surname_Client],
    [Name_Client],
    [Patronymic_Client],
    [Insurance_Number_Client],
    [Passport_Series_Client],
    [Passport_Number_Client],
    [Birth_Client],
    [Gender_Client],
    [Who_Issued_Passport_Client],
    [When_Issued_Passport_Client],
    [Division_Code_Passport_Client],
    [Phone_Number_Client],
    [Email_Client],
    [Login_Client],
    [Password_Client]
)
values 
('Андреев', 'Алексей', 'Дмитриевич', '0001 0001 1008 1999', '45 92', '642742', CONVERT(date, '1999-08-10', 120), 'Муж', 'Отделение УФМС России по городу Москве по ЮАО', CONVERT(date, '2019-09-11', 120), '770-262', '+7(945)762-57-92', 'Andreev_a_a@gmail.com', 'AndreevAD', 'Pa$$w0rd'),
('Владимиров', 'Евгений', 'Олегович', '0000 0001 2402 1998', '44 65', '212964',  CONVERT(date,'1998-02-24', 120), 'Муж', 'Отделение УФМС России по городу Москве по СВАО', CONVERT(date, '2018-03-25', 120), '770-912', '+7(955)874-63-02', 'Vladimirov_e_o@ya.ru', 'VladimirovEO', 'Pa$$w0rd'),
('Никитин', 'Кирилл', 'Семёнович', '0001 0000 0711 2001', '45 12', '633276', CONVERT(date, '2001-11-07', 120), 'Муж', 'Отделение УФМС России по городу Москве по САО', CONVERT(date, '2021-12-08', 120), '770-124', '+7(947)587-36-42', 'Nikitin_k_s@gmail.com', 'NikitinKS', 'Pa$$w0rd'),
('Павлов', 'Леонид', 'Андреевич', '0001 0111 2010 2000', '48 31', '874337', CONVERT(date, '2000-10-20', 120), 'Муж', 'Отделение УФМС России по городу Москве по ВАО', CONVERT(date, '2020-11-21', 120), '770-982', '+7(995)475-03-54', 'Pavlov_l_a@ya.ru', 'PavlovLA', 'Pa$$w0rd'),
('Иванов', 'Павел', 'Александрович', '0000 0001 2905 2002', '42 66', '167832', CONVERT(date, '2002-05-29', 120), 'Муж', 'Отделение УФМС России по городу Москве по ЮАО', CONVERT(date, '2022-06-30', 120), '770-262', '+7(982)716-52-12', 'Ivanov_p_a@ya.ru', 'IvanovPA', 'Pa$$w0rd'),
('Романов', 'Дмитрий', 'Антонович', '0100 1000 0109 2001', '43 56', '843377', CONVERT(date, '2001-08-01', 120), 'Муж', 'Отделение УФМС России по городу Москве по ЦАО', CONVERT(date, '2021-09-02', 120), '770-832', '+7(935)768-23-79', 'Ronmanov_d_a@ya.ru', 'RomanovDA', 'Pa$$w0rd'),
('Егоров', 'Игорь', 'Олегович', '0000 0000 1807 2000', '45 67', '113456', CONVERT(date, '2000-07-18', 120), 'Муж', 'Отделение УФМС России по городу Москве по ЦАО', CONVERT(date, '2020-08-19', 120), '770-832', '+7(993)557-66-57', 'Egorov_i_o@gmail.com', 'EgorovIO', 'Pa$$w0rd');
go


insert into [dbo].[Map] (
    [Name_Map],
    [Square_Map],
    [Length_Map],
    [Width_Map],
    [Plan_Map],
    [Buildings_Map],
    [Description_Map],
    [Cost_Map]
)
values 
('Карта-А1', 247.5, 15.0, 16.5, 'C:\Users\Планы карт\Карта-А1.png', 'Четыре отдельных одноэтажных сооружений', 'Открытая местность, по краям лесополоса', 2500.00),
('Карта-А2', 130.0, 10.0, 13.0, 'C:\Users\Планы карт\Карта-А2.png', 'Отсутствуют', 'Холмистая местность, с небольшим водоёмом', 2000.00),
('Карта-Б1', 203.7, 21.0, 9.7, 'C:\Users\Планы карт\Карта-Б1.png', 'Одно большое здание на три этажа', 'Общее возвышение рельефа с запада на восток на 4 метра', 2750.00),
('Карта-Б2', 104.0, 13.0, 8.0, 'C:\Users\Планы карт\Карта-Б2.png', 'Два здания высотой в два этажа', 'Равнина, преобладает редкий лес', 2500.00);
go



insert into [dbo].[Game_Type] (
    [Name_Game_Type],
    [Cost_Game_Type],
    [Description_Game_Type]
)
values 
('Все против всех', 1000.00, 'Все игроки набивают очки за попадание друг в друга'),
('Командный матч', 1100.00, 'Игроки делятся на команды и набивают очки за попадание в команду противника'),
('На выбывание', 900.00, 'Игра длится до тех пор, пока, не останется последний «Чистый» игрок'),
('Штурм', 1200.00, 'Есть атакующие и защищающие. Атакующие штурмуют объект, который защищает другая команда');
go



insert into [dbo].[Inventory] (
    [Number_Inventory],
    [Count_Inventory],
    [Cost_Inventory]
)
values 
('ИнВ-00000001', 20, 1500.00),
('ИнВ-00000002', 15, 1650.00),
('ИнВ-00000003', 21, 2000.00),
('ИнВ-00000004', 125, 150.00),
('ИнВ-00000005', 130, 200.00),
('ИнВ-00000006', 30, 350.00),
('ИнВ-00000007', 30, 650.00),
('ИнВ-00000008', 60, 200.00),
('ИнВ-00000009', 70, 250.00);
go



insert into [dbo].[Characteristic] (
    [Value_Characteristic]
)
values 
('Стальной ствол'),
('Одиночный режим стрельбы'),
('Стрельба очередями'),
('Карбоновый ствол'),
('Легче на 250 гр'),
('Комбинированный режим стрельбы'),
('Тонкая оболочка'),
('Одно цвета'),
('Разноцветные'),
('Легкий материал'),
('Защищает всё лицо'),
('Толстый слой металла'),
('Средней толщины слой металла');
go



insert into [dbo].[Contract] (
    [Employee_ID],
    [Game_Type_ID],
    [Map_ID],
    [Number_Contract],
    [Cost_Contract],
    [DateTime_Forming_Contract],
    [Game_Duration_Contract],
    [Game_Start_Time_Contract],
    [Game_End_Time_Contract],
    [Final_Cost_Contract]
)
values 
(1, 2, 4, 'GM-0000001', 2000.00, CONVERT(datetime, '2023-09-10 10:40', 120), 2.0, '11:00', '13:00', 9300.00),
(1, 4, 4, 'GM-0000002', 1500.00, CONVERT(datetime, '2023-10-14 11:30', 120), 1.5, '12:00', '13:30', 7000.00),
(2, 2, 1, 'GM-0000003', 2000.00, CONVERT(datetime, '2023-10-20 09:43', 120), 2.0, '12:15', '14:15', 8500.00);
go


insert into [dbo].[Player_Type] (
    [Name_Player_Type]
)
values 
('Участник'),
('Ответственный');
go


insert into [dbo].[Client_Contract] (
    [Contract_ID],
    [Client_ID],
    [Player_Type_ID]
)
values 
(1, 1, 1),
(1, 2, 1),
(1, 5, 1),
(1, 3, 2),
(2, 4, 1),
(2, 5, 1),
(2, 1, 1),
(3, 7, 2),
(3, 2, 1),
(3, 7, 1),
(3, 3, 2);
go


insert into [dbo].[Inventory_Characteristic] (
    [Inventory_ID],
    [Characteristic_ID]
)
values
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(3, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 7),
(5, 9),
(6, 10),
(6, 11),
(7, 12),
(8, 13),
(9, 13);
go


insert into [dbo].[Inventory_Contract] (
    [Inventory_ID],
    [Contract_ID]
)
values
(1, 1),
(1, 1),
(5, 1),
(6, 2),
(6, 2),
(2, 3),
(9, 3);
go



insert into [dbo].[Additional_Client_Contract] (
    [Client_Contract_ID],
    [Number_Additional_Contract]
)
values
(1, 'GM-0000001/1'),
(2, 'GM-0000001/2'),
(3, 'GM-0000001/3'),
(5, 'GM-0000002/1'),
(6, 'GM-0000002/2'),
(7, 'GM-0000002/3'),
(9, 'GM-0000003/1'),
(10, 'GM-0000003/2');
go



insert into [dbo].[Armor_Type] (
    [Inventory_ID],
    [Name_Armor_Type]
)
values
(6, 'Шлем'),
(7, 'Бронежилет'),
(8, 'Налокотники'),
(9, 'Наколенники');
go



insert into [dbo].[Additional_Inventory] (
    [Contract_ID],
    [Name_Additional_Inventory],
    [Count_Additional_Inventory],
    [Cost_Additional_Inventory]
)
values
(1, 'Блок защиты', 2, 500),
(2, 'Блок защиты', 2, 500),
(2, 'Металлические бочки', 6, 600),
(3, 'Металлические бочки', 10, 1000);
go

insert into [dbo].[Mark] (
    [Name_Mark]
)
values
('MarkerShot'),
('Body Arm');
go


insert into [dbo].[Model] (
    [Mark_ID],
    [Name_Model]
)
values
(1, 'Mrk I'),
(1, 'Mrk I-I'),
(1, 'Mrk II'),
(1, 'PlasticBall 100'),
(1, 'PlasticBall 90'),
(2, 'Hlmt-100'),
(2, 'Shld-130'),
(2, 'HdsDf-10'),
(2, 'LgsDf-10');
go



insert into [dbo].[Mark_Model_Inventory] (
    [Inventory_ID],
    [Model_ID]
)
values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9);
go


insert into [dbo].[Suppliers] (
    [Name_Suppliers],
    [OKPO_Suppliers],
    [Legal_Address_Suppliers],
    [Physical_Address_Suppliers],
    [Phone_Number_Suppliers]
)
values
('ООО «Страйк-Прод»', '2434525672', 'г. Москва, ул. Новоясеневская, д. 10, к. 6', 'г. Москва, ул. Дмитровская, д. 19, стр. А', '+7(499)672-88-17'),
('НПАО «Инвентарь Групп»', '9257257205', 'г. Москва, ул. Таганская, д. 54, стр. 1', 'г. Москва, ул. Коломенская, д. 11, стр. 8', '+7(499)106-76-95');
go


insert into [dbo].[Order_Status] (
    [Status_Order_Status]
)
values
('Открыт'),
('Завершён');
go



insert into [dbo].[Supplier_Contracts] (
    [Supplier_ID],
    [Contract_Number_Supplier_Contracts],
    [Date_Of_Formation_Supplier_Contracts],
    [Validity_Period_Supplier_Contracts],
    [Order_Status_ID]
)
values
(2, 'Д-П/0000000001/23', CONVERT(date, '2023-01-02', 120), '1 год', 2),
(2, 'Д-П/0000000002/23', CONVERT(date, '2023-04-17', 120), '1 год', 1),
(1, 'Д-П/0000000001/24', CONVERT(date, '2024-01-03', 120), '2 года', 1),
(2, 'Д-П/0000000002/24', CONVERT(date, '2024-02-10', 120), '1 год', 1);
go


insert into [dbo].[Inventory_Supplier_Contracts] (
    [Inventory_ID],
    [Supplier_Contracts_ID],
    [Count_Inventory_Supplier_Contracts]
)
values
(1, 1, 7),
(3, 1, 5),
(7, 1, 40),
(1, 2, 5),
(6, 2, 25),
(8, 2, 10),
(6, 3, 25),
(8, 3, 15),
(3, 4, 5),
(7, 4, 10),
(9, 4, 30);
go


