create or alter procedure [dbo].[Employee_insert]
@Name_Employee [varchar](50),
@Surname_Employee [varchar](50),
@Patronymic_Employee [varchar](50) = 'Нет данных',
@Login_Employee [varchar](255),
@Password_Employee [varchar](36)
as
begin
    if (len(@Login_Employee) < 6)
    begin
        print('Логин должен содержать не менее 6 символов!');
        return;
    end

    if (len(@Password_Employee) < 6 or not @Password_Employee like '%[a-zA-Z]%' or not @Password_Employee like '%[0-9]%' or not @Password_Employee like '%[!@#$%^&*()]%')
    begin
        print('Пароль должен содержать не менее 6 символов, включая буквы, цифры и специальные символы!');
        return;
    end

    insert into [dbo].[Employee] (Name_Employee, Surname_Employee, Patronymic_Employee, Login_Employee, Password_Employee)
    values (@Name_Employee, @Surname_Employee, @Patronymic_Employee, @Login_Employee, @Password_Employee);
end
go

create or alter procedure [dbo].[Employee_update]
@ID_Employee [int],
@Name_Employee [varchar](50),
@Surname_Employee [varchar](50),
@Patronymic_Employee [varchar](50) = 'Нет данных',
@Login_Employee [varchar](255),
@Password_Employee [varchar](36)
as
begin
    if (len(@Login_Employee) < 6)
    begin
        print('Логин должен содержать не менее 6 символов!');
        return;
    end

    if (len(@Password_Employee) < 6 or not @Password_Employee like '%[a-zA-Z]%' or not @Password_Employee like '%[0-9]%' or not @Password_Employee like '%[!@#$%^&*()]%')
    begin
        print('Пароль должен содержать не менее 6 символов, включая буквы, цифры и специальные символы!');
        return;
    end

    update [dbo].[Employee]
    set Name_Employee = @Name_Employee,
        Surname_Employee = @Surname_Employee,
        Patronymic_Employee = @Patronymic_Employee,
        Login_Employee = @Login_Employee,
        Password_Employee = @Password_Employee
    where ID_Employee = @ID_Employee;
end
go

create or alter procedure [dbo].[Employee_delete]
@ID_Employee [int]
as
begin
    declare @any_child_record [int] = (select count(*) from [dbo].[Contract] where Employee_ID = @ID_Employee)
    if (@any_child_record > 0)
    begin
        print('Сотрудник не может быть удалён, так как в таблице "Contract", есть связанные данные!');
        return;
    end

    delete from [dbo].[Employee]
    where ID_Employee = @ID_Employee;
end
go





