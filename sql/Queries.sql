-- 10 Queries base on the pdf of the first phase
USE RealState

/*
آگهی ها براساس اینکه رهن، اجاره یا فروش هستند، دسته بندی میشوند. بطور مثال: تمام
آپارتمان های تهران، با قیمت کمتر از ۵۰ میلیون که برای رهن ثبت شده اند.
*/
SELECT * 
FROM Apartment, Property, Advertisment
WHERE Apartment.RegistrationPlate = Property.RegistrationPlate 
AND
Property.RegistrationPlate = Advertisment.PropertyID
AND 
Property.City = 'Tehran' AND Advertisment._Type = 'rent' AND Property.Price < 5000;

/*
املاک نیز براساس اینکه چه نوع کاربری از بین ویلایی، آپارتمانی و زمین دارند، دسته بندی میشوند.
بطور مثال تمامی املاک ویلایی که در شهر اصفهان و در محدوده محله آبشار هستند.
*/

SELECT * 
FROM House, Property
WHERE House.RegistrationPlate = Property.RegistrationPlate AND Property.City = 'Shiraz' AND Property.Neighborhood = 'Golestan';

/*
تمامی املاک می‌توانند براساس آدرس(شهر) دسته بندی بشوند
*/

SELECT City,  COUNT(*) as numberofAgency
FROM Property
GROUP BY City;

/*
میتوان تمامی آگهی هایی که توسط یه مشاوراملاک خاص ثبت شده اند را مشاهده کرد.
*/

SELECT *
FROM Advertisment
WHERE Advertisment.AgentID = '4545789545';

SELECT Advertisment.AgentID, COUNT(*) as NumOfAdv
FROM Advertisment
GROUP BY Advertisment.AgentID;

/*
می‌توان مالکان را براساس تعداد املاک، نوع املاک و بازه قیمت املاک دسته بندی کرد. بطور مثال
کاربر با آیدی ۳۷ دارای 2 واحد آپارتمان و هر یک به قیمت ۱۰۰ میلیون است .
*/
create view Owners
	as SELECT _User.* 
	FROM _User INNER JOIN _Owner ON (_User.SSN = _Owner.SSN) 

SELECT o.SSN , o._NAME , o.LastName , o.PhoneNumber
FROM Owners as o , Property , Apartment
Group by o.SSN , o._NAME , o.LastName , o.PhoneNumber
having (SELECT count(*)
		FROM Apartment, Property
		WHERE Apartment.RegistrationPlate = Property.RegistrationPlate
		AND o.SSN = Property.OwnerID AND Property.Price <5000) = 2 ;


/*
می‌توانیم نظراتی که هر کاربر جداگانه ثبت کرده است را بررسی کنیم.
*/

SELECT Advertisment.AdvertismentID,Comment.Content , Advertisment._Type , Property.City , Property.Price , Property.Neighborhood 
FROM Comment , Advertisment , Property 
where Comment.AdvertismentID = Advertisment.AdvertismentID and Property.RegistrationPlate = Comment.PropertyID 


/*
همچنین می‌توان مشاوراملاک های هر ناحیه و محدوده را بطور جداگانه بررسی کرد. بطور مثال تمامی
مشاور املاک هایی که در شهر تهران و محدوده نیاوران قرار دارند.
*/

SELECT Agency.City,  COUNT(*) as NumofAgency
FROM Agency
GROUP BY Agency.City

/*
می‌توان اطلاعات تمام کارمندانی که در یک مشاور املاک خاص کار می‌کنند را برگرداند.
*/


SELECT Agency.Code , Agency._Name as AgencyName, Agency.City , Agency.Neighborhood ,_User._NAME , _User.LastName , _User.PhoneNumber , _User.Email
FROM Agency INNER JOIN Agent ON Agency.Code = Agent.AgencyCode , _User
WHERE Agency.Code = 1 and Agent.SSN = _User.SSN;

/*
واحدهای مسکونی را میتوان براساس ویژگی های مانند مساحت، تعداد اتاق خواب، داشتن یا نداشتن
آسانسور و ... نیز فیلتر کرد. بطور مثال تمام ی آپارتمان های تهران با ۲۰۰ متر مربع مساحت و ۴ اتاق
خواب.
*/

SELECT Apartment.* , Property.City , Property.Neighborhood  , Property.Price ,Property.DocumentType
FROM Apartment , Property
WHERE HasElevatorOrNot = 0 AND HasStoreroomOrNot = 1 and area = 100 and Apartment.RegistrationPlate = Property.RegistrationPlate
		and Property.City = 'Tehran';

