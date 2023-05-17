use RealState
--User
insert into _User(_NAME , LastName , City , Email , _Password , SSN , PhoneNumber)
values
('Roya' , 'Omrani' , 'Tehran' , 'RO@gmail.com' , '1234567891011' , '4545454545' , '78787878787'), --Customer --Owner
('Reza' , 'Baghyi' , 'Tehran' , 'RB@gmail.com' , '4563333998745' , '5632326565' , '74125896336'), --Agent
('Farnaz' , 'Rezayi' , 'Tehran' , 'FR@gmail.com' , '7411474114741' , '4545789545' , '78787841287'), --Agent
('Bagher' , 'Bagheri' , 'Tehran' , 'BB@gmail.com' , '1234562221011' , '4445454545' , '73337878787'), --Owner
('Ali' , 'Zare' , 'Tehran' , 'AZ@gmail.com' , '2323132323232' , '7456321569' , '74563215021'), --Agent
('Fateme' , 'Mirzaii' , 'Mashhad' , 'FM@gmail.com' , '7888888888888' , '1111111111' , '77777777777'),--Owner
('Ilyia' , 'Mohammadi' , 'Rasht' , 'IM@gmail.com' , '1233333333333' , '7444411122' , '01020000000'),--Customer
('Tina' , 'Sadeghi' , 'Mashhad' , 'TS@gmail.com' , '7744444444444' , '9696859696' , '41414122236'),--Agent
('Nader' , 'Basiri' , 'Rasht' , 'NB@gmail.com' , '1000000000000' , '4541111123' , '74122223000'),--Agent
('Mona' , 'Marzi' , 'Shiraz' , 'MM@gmail.com' , '7441111233333' , '4123222122' , '41220033020'),--Agent
('Sara' , 'Sarabi' , 'Shiraz' , 'SS@gmail.com' , '4111222222222' , '7412565452' , '85223653212'),--Agent
('Korosh' , 'Kabiri' , 'Rasht' , 'KK@gmil.com' , '7411112563252' , '1200000000' , '12141000202');--Agent
--Customer
insert into Customer(SSN)
values
('4545454545'),
('7444411122');
--Agent
insert into Agent(SSN , AgencyCode)
values
('5632326565' , 1),
('4545789545' , 1),
('7456321569' , 2),
('9696859696' , 3),
('4541111123' , 4),
('4123222122' , 5)
('7412565452' , 1 ),
('1200000000' ,3 );
--_Owner
insert into _Owner(SSN)
values
('4445454545'),
('1111111111'),
('4545454545');
--Agency
insert into Agency(Code , _Name , City , Neighborhood)
values
(1 , 'THHouse' , 'Tehran' , 'Niyavaran'),
(2 , 'BigThHouse' , 'Tehran' , 'Saadat abad' ),
(3 , 'MHouses' , 'Mashhad' , 'Ahmad Abad'),
(4 , 'RHouse' , 'Rasht' , 'Golsar'),
(5 , 'SHHouse' , 'Shiraz' , 'Golestan');
--Comment
insert into Comment(CommentID , PropertyID ,Content , UserID , AdvertismentID)
values
(1,1,'Very Nice!!' , '4545454545' , 1 ),
(2 , 5 , 'Sooo Expensive:(('  , '4545454545' , 5),
(3 , 4 , 'Wow I need it' , '7444411122' , 4 ),
(4 , 2 , 'WOOOOW' , '4545454545' , 2 ),
(5 , 1 , 'No bad' , '7444411122' , 1 );
--Rate
insert into Rate( NumericalRate , UserID , AgencyID)
values
(4 ,'4445454545' , 1 ),
(3 , '1111111111' , 3),
(2.5 ,'4545454545' , 1 ),
(1 , '7444411122' , 4),
(5 ,'4445454545' , 2 );
--Advertisment
insert into Advertisment(AdvertismentID , AgentID , _Type , _Status ,Title , PropertyID)
values
(1 ,'5632326565' , 'rent' , 'inprogress' , 'CheapHouse' , 1);
insert into Advertisment(AdvertismentID , AgentID , _Type , _Status ,Title , PropertyID)
values
(2 , '4123222122' , 'sell' , 'inprogress' , 'House' , 2 );
insert into Advertisment(AdvertismentID , AgentID , _Type , _Status ,Title , PropertyID)
valuess
(3 ,'9696859696' , 'rent' , 'inprogress' , 'HHHH' , 3 );
insert into Advertisment(AdvertismentID , AgentID , _Type , _Status ,Title , PropertyID)
values
(4 , '4541111123' , 'sell' , 'inprogress'  , 'Landy' , 4 );
insert into Advertisment(AdvertismentID , AgentID , _Type , _Status ,Title , PropertyID)
values
(5 , '4545789545' , 'rent' , 'inprogress'  , 'AAAA' , 5);
insert into Advertisment(AdvertismentID , AgentID , _Type , _Status ,Title , PropertyID)
values
(6 , '9696859696' , 'sell' , 'inprogress' , 'LLLL' , 6);
insert into Advertisment(AdvertismentID , AgentID , _Type , _Status ,Title , PropertyID)
values
(7 , '9696859696' , 'sell' , 'inprogress' , 'RRRR' , 7);
--AgentCustomerCooperate
insert into AgentCustomerCooperate(CustomerID , AgentID)
values
('4545454545' , '5632326565'),
('7444411122' ,'4541111123' );
--AgentOwnerCooperate
insert into AgentOwnerCooperate(AgentID , OwnerID)
values
('5632326565' , '4445454545'),
('4545789545' , '4445454545'),
('9696859696' , '1111111111');
--BookmarkAds
insert into BookMarkAds(AdvertismentID , CustomerID)
values
(1 ,'4545454545'),
(5 , '4545454545'),
(4 , '7444411122'),
(3 , '7444411122');
--BookmarkAgent
insert into BookMarkAgents(AgentID , OwnerID)
values
('5632326565' , '4445454545'),
('4545789545' , '4445454545'),
('9696859696' , '1111111111');
--property
insert into Property(RegistrationPlate , Price , Neighborhood , DocumentType , OwnerID , City)
values
(1 , 1200 , 'Niyavaran' , 'mangoledar' , '4445454545' , 'Tehran'),--Apartment
(2 , 1500 , 'Golestan' , 'Gholname' , '1111111111'  , 'Shiraz'),--House
(3 , 2000 , 'Ahmad Abad' ,'mangoledar','1111111111' , 'Mashhad'),--House
(4 , 2200 , 'Golsar' , 'Gholname' , '4445454545', 'Rasht'),--Land
(5 , 2500 , 'Saadat abad','mangoledar', '4445454545' , 'Tehran'),--Apartment
(6 , 3000 , 'Meydan Sajjad','Gholname' , '1111111111' , 'Mashhad'), --Land
(7 , 2400 , 'Golsar' , 'Gholname' , '4545454545' , 'Rasht'); --House
--House
insert into House(RegistrationPlate , Area , #Bedrooms , HasStoreroomOrNot,HeatingType , CoolingType)
values
(2 , 800 , 4 , 1 , 'furnace' , 'air conditioner'),
(3 , 1000 , 5 , 1 , 'furnace' , 'air conditioner'),
(7 , 900 , 4 ,1,'furnace' , 'air conditioner' );
--Apartment
insert into Apartment(RegistrationPlate , Area , #Bedrooms , HasStoreroomOrNot , HeatingType , CoolingType , HasElevatorOrNot , HasParkingOrNot)
values
(1 , 150 , 2 , 1 , 'furnace' , 'air conditioner' , 1 , 1),
(5 , 100 , 1 , 1 ,'furnace' , 'air conditioner' , 0 , 0);
--Land
insert into Land(RegistrationPlate , TypeOfUse , Area)
values
(4 , 'transport' , 1000),
(6 , 'transport' , 20000);

--selling Advertisment 
--to check trigger and query
update Advertisment set _Status = 'finished' where AdvertismentID = 1 and PropertyID = 1;
update Advertisment set _Status = 'finished' where AdvertismentID = 4 and PropertyID = 4;
update Advertisment set _Status = 'finished' where AdvertismentID = 5 and PropertyID = 5;
update Advertisment set _Status = 'finished' where AdvertismentID = 2 and PropertyID = 2;
