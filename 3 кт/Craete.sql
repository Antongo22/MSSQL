create table [dbo].[Employee]
(
    [ID_Employee] [int] not null identity(1,1),
    [Name_Employee] [varchar](50) not null,
    [Surname_Employee] [varchar](50) not null,
    [Patronymic_Employee] [varchar](50) null default 'Нет данных',
    [Login_Employee] [varchar](255) not null,
    [Password_Employee] [varchar](36) not null,
    constraint [PK_Employee] primary key clustered
    ([ID_Employee] ASC) on [PRIMARY],
    constraint [UQ_Login_Employee] unique ([Login_Employee]),
    constraint [CH_Login_Employee] check (len([Login_Employee]) >= 6),
    constraint [CH_Password_Employee] check (len([Password_Employee]) >= 6 and [Password_Employee] like '%[a-zA-Z]%' and [Password_Employee] like '%[0-9]%' and [Password_Employee] like '%[!@#$%^&*()]%')
)
go


create table [dbo].[Client]
(
    [ID_Client] [int] not null identity(1,1),
    [Surname_Client] [varchar](50) not null,
    [Name_Client] [varchar](50) not null,
    [Patronymic_Client] [varchar](50) null default 'Нет данных',
    [Insurance_Number_Client] [varchar](19) not null,
    [Passport_Series_Client] [varchar](5) not null,
    [Passport_Number_Client] [varchar](6) not null,
    [Birth_Client] [datetime] not null,
    [Gender_Client] [varchar](3) not null,
    [Who_Issued_Passport_Client] [varchar](max) not null,
    [When_Issued_Passport_Client] [date] not null,
    [Division_Code_Passport_Client] [varchar](7) not null,
    [Phone_Number_Client] [varchar](16) not null,
    [Email_Client] [varchar](255) not null,
    [Login_Client] [varchar](255) not null,
    [Password_Client] [varchar](36) not null,
    constraint [PK_Client] primary key clustered
    ([ID_Client] ASC) on [PRIMARY],
    constraint [UQ_Insurance_Number_Client] unique ([Insurance_Number_Client]),
    constraint [UQ_Phone_Number_Client] unique ([Phone_Number_Client]),
    constraint [UQ_Email_Client] unique ([Email_Client]),
    constraint [UQ_Login_Client] unique ([Login_Client]),
    constraint [CH_Insurance_Number_Client] check ([Insurance_Number_Client] like '[0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9]'),
    constraint [CH_Passport_Series_Client] check ([Passport_Series_Client] like '[0-9][0-9] [0-9][0-9]'),
    constraint [CH_Passport_Number_Client] check ([Passport_Number_Client] like '[0-9][0-9][0-9][0-9][0-9][0-9]'),
    constraint [CH_Birth_Client] check ([Birth_Client] <= dateadd(year, -17, getdate())),
    constraint [CH_Gender_Client] check ([Gender_Client] in ('Муж', 'Жен')),
    constraint [CH_When_Issued_Passport_Client] check ([When_Issued_Passport_Client] >= dateadd(year, -14, getdate())),
    constraint [CH_Division_Code_Passport_Client] check ([Division_Code_Passport_Client] like '[0-9][0-9][0-9]-[0-9][0-9][0-9]'),
    constraint [CH_Phone_Number_Client] check ([Phone_Number_Client] like '+7([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    constraint [CH_Email_Client] check ([Email_Client] like '%_@__%.__%'),
    constraint [CH_Login_Client] check (len([Login_Client]) >= 6 and [Login_Client] like '%[a-zA-Z]%' and [Login_Client] like '%[0-9]%' and [Login_Client] like '%[!@#$%^&*()]%'),
    constraint [CH_Password_Client] check (len([Password_Client]) >= 6 and [Password_Client] like '%[a-zA-Z]%' and [Password_Client] like '%[0-9]%' and [Password_Client] like '%[!@#$%^&*()]%')
)
go

create table [dbo].[Map]
(
    [ID_Map] [int] not null identity(1,1),
    [Name_Map] [varchar](20) not null,
    [Square_Map] [decimal](5,2) not null,
    [Length_Map] [decimal](5,2) not null,
    [Width_Map] [decimal](5,2) not null,
    [Plan_Map] [varchar](max) not null,
    [Buildings_Map] [varchar](max) null default 'Отсутствует',
    [Description_Map] [varchar](max) not null,
    [Cost_Map] [decimal](10,3) not null,
    constraint [PK_Map] primary key clustered
    ([ID_Map] ASC) on [PRIMARY],
    constraint [UQ_Name_Map] unique ([Name_Map]),
    constraint [CH_Square_Map] check ([Square_Map] > 0),
    constraint [CH_Length_Map] check ([Length_Map] > 0),
    constraint [CH_Width_Map] check ([Width_Map] > 0),
    constraint [CH_Cost_Map] check ([Cost_Map] >= 0)
)
go


create table [dbo].[Game_Type]
(
    [ID_Game_Type] [int] not null identity(1,1),
    [Name_Game_Type] [varchar](20) not null,
    [Cost_Game_Type] [decimal](10,3) not null,
    [Description_Game_Type] [varchar](max) not null,
    constraint [PK_Game_Type] primary key clustered
    ([ID_Game_Type] ASC) on [PRIMARY],
    constraint [UQ_Name_Game_Type] unique ([Name_Game_Type]),
    constraint [CH_Cost_Game_Type] check ([Cost_Game_Type] >= 0)
)
go


create table [dbo].[Inventory]
(
    [ID_Inventory] [int] not null identity(1,1),
    [Number_Inventory] [varchar](16) not null,
    [Count_Inventory] [int] not null,
    [Cost_Inventory] [decimal](10,3) not null,
    constraint [PK_Inventory] primary key clustered
    ([ID_Inventory] ASC) on [PRIMARY],
    constraint [UQ_Number_Inventory] unique ([Number_Inventory]),
    constraint [CH_Number_Inventory] check ([Number_Inventory] like 'ИнВ-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    constraint [CH_Count_Inventory] check ([Count_Inventory] >= 0),
    constraint [CH_Cost_Inventory] check ([Cost_Inventory] >= 0)
)
go


create table [dbo].[Characteristic]
(
    [ID_Characteristic] [int] not null identity(1,1),
    [Value_Characteristic] [varchar](50) not null,
    constraint [PK_Characteristic] primary key clustered
    ([ID_Characteristic] ASC) on [PRIMARY],
    constraint [UQ_Value_Characteristic] unique ([Value_Characteristic])
)
go

create table [dbo].[Contract]
(
    [Employee_ID] [int] not null,
    [Game_Type_ID] [int] not null,
    [Map_ID] [int] not null,
    [ID_Contract] [int] not null identity(1,1),
    [Number_Contract] [varchar](10) not null,
    [Cost_Contract] [decimal](10,3) not null,
    [DateTime_Forming_Contract] [datetime] not null,
    [Game_Duration_Contract] [decimal](5,2) not null,
    [Game_Start_Time_Contract] [time] not null,
    [Game_End_Time_Contract] [time] not null,
    [Final_Cost_Contract] [decimal](10,3) not null,
    constraint [PK_Contract] primary key clustered
    ([ID_Contract] ASC) on [PRIMARY],
    constraint [UQ_Number_Contract] unique ([Number_Contract]),
    constraint [CH_Number_Contract] check ([Number_Contract] like 'GM-[0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    constraint [CH_Cost_Contract] check ([Cost_Contract] >= 0),
    constraint [CH_Game_Duration_Contract] check ([Game_Duration_Contract] >= 0),
    constraint [CH_Game_Start_Time_Contract] check ([Game_Start_Time_Contract] > cast([DateTime_Forming_Contract] as time)),
    constraint [CH_Game_End_Time_Contract] check ([Game_End_Time_Contract] > [Game_Start_Time_Contract] and [Game_End_Time_Contract] > cast([DateTime_Forming_Contract] as time)),
    constraint [CH_Final_Cost_Contract] check ([Final_Cost_Contract] > 0),
    constraint [FK_Employee_Contract] foreign key ([Employee_ID])
    references [dbo].[Employee] ([ID_Employee]),
    constraint [FK_Game_Type_Contract] foreign key ([Game_Type_ID])
    references [dbo].[Game_Type] ([ID_Game_Type]),
    constraint [FK_Map_Contract] foreign key ([Map_ID])
    references [dbo].[Map] ([ID_Map])
)
go


create table [dbo].[Player_Type]
(
    [ID_Player_Type] [int] not null identity(1,1),
    [Name_Player_Type] [varchar](20) not null,
    constraint [PK_Player_Type] primary key clustered
    ([ID_Player_Type] ASC) on [PRIMARY],
    constraint [UQ_Name_Player_Type] unique ([Name_Player_Type]),
    constraint [CH_Name_Player_Type] check ([Name_Player_Type] in ('Ответственный', 'Участник'))
)
go


create table [dbo].[Client_Contract]
(
    [ID_Client_Contract] [int] not null identity(1,1),
    [Contract_ID] [int] not null,
    [Client_ID] [int] not null,
    [Player_Type_ID] [int] not null,
    constraint [PK_Client_Contract] primary key clustered
    ([ID_Client_Contract] ASC) on [PRIMARY],
    constraint [FK_Contract_Client_Contract] foreign key ([Contract_ID])
    references [dbo].[Contract] ([ID_Contract]),
    constraint [FK_Client_Client_Contract] foreign key ([Client_ID])
    references [dbo].[Client] ([ID_Client]),
    constraint [FK_Player_Type_Client_Contract] foreign key ([Player_Type_ID])
    references [dbo].[Player_Type] ([ID_Player_Type])
)
go


create table [dbo].[Inventory_Characteristic]
(
    [ID_Inventory_Characteristic] [int] not null identity(1,1),
    [Inventory_ID] [int] not null,
    [Characteristic_ID] [int] not null,
    constraint [PK_Inventory_Characteristic] primary key clustered
    ([ID_Inventory_Characteristic] ASC) on [PRIMARY],
    constraint [FK_Inventory_Inventory_Characteristic] foreign key ([Inventory_ID])
    references [dbo].[Inventory] ([ID_Inventory]),
    constraint [FK_Characteristic_Inventory_Characteristic] foreign key ([Characteristic_ID])
    references [dbo].[Characteristic] ([ID_Characteristic])
)
go


create table [dbo].[Inventory_Contract]
(
    [ID_Inventory_Contract] [int] not null identity(1,1),
    [Inventory_ID] [int] not null,
    [Contract_ID] [int] not null,
    constraint [PK_Inventory_Contract] primary key clustered
    ([ID_Inventory_Contract] ASC) on [PRIMARY],
    constraint [FK_Inventory_Inventory_Contract] foreign key ([Inventory_ID])
    references [dbo].[Inventory] ([ID_Inventory]),
    constraint [FK_Contract_Inventory_Contract] foreign key ([Contract_ID])
    references [dbo].[Contract] ([ID_Contract])
)
go


create table [dbo].[Additional_Client_Contract]
(
    [ID_Additional_Client_Contract] [int] not null identity(1,1),
    [Number_Additional_Contract] [varchar](12) not null,
    [Client_Contract_ID] [int] not null,
    constraint [PK_Additional_Client_Contract] primary key clustered
    ([ID_Additional_Client_Contract] ASC) on [PRIMARY],
    constraint [UQ_Number_Additional_Contract] unique ([Number_Additional_Contract]),
    constraint [CH_Number_Additional_Contract] check ([Number_Additional_Contract] like 'GM-[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9]'),
    constraint [FK_Client_Contract_Additional_Client_Contract] foreign key ([Client_Contract_ID])
    references [dbo].[Client_Contract] ([ID_Client_Contract])
)
go


create table [dbo].[Armor_Type]
(
    [ID_Armor_Type] [int] not null identity(1,1),
    [Inventory_ID] [int] not null,
    [Name_Armor_Type] [varchar](15) not null,
    constraint [PK_Armor_Type] primary key clustered
    ([ID_Armor_Type] ASC) on [PRIMARY],
    constraint [UQ_Name_Armor_Type] unique ([Name_Armor_Type]),
    constraint [FK_Inventory_Armor_Type] foreign key ([Inventory_ID])
    references [dbo].[Inventory] ([ID_Inventory])
)
go


create table [dbo].[Additional_Inventory]
(
    [ID_Additional_Inventory] [int] not null identity(1,1),
    [Name_Additional_Inventory] [varchar](30) not null,
    [Count_Additional_Inventory] [int] not null,
    [Cost_Additional_Inventory] [decimal](10,3) not null,
    [Contract_ID] [int] not null,
    constraint [PK_Additional_Inventory] primary key clustered
    ([ID_Additional_Inventory] ASC) on [PRIMARY],
    constraint [CH_Count_Additional_Inventory] check ([Count_Additional_Inventory] >= 0),
    constraint [CH_Cost_Additional_Inventory] check ([Cost_Additional_Inventory] >= 0),
    constraint [FK_Contract_Additional_Inventory] foreign key ([Contract_ID])
    references [dbo].[Contract] ([ID_Contract])
)
go


create table [dbo].[Mark]
(
    [ID_Mark] [int] not null identity(1,1),
    [Name_Mark] [varchar](15) not null,
    constraint [PK_Mark] primary key clustered
    ([ID_Mark] ASC) on [PRIMARY],
    constraint [UQ_Name_Mark] unique ([Name_Mark])
)
go


create table [dbo].[Model]
(
    [ID_Model] [int] not null identity(1,1),
    [Name_Model] [varchar](15) not null,
    [Mark_ID] [int] not null,
    constraint [PK_Model] primary key clustered
    ([ID_Model] ASC) on [PRIMARY],
    constraint [UQ_Name_Model] unique ([Name_Model]),
    constraint [FK_Mark_Model] foreign key ([Mark_ID])
    references [dbo].[Mark] ([ID_Mark])
)
go


create table [dbo].[Mark_Model_Inventory]
(
    [ID_Mark_Model_Inventory] [int] not null identity(1,1),
    [Inventory_ID] [int] not null,
    [Model_ID] [int] not null,
    constraint [PK_Mark_Model_Inventory] primary key clustered
    ([ID_Mark_Model_Inventory] ASC) on [PRIMARY],
    constraint [FK_Inventory_Mark_Model_Inventory] foreign key ([Inventory_ID])
    references [dbo].[Inventory] ([ID_Inventory]),
    constraint [FK_Model_Mark_Model_Inventory] foreign key ([Model_ID])
    references [dbo].[Model] ([ID_Model])
)
go


create table [dbo].[Suppliers]
(
    [ID_Supplier] [int] not null identity(1,1),
    [Name_Suppliers] [varchar](50) not null,
    [OKPO_Suppliers] [varchar](10) not null,
    [Legal_Address_Suppliers] [varchar](max) not null,
    [Physical_Address_Suppliers] [varchar](max) not null,
    [Phone_Number_Suppliers] [varchar](16) not null,
    constraint [PK_Suppliers] primary key clustered
    ([ID_Supplier] ASC) on [PRIMARY],
    constraint [UQ_Name_Suppliers] unique ([Name_Suppliers]),
    constraint [UQ_OKPO_Suppliers] unique ([OKPO_Suppliers]),
    constraint [UQ_Phone_Number_Suppliers] unique ([Phone_Number_Suppliers]),
    constraint [CH_OKPO_Suppliers] check ([OKPO_Suppliers] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    constraint [CH_Phone_Number_Suppliers] check ([Phone_Number_Suppliers] like '+7([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
)
go

create table [dbo].[Order_Status]
(
    [ID_Order_Status] [int] not null identity(1,1),
    [Status_Order_Status] [varchar](8) not null,
    constraint [PK_Order_Status] primary key clustered
    ([ID_Order_Status] ASC) on [PRIMARY],
    constraint [UQ_Status_Order_Status] unique ([Status_Order_Status]),
    constraint [CH_Status_Order_Status] check ([Status_Order_Status] in ('открыт', 'завершён'))
)
go


create table [dbo].[Supplier_Contracts]
(
    [ID_Supplier_Contracts] [int] not null identity(1,1),
    [Supplier_ID] [int] not null,
    [Contract_Number_Supplier_Contracts] [varchar](17) not null,
    [Date_Of_Formation_Supplier_Contracts] [datetime] not null,
    [Validity_Period_Supplier_Contracts] [varchar](30) not null,
    [Order_Status_ID] [int] not null,
    constraint [PK_Supplier_Contracts] primary key clustered
    ([ID_Supplier_Contracts] ASC) on [PRIMARY],
    constraint [UQ_Contract_Number_Supplier_Contracts] unique ([Contract_Number_Supplier_Contracts]),
    constraint [CH_Contract_Number_Supplier_Contracts] check ([Contract_Number_Supplier_Contracts] like 'Д-П/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9]'),
    constraint [CH_Date_Of_Formation_Supplier_Contracts] check ([Date_Of_Formation_Supplier_Contracts] <= getdate()),
    constraint [CH_Validity_Period_Supplier_Contracts] check ([Validity_Period_Supplier_Contracts] like '%[0-9]%'),
    constraint [FK_Supplier_Supplier_Contracts] foreign key ([Supplier_ID])
    references [dbo].[Suppliers] ([ID_Supplier]),
    constraint [FK_Order_Status_Supplier_Contracts] foreign key ([Order_Status_ID])
    references [dbo].[Order_Status] ([ID_Order_Status])
)
go

create table [dbo].[Inventory_Supplier_Contracts]
(
    [ID_Inventory_Supplier_Contracts] [int] not null identity(1,1),
    [Inventory_ID] [int] not null,
    [Supplier_Contracts_ID] [int] not null,
    [Count_Inventory_Supplier_Contracts] [int] not null,
    constraint [PK_Inventory_Supplier_Contracts] primary key clustered
    ([ID_Inventory_Supplier_Contracts] ASC) on [PRIMARY],
    constraint [CH_Count_Inventory_Supplier_Contracts] check ([Count_Inventory_Supplier_Contracts] > 0),
    constraint [FK_Inventory_Inventory_Supplier_Contracts] foreign key ([Inventory_ID])
    references [dbo].[Inventory] ([ID_Inventory]),
    constraint [FK_Supplier_Contracts_Inventory_Supplier_Contracts] foreign key ([Supplier_Contracts_ID])
    references [dbo].[Supplier_Contracts] ([ID_Supplier_Contracts])
)
go