create or alter procedure [dbo].[Client_insert]
@Surname_Client [varchar](50),
@Name_Client [varchar](50),
@Patronymic_Client [varchar](50) = 'Нет данных',
@Insurance_Number_Client [varchar](19),
@Passport_Series_Client [varchar](5),
@Passport_Number_Client [varchar](6),
@Birth_Client [datetime],
@Gender_Client [varchar](3),
@Who_Issued_Passport_Client [varchar](max),
@When_Issued_Passport_Client [date],
@Division_Code_Passport_Client [varchar](7),
@Phone_Number_Client [varchar](16),
@Email_Client [varchar](255),
@Login_Client [varchar](255),
@Password_Client [varchar](36)
as
begin
    if (len(@Login_Client) < 6 or not @Login_Client like '%[a-zA-Z]%')
    begin
        print('Логин должен содержать не менее 6 символов и включать буквы!');
        return;
    end

    if (len(@Password_Client) < 6 or not @Password_Client like '%[a-zA-Z]%' or not @Password_Client like '%[0-9]%' or not @Password_Client like '%[!@#$%^&*()]%')
    begin
        print('Пароль должен содержать не менее 6 символов, включая буквы, цифры и специальные символы!');
        return;
    end

    if (@Insurance_Number_Client not like '[0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9]')
    begin
        print('Неверный формат номера страхового полиса!');
        return;
    end

    if (@Passport_Series_Client not like '[0-9][0-9] [0-9][0-9]')
    begin
        print('Неверный формат серии паспорта!');
        return;
    end

    if (@Passport_Number_Client not like '[0-9][0-9][0-9][0-9][0-9][0-9]')
    begin
        print('Неверный формат номера паспорта!');
        return;
    end

    if (@Birth_Client > dateadd(year, -17, getdate()))
    begin
        print('Клиент должен быть старше 17 лет!');
        return;
    end

    if (@Gender_Client not in ('Муж', 'Жен'))
    begin
        print('Пол клиента должен быть "Муж" или "Жен"!');
        return;
    end

    if (@When_Issued_Passport_Client < dateadd(year, -14, getdate()))
    begin
        print('Паспорт должен быть выдан не более 14 лет назад!');
        return;
    end

    if (@Division_Code_Passport_Client not like '[0-9][0-9][0-9]-[0-9][0-9][0-9]')
    begin
        print('Неверный формат кода подразделения!');
        return;
    end

    if (@Phone_Number_Client not like '+7([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
    begin
        print('Неверный формат номера телефона!');
        return;
    end

    if (@Email_Client not like '%_@__%.__%')
    begin
        print('Неверный формат email!');
        return;
    end

    insert into [dbo].[Client] (Surname_Client, Name_Client, Patronymic_Client, Insurance_Number_Client, Passport_Series_Client, Passport_Number_Client, Birth_Client, Gender_Client, Who_Issued_Passport_Client, When_Issued_Passport_Client, Division_Code_Passport_Client, Phone_Number_Client, Email_Client, Login_Client, Password_Client)
    values (@Surname_Client, @Name_Client, @Patronymic_Client, @Insurance_Number_Client, @Passport_Series_Client, @Passport_Number_Client, @Birth_Client, @Gender_Client, @Who_Issued_Passport_Client, @When_Issued_Passport_Client, @Division_Code_Passport_Client, @Phone_Number_Client, @Email_Client, @Login_Client, @Password_Client);
end
go


create or alter procedure [dbo].[Client_update]
@ID_Client [int],
@Surname_Client [varchar](50),
@Name_Client [varchar](50),
@Patronymic_Client [varchar](50) = 'Нет данных',
@Insurance_Number_Client [varchar](19),
@Passport_Series_Client [varchar](5),
@Passport_Number_Client [varchar](6),
@Birth_Client [datetime],
@Gender_Client [varchar](3),
@Who_Issued_Passport_Client [varchar](max),
@When_Issued_Passport_Client [date],
@Division_Code_Passport_Client [varchar](7),
@Phone_Number_Client [varchar](16),
@Email_Client [varchar](255),
@Login_Client [varchar](255),
@Password_Client [varchar](36)
as
begin
    if (len(@Login_Client) < 6 or not @Login_Client like '%[a-zA-Z]%')
    begin
        print('Логин должен содержать не менее 6 символов и включать буквы!');
        return;
    end

    if (len(@Password_Client) < 6 or not @Password_Client like '%[a-zA-Z]%' or not @Password_Client like '%[0-9]%' or not @Password_Client like '%[!@#$%^&*()]%')
    begin
        print('Пароль должен содержать не менее 6 символов, включая буквы, цифры и специальные символы!');
        return;
    end

    if (@Insurance_Number_Client not like '[0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9]')
    begin
        print('Неверный формат номера страхового полиса!');
        return;
    end

    if (@Passport_Series_Client not like '[0-9][0-9] [0-9][0-9]')
    begin
        print('Неверный формат серии паспорта!');
        return;
    end

    if (@Passport_Number_Client not like '[0-9][0-9][0-9][0-9][0-9][0-9]')
    begin
        print('Неверный формат номера паспорта!');
        return;
    end

    if (@Birth_Client > dateadd(year, -17, getdate()))
    begin
        print('Клиент должен быть старше 17 лет!');
        return;
    end

    if (@Gender_Client not in ('Муж', 'Жен'))
    begin
        print('Пол клиента должен быть "Муж" или "Жен"!');
        return;
    end

    if (@When_Issued_Passport_Client < dateadd(year, -14, getdate()))
    begin
        print('Паспорт должен быть выдан не более 14 лет назад!');
        return;
    end

    if (@Division_Code_Passport_Client not like '[0-9][0-9][0-9]-[0-9][0-9][0-9]')
    begin
        print('Неверный формат кода подразделения!');
        return;
    end

    if (@Phone_Number_Client not like '+7([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
    begin
        print('Неверный формат номера телефона!');
        return;
    end

    if (@Email_Client not like '%_@__%.__%')
    begin
        print('Неверный формат email!');
        return;
    end

    update [dbo].[Client]
    set Surname_Client = @Surname_Client,
        Name_Client = @Name_Client,
        Patronymic_Client = @Patronymic_Client,
        Insurance_Number_Client = @Insurance_Number_Client,
        Passport_Series_Client = @Passport_Series_Client,
        Passport_Number_Client = @Passport_Number_Client,
        Birth_Client = @Birth_Client,
        Gender_Client = @Gender_Client,
        Who_Issued_Passport_Client = @Who_Issued_Passport_Client,
        When_Issued_Passport_Client = @When_Issued_Passport_Client,
        Division_Code_Passport_Client = @Division_Code_Passport_Client,
        Phone_Number_Client = @Phone_Number_Client,
        Email_Client = @Email_Client,
        Login_Client = @Login_Client,
        Password_Client = @Password_Client
    where ID_Client = @ID_Client;
end
go


create or alter procedure [dbo].[Client_delete]
@ID_Client [int]
as
begin
    declare @any_child_record [int] = (select count(*) from [dbo].[Client_Contract] where Client_ID = @ID_Client)
    if (@any_child_record > 0)
    begin
        print('Клиент не может быть удалён, так как в таблице "Client_Contract", есть связанные данные!');
        return;
    end

    delete from [dbo].[Client]
    where ID_Client = @ID_Client;
end
go





create or alter procedure [dbo].[Map_insert]
@Name_Map [varchar](20),
@Square_Map [decimal](5,2),
@Length_Map [decimal](5,2),
@Width_Map [decimal](5,2),
@Plan_Map [varchar](max),
@Buildings_Map [varchar](max) = 'Отсутствует',
@Description_Map [varchar](max),
@Cost_Map [decimal](10,3)
as
begin
    if (@Square_Map <= 0)
    begin
        print('Площадь карты должна быть больше 0!');
        return;
    end

    if (@Length_Map <= 0)
    begin
        print('Длина карты должна быть больше 0!');
        return;
    end

    if (@Width_Map <= 0)
    begin
        print('Ширина карты должна быть больше 0!');
        return;
    end

    if (@Cost_Map < 0)
    begin
        print('Стоимость карты не может быть отрицательной!');
        return;
    end

    insert into [dbo].[Map] (Name_Map, Square_Map, Length_Map, Width_Map, Plan_Map, Buildings_Map, Description_Map, Cost_Map)
    values (@Name_Map, @Square_Map, @Length_Map, @Width_Map, @Plan_Map, @Buildings_Map, @Description_Map, @Cost_Map);
end
go



create or alter procedure [dbo].[Map_update]
@ID_Map [int],
@Name_Map [varchar](20),
@Square_Map [decimal](5,2),
@Length_Map [decimal](5,2),
@Width_Map [decimal](5,2),
@Plan_Map [varchar](max),
@Buildings_Map [varchar](max) = 'Отсутствует',
@Description_Map [varchar](max),
@Cost_Map [decimal](10,3)
as
begin
    if (@Square_Map <= 0)
    begin
        print('Площадь карты должна быть больше 0!');
        return;
    end
    if (@Length_Map <= 0)
    begin
        print('Длина карты должна быть больше 0!');
        return;
    end

    if (@Width_Map <= 0)
    begin
        print('Ширина карты должна быть больше 0!');
        return;
    end

    if (@Cost_Map < 0)
    begin
        print('Стоимость карты не может быть отрицательной!');
        return;
    end

    update [dbo].[Map]
    set Name_Map = @Name_Map,
        Square_Map = @Square_Map,
        Length_Map = @Length_Map,
        Width_Map = @Width_Map,
        Plan_Map = @Plan_Map,
        Buildings_Map = @Buildings_Map,
        Description_Map = @Description_Map,
        Cost_Map = @Cost_Map
    where ID_Map = @ID_Map;
end
go


create or alter procedure [dbo].[Map_delete]
@ID_Map [int]
as
begin
    declare @any_child_record [int] = (select count(*) from [dbo].[Contract] where Map_ID = @ID_Map)
    if (@any_child_record > 0)
    begin
        print('Карта не может быть удалена, так как в таблице "Contract", есть связанные данные!');
        return;
    end

    delete from [dbo].[Map]
    where ID_Map = @ID_Map;
end
go




create or alter procedure [dbo].[Game_Type_insert]
@Name_Game_Type [varchar](20),
@Cost_Game_Type [decimal](10,3),
@Description_Game_Type [varchar](max)
as
begin
    if (@Cost_Game_Type < 0)
    begin
        print('Стоимость типа игры не может быть отрицательной!');
        return;
    end

    insert into [dbo].[Game_Type] (Name_Game_Type, Cost_Game_Type, Description_Game_Type)
    values (@Name_Game_Type, @Cost_Game_Type, @Description_Game_Type);
end
go


create or alter procedure [dbo].[Game_Type_update]
@ID_Game_Type [int],
@Name_Game_Type [varchar](20),
@Cost_Game_Type [decimal](10,3),
@Description_Game_Type [varchar](max)
as
begin
    if (@Cost_Game_Type < 0)
    begin
        print('Стоимость типа игры не может быть отрицательной!');
        return;
    end

    update [dbo].[Game_Type]
    set Name_Game_Type = @Name_Game_Type,
        Cost_Game_Type = @Cost_Game_Type,
        Description_Game_Type = @Description_Game_Type
    where ID_Game_Type = @ID_Game_Type;
end
go


create or alter procedure [dbo].[Game_Type_delete]
@ID_Game_Type [int]
as
begin
    declare @any_child_record [int] = (select count(*) from [dbo].[Contract] where Game_Type_ID = @ID_Game_Type)
    if (@any_child_record > 0)
    begin
        print('Тип игры не может быть удален, так как в таблице "Contract", есть связанные данные!');
        return;
    end

    delete from [dbo].[Game_Type]
    where ID_Game_Type = @ID_Game_Type;
end
go




create or alter procedure [dbo].[Inventory_insert]
@Number_Inventory [varchar](16),
@Count_Inventory [int],
@Cost_Inventory [decimal](10,3)
as
begin
    if (@Number_Inventory not like 'ИнВ-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    begin
        print('Неверный формат номера инвентаря!');
        return;
    end

    if (@Count_Inventory < 0)
    begin
        print('Количество инвентаря не может быть отрицательным!');
        return;
    end

    if (@Cost_Inventory < 0)
    begin
        print('Стоимость инвентаря не может быть отрицательной!');
        return;
    end

    insert into [dbo].[Inventory] (Number_Inventory, Count_Inventory, Cost_Inventory)
    values (@Number_Inventory, @Count_Inventory, @Cost_Inventory);
end
go


create or alter procedure [dbo].[Inventory_update]
@ID_Inventory [int],
@Number_Inventory [varchar](16),
@Count_Inventory [int],
@Cost_Inventory [decimal](10,3)
as
begin
    if (@Number_Inventory not like 'ИнВ-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    begin
        print('Неверный формат номера инвентаря!');
        return;
    end

    if (@Count_Inventory < 0)
    begin
        print('Количество инвентаря не может быть отрицательным!');
        return;
    end

    if (@Cost_Inventory < 0)
    begin
        print('Стоимость инвентаря не может быть отрицательной!');
        return;
    end

    update [dbo].[Inventory]
    set Number_Inventory = @Number_Inventory,
        Count_Inventory = @Count_Inventory,
        Cost_Inventory = @Cost_Inventory
    where ID_Inventory = @ID_Inventory;
end
go


create or alter procedure [dbo].[Inventory_delete]
@ID_Inventory [int]
as
begin
    declare @any_child_record [int] = (select count(*) from [dbo].[Inventory_Contract] where Inventory_ID = @ID_Inventory)
    if (@any_child_record > 0)
    begin
        print('Инвентарь не может быть удален, так как в таблице "Inventory_Contract", есть связанные данные!');
        return;
    end

    delete from [dbo].[Inventory]
    where ID_Inventory = @ID_Inventory;
end
go


create or alter procedure [dbo].[Characteristic_insert]
@Value_Characteristic [varchar](50)
as
begin
    insert into [dbo].[Characteristic] (Value_Characteristic)
    values (@Value_Characteristic);
end
go


create or alter procedure [dbo].[Characteristic_update]
@ID_Characteristic [int],
@Value_Characteristic [varchar](50)
as
begin
    update [dbo].[Characteristic]
    set Value_Characteristic = @Value_Characteristic
    where ID_Characteristic = @ID_Characteristic;
end
go


create or alter procedure [dbo].[Characteristic_delete]
@ID_Characteristic [int]
as
begin
    declare @any_child_record [int] = (select count(*) from [dbo].[Inventory_Characteristic] where Characteristic_ID = @ID_Characteristic)
    if (@any_child_record > 0)
    begin
        print('Характеристика не может быть удалена, так как в таблице "Inventory_Characteristic", есть связанные данные!');
        return;
    end

    delete from [dbo].[Characteristic]
    where ID_Characteristic = @ID_Characteristic;
end
go

create or alter procedure [dbo].[Contract_insert]
@Employee_ID [int],
@Game_Type_ID [int],
@Map_ID [int],
@Number_Contract [varchar](10),
@Cost_Contract [decimal](10,3),
@DateTime_Forming_Contract [datetime],
@Game_Duration_Contract [decimal](5,2),
@Game_Start_Time_Contract [time],
@Game_End_Time_Contract [time],
@Final_Cost_Contract [decimal](10,3)
as
begin
    if (@Number_Contract not like 'GM-[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    begin
        print('Неверный формат номера контракта!');
        return;
    end

    if (@Cost_Contract < 0)
    begin
        print('Стоимость контракта не может быть отрицательной!');
        return;
    end

    if (@Game_Duration_Contract < 0)
    begin
        print('Продолжительность игры не может быть отрицательной!');
        return;
    end

    if (@Game_Start_Time_Contract > @Game_End_Time_Contract)
    begin
        print('Время начала игры не может быть позже времени окончания игры!');
        return;
    end

    if (@Final_Cost_Contract <= 0)
    begin
        print('Итоговая стоимость контракта должна быть больше 0!');
        return;
    end

    insert into [dbo].[Contract] (Employee_ID, Game_Type_ID, Map_ID, Number_Contract, Cost_Contract, DateTime_Forming_Contract, Game_Duration_Contract, Game_Start_Time_Contract, Game_End_Time_Contract, Final_Cost_Contract)
    values (@Employee_ID, @Game_Type_ID, @Map_ID, @Number_Contract, @Cost_Contract, @DateTime_Forming_Contract, @Game_Duration_Contract, @Game_Start_Time_Contract, @Game_End_Time_Contract, @Final_Cost_Contract);
end
go



create or alter procedure [dbo].[Contract_update]
@ID_Contract [int],
@Employee_ID [int],
@Game_Type_ID [int],
@Map_ID [int],
@Number_Contract [varchar](10),
@Cost_Contract [decimal](10,3),
@DateTime_Forming_Contract [datetime],
@Game_Duration_Contract [decimal](5,2),
@Game_Start_Time_Contract [time],
@Game_End_Time_Contract [time],
@Final_Cost_Contract [decimal](10,3)
as
begin
    if (@Number_Contract not like 'GM-[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    begin
        print('Неверный формат номера контракта!');
        return;
    end

    if (@Cost_Contract < 0)
    begin
        print('Стоимость контракта не может быть отрицательной!');
        return;
    end

    if (@Game_Duration_Contract < 0)
    begin
        print('Продолжительность игры не может быть отрицательной!');
        return;
    end

    if (@Game_Start_Time_Contract > @Game_End_Time_Contract)
    begin
        print('Время начала игры не может быть позже времени окончания игры!');
        return;
    end

    if (@Final_Cost_Contract <= 0)
    begin
        print('Итоговая стоимость контракта должна быть больше 0!');
        return;
    end

    update [dbo].[Contract]
    set Employee_ID = @Employee_ID,
        Game_Type_ID = @Game_Type_ID,
        Map_ID = @Map_ID,
        Number_Contract = @Number_Contract,
        Cost_Contract = @Cost_Contract,
        DateTime_Forming_Contract = @DateTime_Forming_Contract,
        Game_Duration_Contract = @Game_Duration_Contract,
        Game_Start_Time_Contract = @Game_Start_Time_Contract,
        Game_End_Time_Contract = @Game_End_Time_Contract,
        Final_Cost_Contract = @Final_Cost_Contract
    where ID_Contract = @ID_Contract;
end
go


create or alter procedure [dbo].[Contract_delete]
@ID_Contract [int]
as
begin
    declare @any_child_record [int] = (select count(*) from [dbo].[Client_Contract] where Contract_ID = @ID_Contract)
    if (@any_child_record > 0)
    begin
        print('Контракт не может быть удален, так как в таблице "Client_Contract", есть связанные данные!');
        return;
    end

    delete from [dbo].[Contract]
    where ID_Contract = @ID_Contract;
end
go



create or alter procedure [dbo].[Player_Type_insert]
@Name_Player_Type [varchar](20)
as
begin
    if (@Name_Player_Type not in ('Ответственный', 'Участник'))
    begin
        print('Тип игрока должен быть "Ответственный" или "Участник"!');
        return;
    end

    insert into [dbo].[Player_Type] (Name_Player_Type)
    values (@Name_Player_Type);
end
go


create or alter procedure [dbo].[Player_Type_delete]
@ID_Player_Type [int]
as
begin
    declare @any_child_record [int] = (select count(*) from [dbo].[Client_Contract] where Player_Type_ID = @ID_Player_Type)
    if (@any_child_record > 0)
    begin
        print('Тип игрока не может быть удален, так как в таблице "Client_Contract", есть связанные данные!');
        return;
    end

    delete from [dbo].[Player_Type]
    where ID_Player_Type = @ID_Player_Type;
end
go


create or alter procedure [dbo].[Client_Contract_insert]
@Contract_ID [int],
@Client_ID [int],
@Player_Type_ID [int]
as
begin
        insert into [dbo].[Client_Contract] (Contract_ID, Client_ID, Player_Type_ID)
    values (@Contract_ID, @Client_ID, @Player_Type_ID);
end
go


create or alter procedure [dbo].[Client_Contract_update]
@ID_Client_Contract [int],
@Contract_ID [int],
@Client_ID [int],
@Player_Type_ID [int]
as
begin
    update [dbo].[Client_Contract]
    set Contract_ID = @Contract_ID,
        Client_ID = @Client_ID,
        Player_Type_ID = @Player_Type_ID
    where ID_Client_Contract = @ID_Client_Contract;
end
go


create or alter procedure [dbo].[Client_Contract_delete]
@ID_Client_Contract [int]
as
begin
    delete from [dbo].[Client_Contract]
    where ID_Client_Contract = @ID_Client_Contract;
end
go




create or alter procedure [dbo].[Inventory_Characteristic_insert]
@Inventory_ID [int],
@Characteristic_ID [int]
as
begin
    insert into [dbo].[Inventory_Characteristic] (Inventory_ID, Characteristic_ID)
    values (@Inventory_ID, @Characteristic_ID);
end
go


create or alter procedure [dbo].[Inventory_Characteristic_update]
@ID_Inventory_Characteristic [int],
@Inventory_ID [int],
@Characteristic_ID [int]
as
begin
    update [dbo].[Inventory_Characteristic]
    set Inventory_ID = @Inventory_ID,
        Characteristic_ID = @Characteristic_ID
    where ID_Inventory_Characteristic = @ID_Inventory_Characteristic;
end
go

create or alter procedure [dbo].[Inventory_Characteristic_delete]
@ID_Inventory_Characteristic [int]
as
begin
    delete from [dbo].[Inventory_Characteristic]
    where ID_Inventory_Characteristic = @ID_Inventory_Characteristic;
end
go


create or alter procedure [dbo].[Inventory_Contract_insert]
@Inventory_ID [int],
@Contract_ID [int]
as
begin
    insert into [dbo].[Inventory_Contract] (Inventory_ID, Contract_ID)
    values (@Inventory_ID, @Contract_ID);
end
go

create or alter procedure [dbo].[Inventory_Contract_update]
@ID_Inventory_Contract [int],
@Inventory_ID [int],
@Contract_ID [int]
as
begin
    update [dbo].[Inventory_Contract]
    set Inventory_ID = @Inventory_ID,
        Contract_ID = @Contract_ID
    where ID_Inventory_Contract = @ID_Inventory_Contract;
end
go


create or alter procedure [dbo].[Inventory_Contract_delete]
@ID_Inventory_Contract [int]
as
begin
    delete from [dbo].[Inventory_Contract]
    where ID_Inventory_Contract = @ID_Inventory_Contract;
end
go


create or alter procedure [dbo].[Additional_Client_Contract_insert]
@Number_Additional_Contract [varchar](12),
@Client_Contract_ID [int]
as
begin
    if (@Number_Additional_Contract not like 'GM-[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9]')
    begin
        print('Неверный формат номера дополнительного контракта!');
        return;
    end

    insert into [dbo].[Additional_Client_Contract] (Number_Additional_Contract, Client_Contract_ID)
    values (@Number_Additional_Contract, @Client_Contract_ID);
end
go



create or alter procedure [dbo].[Additional_Client_Contract_update]
@ID_Additional_Client_Contract [int],
@Number_Additional_Contract [varchar](12),
@Client_Contract_ID [int]
as
begin
    if (@Number_Additional_Contract not like 'GM-[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9]')
    begin
        print('Неверный формат номера дополнительного контракта!');
        return;
    end

    update [dbo].[Additional_Client_Contract]
    set Number_Additional_Contract = @Number_Additional_Contract,
        Client_Contract_ID = @Client_Contract_ID
    where ID_Additional_Client_Contract = @ID_Additional_Client_Contract;
end
go


create or alter procedure [dbo].[Additional_Client_Contract_delete]
@ID_Additional_Client_Contract [int]
as
begin
    delete from [dbo].[Additional_Client_Contract]
    where ID_Additional_Client_Contract = @ID_Additional_Client_Contract;
end
go


create or alter procedure [dbo].[Armor_Type_insert]
@Inventory_ID [int],
@Name_Armor_Type [varchar](15)
as
begin
    insert into [dbo].[Armor_Type] (Inventory_ID, Name_Armor_Type)
    values (@Inventory_ID, @Name_Armor_Type);
end
go

create or alter procedure [dbo].[Armor_Type_update]
@ID_Armor_Type [int],
@Inventory_ID [int],
@Name_Armor_Type [varchar](15)
as
begin
    update [dbo].[Armor_Type]
    set Inventory_ID = @Inventory_ID,
        Name_Armor_Type = @Name_Armor_Type
    where ID_Armor_Type = @ID_Armor_Type;
end
go


create or alter procedure [dbo].[Armor_Type_delete]
@ID_Armor_Type [int]
as
begin
    delete from [dbo].[Armor_Type]
    where ID_Armor_Type = @ID_Armor_Type;
end
go


create or alter procedure [dbo].[Additional_Inventory_insert]
@Name_Additional_Inventory [varchar](30),
@Count_Additional_Inventory [int],
@Cost_Additional_Inventory [decimal](10,3),
@Contract_ID [int]
as
begin
    if (@Count_Additional_Inventory < 0)
    begin
        print('Количество дополнительного инвентаря не может быть отрицательным!');
        return;
    end

    if (@Cost_Additional_Inventory < 0)
    begin
        print('Стоимость дополнительного инвентаря не может быть отрицательной!');
        return;
    end

    insert into [dbo].[Additional_Inventory] (Name_Additional_Inventory, Count_Additional_Inventory, Cost_Additional_Inventory, Contract_ID)
    values (@Name_Additional_Inventory, @Count_Additional_Inventory, @Cost_Additional_Inventory, @Contract_ID);
end
go


create or alter procedure [dbo].[Additional_Inventory_update]
@ID_Additional_Inventory [int],
@Name_Additional_Inventory [varchar](30),
@Count_Additional_Inventory [int],
@Cost_Additional_Inventory [decimal](10,3),
@Contract_ID [int]
as
begin
    if (@Count_Additional_Inventory < 0)
    begin
        print('Количество дополнительного инвентаря не может быть отрицательным!');
        return;
    end

    if (@Cost_Additional_Inventory < 0)
    begin
        print('Стоимость дополнительного инвентаря не может быть отрицательной!');
        return;
    end

    update [dbo].[Additional_Inventory]
    set Name_Additional_Inventory = @Name_Additional_Inventory,
        Count_Additional_Inventory = @Count_Additional_Inventory,
        Cost_Additional_Inventory = @Cost_Additional_Inventory,
        Contract_ID = @Contract_ID
    where ID_Additional_Inventory = @ID_Additional_Inventory;
end
go


create or alter procedure [dbo].[Additional_Inventory_delete]
@ID_Additional_Inventory [int]
as
begin
    delete from [dbo].[Additional_Inventory]
    where ID_Additional_Inventory = @ID_Additional_Inventory;
end
go

create or alter procedure [dbo].[Mark_insert]
@Name_Mark [varchar](15)
as
begin
    insert into [dbo].[Mark] (Name_Mark)
    values (@Name_Mark);
end
go

create or alter procedure [dbo].[Mark_update]
@ID_Mark [int],
@Name_Mark [varchar](15)
as
begin
    update [dbo].[Mark]
    set Name_Mark = @Name_Mark
    where ID_Mark = @ID_Mark;
end
go

create or alter procedure [dbo].[Mark_delete]
@ID_Mark [int]
as
begin
    declare @any_child_record [int] = (select count(*) from [dbo].[Model] where Mark_ID = @ID_Mark)
    if (@any_child_record > 0)
    begin
        print('Марка не может быть удалена, так как в таблице "Model", есть связанные данные!');
        return;
    end

    delete from [dbo].[Mark]
    where ID_Mark = @ID_Mark;
end
go


create or alter procedure [dbo].[Model_insert]
@Name_Model [varchar](15),
@Mark_ID [int]
as
begin
    insert into [dbo].[Model] (Name_Model, Mark_ID)
    values (@Name_Model, @Mark_ID);
end
go


create or alter procedure [dbo].[Model_update]
@ID_Model [int],
@Name_Model [varchar](15),
@Mark_ID [int]
as
begin
    update [dbo].[Model]
    set Name_Model = @Name_Model,
        Mark_ID = @Mark_ID
    where ID_Model = @ID_Model;
end
go

create or alter procedure [dbo].[Model_delete]
@ID_Model [int]
as
begin
    declare @any_child_record [int] = (select count(*) from [dbo].[Mark_Model_Inventory] where Model_ID = @ID_Model)
    if (@any_child_record > 0)
    begin
        print('Модель не может быть удалена, так как в таблице "Mark_Model_Inventory", есть связанные данные!');
        return;
    end

    delete from [dbo].[Model]
    where ID_Model = @ID_Model;
end
go

create or alter procedure [dbo].[Mark_Model_Inventory_insert]
@Inventory_ID [int],
@Model_ID [int]
as
begin
    insert into [dbo].[Mark_Model_Inventory] (Inventory_ID, Model_ID)
    values (@Inventory_ID, @Model_ID);
end
go

create or alter procedure [dbo].[Mark_Model_Inventory_update]
@ID_Mark_Model_Inventory [int],
@Inventory_ID [int],
@Model_ID [int]
as
begin
    update [dbo].[Mark_Model_Inventory]
    set Inventory_ID = @Inventory_ID,
        Model_ID = @Model_ID
    where ID_Mark_Model_Inventory = @ID_Mark_Model_Inventory;
end
go


create or alter procedure [dbo].[Mark_Model_Inventory_delete]
@ID_Mark_Model_Inventory [int]
as
begin
    delete from [dbo].[Mark_Model_Inventory]
    where ID_Mark_Model_Inventory = @ID_Mark_Model_Inventory;
end
go

create or alter procedure [dbo].[Suppliers_insert]
@Name_Suppliers [varchar](50),
@OKPO_Suppliers [varchar](10),
@Legal_Address_Suppliers [varchar](max),
@Physical_Address_Suppliers [varchar](max),
@Phone_Number_Suppliers [varchar](16)
as
begin
    if (@OKPO_Suppliers not like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    begin
        print('Неверный формат ОКПО!');
        return;
    end

    if (@Phone_Number_Suppliers not like '+7([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
    begin
        print('Неверный формат номера телефона!');
        return;
    end

    insert into [dbo].[Suppliers] (Name_Suppliers, OKPO_Suppliers, Legal_Address_Suppliers, Physical_Address_Suppliers, Phone_Number_Suppliers)
    values (@Name_Suppliers, @OKPO_Suppliers, @Legal_Address_Suppliers, @Physical_Address_Suppliers, @Phone_Number_Suppliers);
end
go

create or alter procedure [dbo].[Suppliers_update]
@ID_Supplier [int],
@Name_Suppliers [varchar](50),
@OKPO_Suppliers [varchar](10),
@Legal_Address_Suppliers [varchar](max),
@Physical_Address_Suppliers [varchar](max),
@Phone_Number_Suppliers [varchar](16)
as
begin
    if (@OKPO_Suppliers not like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    begin
        print('Неверный формат ОКПО!');
        return;
   end

    if (@Phone_Number_Suppliers not like '+7([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
    begin
        print('Неверный формат номера телефона!');
        return;
    end

    update [dbo].[Suppliers]
    set Name_Suppliers = @Name_Suppliers,
        OKPO_Suppliers = @OKPO_Suppliers,
        Legal_Address_Suppliers = @Legal_Address_Suppliers,
        Physical_Address_Suppliers = @Physical_Address_Suppliers,
        Phone_Number_Suppliers = @Phone_Number_Suppliers
    where ID_Supplier = @ID_Supplier;
end
go


create or alter procedure [dbo].[Suppliers_delete]
@ID_Supplier [int]
as
begin
    declare @any_child_record [int] = (select count(*) from [dbo].[Supplier_Contracts] where Supplier_ID = @ID_Supplier)
    if (@any_child_record > 0)
    begin
        print('Поставщик не может быть удален, так как в таблице "Supplier_Contracts", есть связанные данные!');
        return;
    end

    delete from [dbo].[Suppliers]
    where ID_Supplier = @ID_Supplier;
end
go

create or alter procedure [dbo].[Order_Status_insert]
@Status_Order_Status [varchar](8)
as
begin
    if (@Status_Order_Status not in ('открыт', 'завершён'))
    begin
        print('Статус заказа должен быть "открыт" или "завершён"!');
        return;
    end

    insert into [dbo].[Order_Status] (Status_Order_Status)
    values (@Status_Order_Status);
end
go


create or alter procedure [dbo].[Order_Status_delete]
@ID_Order_Status [int]
as
begin
    declare @any_child_record [int] = (select count(*) from [dbo].[Supplier_Contracts] where Order_Status_ID = @ID_Order_Status)
    if (@any_child_record > 0)
    begin
        print('Статус заказа не может быть удален, так как в таблице "Supplier_Contracts", есть связанные данные!');
        return;
    end

    delete from [dbo].[Order_Status]
    where ID_Order_Status = @ID_Order_Status;
end
go


create or alter procedure [dbo].[Supplier_Contracts_insert]
@Supplier_ID [int],
@Contract_Number_Supplier_Contracts [varchar](17),
@Date_Of_Formation_Supplier_Contracts [datetime],
@Validity_Period_Supplier_Contracts [varchar](30),
@Order_Status_ID [int]
as
begin
    if (@Contract_Number_Supplier_Contracts not like 'Д-П/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9]')
    begin
        print('Неверный формат номера контракта поставщика!');
        return;
    end

    if (@Date_Of_Formation_Supplier_Contracts > getdate())
    begin
        print('Дата формирования контракта не может быть в будущем!');
        return;
    end

    if (@Validity_Period_Supplier_Contracts not like '%[0-9]%')
    begin
        print('Срок действия контракта должен содержать цифры!');
        return;
    end

    insert into [dbo].[Supplier_Contracts] (Supplier_ID, Contract_Number_Supplier_Contracts, Date_Of_Formation_Supplier_Contracts, Validity_Period_Supplier_Contracts, Order_Status_ID)
    values (@Supplier_ID, @Contract_Number_Supplier_Contracts, @Date_Of_Formation_Supplier_Contracts, @Validity_Period_Supplier_Contracts, @Order_Status_ID);
end
go


create or alter procedure [dbo].[Supplier_Contracts_update]
@ID_Supplier_Contracts [int],
@Supplier_ID [int],
@Contract_Number_Supplier_Contracts [varchar](17),
@Date_Of_Formation_Supplier_Contracts [datetime],
@Validity_Period_Supplier_Contracts [varchar](30),
@Order_Status_ID [int]
as
begin
    if (@Contract_Number_Supplier_Contracts not like 'Д-П/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9]')
    begin
        print('Неверный формат номера контракта поставщика!');
        return;
    end

    if (@Date_Of_Formation_Supplier_Contracts > getdate())
    begin
        print('Дата формирования контракта не может быть в будущем!');
        return;
    end

    if (@Validity_Period_Supplier_Contracts not like '%[0-9]%')
    begin
        print('Срок действия контракта должен содержать цифры!');
        return;
    end

    update [dbo].[Supplier_Contracts]
    set Supplier_ID = @Supplier_ID,
        Contract_Number_Supplier_Contracts = @Contract_Number_Supplier_Contracts,
        Date_Of_Formation_Supplier_Contracts = @Date_Of_Formation_Supplier_Contracts,
        Validity_Period_Supplier_Contracts = @Validity_Period_Supplier_Contracts,
        Order_Status_ID = @Order_Status_ID
    where ID_Supplier_Contracts = @ID_Supplier_Contracts;
end
go

create or alter procedure [dbo].[Supplier_Contracts_delete]
@ID_Supplier_Contracts [int]
as
begin
    declare @any_child_record [int] = (select count(*) from [dbo].[Inventory_Supplier_Contracts] where Supplier_Contracts_ID = @ID_Supplier_Contracts)
    if (@any_child_record > 0)
    begin
        print('Контракт поставщика не может быть удален, так как в таблице "Inventory_Supplier_Contracts", есть связанные данные!');
        return;
    end

    delete from [dbo].[Supplier_Contracts]
    where ID_Supplier_Contracts = @ID_Supplier_Contracts;
end
go




create or alter procedure [dbo].[Inventory_Supplier_Contracts_insert]
@Inventory_ID [int],
@Supplier_Contracts_ID [int],
@Count_Inventory_Supplier_Contracts [int]
as
begin
    if (@Count_Inventory_Supplier_Contracts <= 0)
    begin
        print('Количество инвентаря должно быть больше 0!');
        return;
    end

    insert into [dbo].[Inventory_Supplier_Contracts] (Inventory_ID, Supplier_Contracts_ID, Count_Inventory_Supplier_Contracts)
    values (@Inventory_ID, @Supplier_Contracts_ID, @Count_Inventory_Supplier_Contracts);
end
go


create or alter procedure [dbo].[Inventory_Supplier_Contracts_update]
@ID_Inventory_Supplier_Contracts [int],
@Inventory_ID [int],
@Supplier_Contracts_ID [int],
@Count_Inventory_Supplier_Contracts [int]
as
begin
    if (@Count_Inventory_Supplier_Contracts <= 0)
    begin
        print('Количество инвентаря должно быть больше 0!');
        return;
    end

    update [dbo].[Inventory_Supplier_Contracts]
    set Inventory_ID = @Inventory_ID,
        Supplier_Contracts_ID = @Supplier_Contracts_ID,
        Count_Inventory_Supplier_Contracts = @Count_Inventory_Supplier_Contracts
    where ID_Inventory_Supplier_Contracts = @ID_Inventory_Supplier_Contracts;
end
go


create or alter procedure [dbo].[Inventory_Supplier_Contracts_delete]
@ID_Inventory_Supplier_Contracts [int]
as
begin
    delete from [dbo].[Inventory_Supplier_Contracts]
    where ID_Inventory_Supplier_Contracts = @ID_Inventory_Supplier_Contracts;
end
go