/*
مشاوراملاکها نیز براساس امتیاز دریافتی از سوی کاربران مرتب میشوند. بطور مثال یافتن ۵
مشاوراملاک در شهر تهران که بیشترین مقدار امتیاز را داشته اند.
*/

SELECT TOP 3 AgencyID, AVG(NumericalRate) AS AverageOfRates
FROM  Rate , Agency
where Agency.City = 'Tehran' and Rate.AgencyID = Agency.Code
GROUP BY Rate.AgencyID
ORDER BY AVG(NumericalRate) DESC;

/*
لیست نشانه گذاری شده:
این لیست برای هر کاربر متفاوت است و بر اساس نیاز خود کاربر صورت میگیرد
تبلیغات ذخیره شده هر مشتری را با مشخصات آن برمیگرداند
*/
select Property.City , Property.Neighborhood , Property.Price , Property.RegistrationPlate , Property.DocumentType
from BookMarkAds , Advertisment , Property 
where BookMarkAds.CustomerID = '4545454545' and BookMarkAds.AdvertismentID = Advertisment.AdvertismentID and Advertisment.PropertyID = Property.RegistrationPlate

/*
 مشاور املاک هایی با بیشترین میزان کارکنان
*/
select Agent.AgencyCode , count(*) as NumOfAgents
from Agent inner join Agency on Agency.Code = Agent.AgencyCode
group by Agent.AgencyCode 
order by count(*) desc

/*
	 مشاور املاک با بیشترین میزان فروش خانه
*/
select Agent.AgencyCode , SUM(Agent.NumOfFinshedAdvertisment) as NumOfSoldAdvertisment
from Agent inner join Agency on Agency.Code = Agent.AgencyCode
group by Agent.AgencyCode 
order by SUM(Agent.NumOfFinshedAdvertisment) desc

/*
دسته بندی زمین ها بر اساس شهر و محله داده شده 
مثلا خانه های شهر مشهد محله میدان سجاد
*/
select Property.*
from Land , Property 
where Land.RegistrationPlate = Property.RegistrationPlate and Property.City = 'Mashhad' and Property.Neighborhood = 'Meydan Sajjad'

/*
لیست تبلیغات هایی که در رابطه با شهر مشهد هستند
*/
select Advertisment.AdvertismentID , Advertisment._Type , Advertisment._Status , Advertisment.Title, _User._NAME as AgentName , _User.LastName as AgentLastName , _User.PhoneNumber , _User.Email
from Advertisment , Property , _User
where Advertisment.PropertyID = Property.RegistrationPlate and Property.City = 'Mashhad' and _User.SSN = Advertisment.AgentID

/*

×لیست تمام یوزر هایی که علاوه بر مالک یک خانه بودن، مشتری هم هستند.
*/
select _User._NAME , _User.LastName , _User.City , _User.Email , _User.PhoneNumber
from _Owner , Customer , _User
where _Owner.SSN = Customer.SSN and _User.SSN = _Owner.SSN

/*
لیست تمام مشاور املاک هایی که حداقل با یک آگهی را برای مشتری درحال فروشش هستند
*/
select Agent.SSN ,  _User._NAME , _User.LastName , _User.PhoneNumber
from Agent inner join AgentOwnerCooperate on Agent.SSN = AgentOwnerCooperate.AgentID inner join _User on Agent.SSN = _User.SSN
group by Agent.SSN , _User._NAME , _User.LastName , _User.PhoneNumber
having (select Count(*)
		from Advertisment 
		where Advertisment.AgentID = Agent.SSN )>=1
/*
لیست تبلیغات هایی که با قیمت کمتر از ۲۰۰۰ را شامل میشوند.
*/
select Advertisment.* , Property.Price , Property.City , Property.Neighborhood
from Advertisment , Property
where Advertisment.PropertyID = Property.RegistrationPlate and Property.Price<2000

/*
لیست آپارتمان هایی که سیستم گرمایشی شوفاژ دارند و حداقل 100 متر هستند و در تهران هستند
*/
select Apartment.* , Property.City , Property.Neighborhood
from Apartment , Property
where Apartment.RegistrationPlate = Property.RegistrationPlate and Property.City = 'Tehran' and Apartment.Area>=100 and Apartment.HeatingType = 'furnace'

/*
کاربری که بیشترین تعداد کامنت را گذاشته
*/
select top 1 _User.SSN, _User._NAME , _User.LastName
from Comment inner join _User on Comment.UserID = _User.SSN
group by _User.SSN , _User._NAME , _User.LastName
order by Count(*) desc