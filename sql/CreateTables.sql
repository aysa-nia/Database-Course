USE FinalPhase

CREATE TABLE _User
(
	_NAME VARCHAR (50) NULL,
	LastName VARCHAR (50) NULL,
	City VARCHAR (50) NOT NULL,
	Email VARCHAR (150) NULL UNIQUE,
	_Password CHAR (13) NOT NULL UNIQUE,
	SSN CHAR (10) NOT NULL,
	PhoneNumber CHAR (11) NULL,
	PRIMARY KEY (SSN),
	CONSTRAINT CHK_Email CHECK (Email like '%_@__%.__%'),
	CONSTRAINT CHK_SSN CHECK (SSN LIKE '%[0-9]%'),
	CONSTRAINT CHK_Phone CHECK (PhoneNumber LIKE '%[0-9]%'),
);

CREATE TABLE Customer
(
	SSN CHAR (10) NOT NULL,
	PRIMARY KEY (SSN),
	-- CustomerID VARCHAR (10),
	-- PRIMARY KEY (SSN, CustomerID),
	FOREIGN KEY (SSN) REFERENCES _User (SSN) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE Agent
(
	SSN CHAR (10) NOT NULL,
	PRIMARY KEY (SSN),
	-- AgentID VARCHAR (10),
	AgencyCode INT NOT NULL,
	-- PRIMARY KEY (SSN, AgentID),
	FOREIGN KEY (SSN) REFERENCES _User (SSN) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (AgencyCode) REFERENCES Agency (Code),
);

CREATE TABLE _Owner
(
	SSN CHAR (10) NOT NULL,
	PRIMARY KEY (SSN),
	-- OwnerID VARCHAR (10),
	-- PRIMARY KEY (SSN, OwnerID),
	FOREIGN KEY (SSN) REFERENCES _User (SSN) ON DELETE CASCADE ON UPDATE CASCADE,
);


CREATE TABLE Agency
(
	Code INT NOT NULL,
	_Name VARCHAR (50) NULL,
	City VARCHAR (50) NOT NULL,
	Neighborhood VARCHAR (50) NOT NULL,
	PRIMARY KEY (Code),
);

CREATE TABLE Comment -- it is a weak entity
(
	CommentID INT NOT NULL UNIQUE,
	UserID CHAR (10) NOT NULL,
	Content VARCHAR (255) NOT NULL,
	AdvertismentID INT NOT NULL,
	PRIMARY KEY (CommentID, UserID),
	CreationDate DATETIME DEFAULT (getdate()),
	FOREIGN KEY (UserID) REFERENCES _User (SSN) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (AdvertismentID) REFERENCES Advertisment (AdvertismentID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Rate -- average (derived attribute) must be added
					-- it is a weak entity
(
	RateID INT NOT NULL IDENTITY(1, 1),
	NumericalRate float NOT NULL,
	UserID CHAR (10) NOT NULL,
	AgencyID INT NOT NULL,
	PRIMARY KEY (RateID, UserID),
	FOREIGN KEY (UserID) REFERENCES _User (SSN) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (AgencyID) REFERENCES Agency (Code) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT CHK_RATE CHECK (NumericalRate > 0 AND NumericalRate < 6),
);

CREATE TABLE AgentCustomerCooperate
(
	CustomerID CHAR (10),
	AgentID CHAR (10),
	PRIMARY KEY (CustomerID, AgentID),
	FOREIGN KEY (CustomerID) REFERENCES Customer (SSN) ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (AgentID) REFERENCES Agent (SSN) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE AgentOwnerCooperate
(
	AgentID CHAR (10),
	OwnerID CHAR (10),
	PRIMARY KEY (OwnerID, AgentID),
	FOREIGN KEY (OwnerID) REFERENCES _Owner (SSN) ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (AgentID) REFERENCES Agent (SSN) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Advertisment -- check for status?
(
	AdvertismentID INT NOT NULL,
	AgentID CHAR (10) NOT NULL,
	_Type VARCHAR (10) NOT NULL,
	_Status VARCHAR (10) NOT NULL,
	Title VARCHAR (20) NOT NULL,
	PropertyID INT NOT NULL,
	PRIMARY KEY (AdvertismentID),
	FOREIGN KEY (PropertyID) REFERENCES Property (RegistrationPlate) ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (AgentID) REFERENCES Agent (SSN) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT CHK_Type CHECK (_Type = 'sell' OR _Type = 'rent') 
);

CREATE TABLE BookMarkAds
(
	AdvertismentID INT NOT NULL,
	CustomerID CHAR (10) NOT NULL,
	PRIMARY KEY (AdvertismentID, CustomerID),
	FOREIGN KEY (AdvertismentID) REFERENCES Advertisment (AdvertismentID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (CustomerID) REFERENCES Customer (SSN) ON DELETE CASCADE ON UPDATE CASCADE,

);

CREATE TABLE BookMarkAgents
(
	AgentID CHAR (10) NOT NULL,
	OwnerID CHAR (10) NOT NULL,
	PRIMARY KEY (AgentID, OwnerID),
	FOREIGN KEY (AgentID) REFERENCES Agent (SSN) ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (OwnerID) REFERENCES _Owner (SSN) ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE Property -- check for document type?
(
	RegistrationPlate INT NOT NULL,
	Price INT NULL,
	City VARCHAR (50) NOT NULL,
	Neighborhood VARCHAR (50) NOT NULL,
	DocumentType VARCHAR (20) NULL,
	OwnerID CHAR (10) NOT NULL,
	PRIMARY KEY (RegistrationPlate),
	FOREIGN KEY (OwnerID) REFERENCES _Owner (SSN) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE House
(
	RegistrationPlate INT NOT NULL,
	-- HouseID INT NOT NULL,
	Area FLOAT NULL,
	#Bedrooms INT,
	HasStoreroomOrNot BIT NOT NULL,
	HeatingType VARCHAR (20),
	CoolingType VARCHAR (20),
	PRIMARY KEY (RegistrationPlate),
	FOREIGN KEY (RegistrationPlate) REFERENCES Property (RegistrationPlate) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Apartment
(
	RegistrationPlate INT NOT NULL,
	-- ApartmentID INT NOT NULL,
	Area FLOAT NULL,
	#Bedrooms INT,
	HasStoreroomOrNot BIT NOT NULL,
	HeatingType VARCHAR (20),
	CoolingType VARCHAR (20),
	PRIMARY KEY (RegistrationPlate),
	FOREIGN KEY (RegistrationPlate) REFERENCES Property (RegistrationPlate) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Land
(
	RegistrationPlate INT NOT NULL,
	-- LandID INT NOT NULL,
	Area FLOAT NULL,
	TypeOfUse VARCHAR (20),
	PRIMARY KEY (RegistrationPlate),
	FOREIGN KEY (RegistrationPlate) REFERENCES Property (RegistrationPlate) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT CHK_TypeOfUse CHECK (TypeOfUse = 'recreational' OR TypeOfUse = 'transport' OR TypeOfUse = 'agricultural' OR TypeO_fUse = 'residential and commercial'),
);
 alter table Advertisment
 ADD CONSTRAINT status_type CHECK(_Status = 'inprogress' or _Status = 'finished');
alter table Property
	ADD constraint Check_DocumantType check(DocumentType = 'Gholname' or DocumentType = 'mangoledar');
alter table _User
	add constraint Password_length check(Len(_Password) = 13);
alter table _User
	add constraint SSN_Length check(Len(SSN) = 10)
alter table _User
	drop constraint SSN_Length
alter table _User
	add constraint SSN_Length check(Len(SSN) = 10)
alter table _User
	add constraint PhoneNumber_length check(Len(PhoneNumber) = 11)
alter table Agent
	add NumOfFinshedAdvertisment INT default 0;
alter table Apartment
	add HasParkingOrNot bit
alter table Apartment
	add HasElevatorOrNot bit
alter table comment
	add PropertyID int

alter trigger CHECK_STATUS on Advertisment
	after update
	as
	begin
	   set nocount on;
	   declare @Ad_id INT , @P_id INT , @num INT , @AgentSSN char(10);
	   select @num = Agent.NumOfFinshedAdvertisment + 1 , @AgentSSN = i.AgentID
	   from Agent , inserted i
	   where Agent.SSN = i.AgentID
	   select @Ad_id = i.AdvertismentID , @P_id = i.PropertyID
	   from inserted i 
	   update Agent set NumOfFinshedAdvertisment = @num where Agent.SSN = @AgentSSN;
	    delete from Advertisment where Advertisment.AdvertismentID = @Ad_id  and Advertisment.PropertyID = @P_id;
	end
	go
create trigger CHECK_AGENT_COUNT on Advertisment
	for insert
	as 
	begin
		set nocount on;
		declare @agent_count INT ;
		select @agent_count = Count(A.AgentID)
		from Advertisment as A , inserted i
		where A.AgentID = i.AgentID;
		if @agent_count > 3 
			BEGIN
			RAISERROR ('You can not add more than 3 Advertisment for same Agent' ,10,1)
			ROLLBACK TRANSACTION
			end
	end
	go
create View Apartment_in_tehran 
	AS select Apartment.* , _User._NAME as Agent_Name , _User.LastName as Agent_LastName , _User.PhoneNumber as Agent_PhoneNumber 
	from Apartment , Property , AgentOwnerCooperate , Agent , _User
	where   Apartment.RegistrationPlate = Property.RegistrationPlate and Property.City = 'Tehran' and  Property.OwnerID = AgentOwnerCooperate.OwnerID and
			AgentOwnerCooperate.AgentID = Agent.SSN and Agent.SSN = _User.SSN;

create view Agency_with_agents_in_Tehran
	as select Agency.* , _User._NAME as Agent_Name , _User.LastName as Agent_LastName , _User.PhoneNumber as Agent_PhoneNumber 
	from agency , agent , _User
	where Agency.City = 'Tehran' and Agent.AgencyCode = Agency.Code and Agent.SSN = _User.SSN

create procedure Apartment_with_N_Rooms @RoomsNo INT
	as
	select Apartment.*
	from Apartment 
	where Apartment.#Bedrooms = @RoomsNo
create procedure Agencies_Location @city varchar(50) , @Neighborhood varchar(50)
	as
	select Agency.* , _User._NAME as Agent_Name , _User.LastName as Agent_LastName , _User.PhoneNumber as Agent_PhoneNumber 
	from Agency , Agent , _User
	where Agency.City = @city and Agency.Neighborhood = @Neighborhood and Agency.Code = Agent.AgencyCode and _User.SSN = Agent.SSN

EXEC Apartment_with_N_Rooms @RoomsNo = 2;
Exec Agencies_Location @city= 'Tehran' , @Neighborhood = 'TehranPars'

create function Agency_average_rate (@AgencyCode INT)
	returns float
	begin
	declare @result float
	select @result = AVG(Rate.NumericalRate)
	from Rate
	where Rate.AgencyID = @AgencyCode
	return @result;
	end
declare @AverageRate float
Exec @AverageRate =  Agency_average_rate @AgencyCode = 1
print(@AverageRate)

create function Count_of_FinishedAdvertisment_of_Agency(@AgencyCode INT)
	returns INT
	begin
	declare @result INT
	select @result = SUM(agent.NumOfFinshedAdvertisment)
	from Agency , Agent
	where Agency.Code = @AgencyCode and Agent.AgencyCode = @AgencyCode
	return @result
	end

declare @CountOf INT
Exec @CountOf =  Count_of_FinishedAdvertisment_of_Agency @AgencyCode = 1
print(@CountOf)
---------------------------------------------------------------------------------------------------------------
Insert into _User(_NAME , LastName , City , Email , _Password ,SSN ,PhoneNumber)
values('Roya' , 'Omrani' , 'Tehran' , 'RO@gmail.com' , '1234567891011' , '4545454545' , '78787878787');
Insert into _User(_NAME , LastName , City , Email , _Password ,SSN ,PhoneNumber)
values('Reza' , 'Baghyi' , 'Tehran' , 'RB@gmail.com' , '4563333998745' , '5632326565' , '74125896336');
Insert into _User(_NAME , LastName , City , Email , _Password ,SSN ,PhoneNumber)
values('Farnaz' , 'Rezayi' , 'Tehran' , 'FR@gmail.com' , '7411474114741' , '4545789545' , '78787841287');
Insert into _User(_NAME , LastName , City , Email , _Password ,SSN ,PhoneNumber)
values('Bagher' , 'Bagheri' , 'Tehran' , 'BB@gmail.com' , '1234562221011' , '4445454545' , '73337878787');
Insert into _User(_NAME , LastName , City , Email , _Password ,SSN ,PhoneNumber)
values('Ali' , 'Zare' , 'Tehran' , 'AZ@gmail.com' , '2323132323232' , '7456321569' , '74563215021');
insert into Agency(Code , _Name , City , Neighborhood)
values(1 , 'FamilyHome' , 'Tehran' , 'TehranPars');
Insert into Agent(SSN , AgencyCode)
values('7456321569' , 1);
Insert into _Owner(SSN)
values('4545454545');
Insert into Property(RegistrationPlate , Price , City , Neighborhood , DocumentType , OwnerID)
values(1 , 1200,'Tehran' , 'TehranPars' , 'mangoledar' , '4545454545');
insert into Advertisment(AdvertismentID , AgentID , _Type , _Status , Title ,PropertyID)
values(1 , '7456321569' , 'sell' , 'inprogress' , 'big house' , 1);
insert into Advertisment(AdvertismentID , AgentID , _Type , _Status , Title ,PropertyID)
values(2 , '7456321569' , 'sell' , 'inprogress' , 'big house' , 1);
Insert into Property(RegistrationPlate , Price , City , Neighborhood , DocumentType , OwnerID)
values(2 , 1500,'Tehran' , 'TehranPars' , 'Gholname' , '4545454545');
insert into Advertisment(AdvertismentID , AgentID , _Type , _Status , Title ,PropertyID)
values(3 , '7456321569' , 'sell' , 'inprogress' , 'big house' , 2);
Insert into Property(RegistrationPlate , Price , City , Neighborhood , DocumentType , OwnerID)
values(3 , 500,'Tehran' , 'TehranPars' , 'Gholname' , '4545454545');
insert into Advertisment(AdvertismentID , AgentID , _Type , _Status , Title ,PropertyID)
values(4 , '7456321569' , 'sell' , 'inprogress' , 'big house' , 3);
insert into Apartment(RegistrationPlate , Area , #Bedrooms , HasStoreroomOrNot , HeatingType , CoolingType)
values(1 , 100 , 2 , 1 , 'furnace' , 'air conditioner')
insert into Apartment(RegistrationPlate , Area , #Bedrooms , HasStoreroomOrNot , HeatingType , CoolingType)
values(2 , 150 , 3 , 1 , 'furnace' , 'air conditioner')
insert into AgentOwnerCooperate(AgentID , OwnerID)
values('7456321569' , '4545454545')
insert into Rate( NumericalRate ,UserID , AgencyID)
values( 2 , '4545454545' , 1 )
insert into Rate( NumericalRate ,UserID , AgencyID)
values( 3 , '5632326565' , 1 )
insert into Rate( NumericalRate ,UserID , AgencyID)
values( 5 , '4545789545', 1 )
insert into Rate( NumericalRate ,UserID , AgencyID)
values( 2.5, '4445454545', 1 )
