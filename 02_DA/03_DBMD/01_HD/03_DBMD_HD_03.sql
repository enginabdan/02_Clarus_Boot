
---------------------------------------------------3 DERS-----------------------------------------------------------------------

CREATE DATABASE Library1;

USE Library1;

--Create Two Schemas
CREATE SCHEMA Book;
---
CREATE SCHEMA Person;


--Create Book.Book table
CREATE TABLE Book.Book([Book_ID] [int] PRIMARY KEY NOT NULL,
					   [Book_Name] [nvarchar](50) NULL);

--Create Book.Author table

CREATE TABLE Book.Author([Author_ID] [int],
						 [Author_Name] [nvarchar](50) NULL);

--Create Book.Book_Author table

CREATE TABLE Book.Book_Author (Book_ID INT PRIMARY KEY,
							   Author_ID INT NOT NULL);

--Create Publisher Table

CREATE TABLE Book.Publisher ([Publisher_ID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
							 [Publisher_Name] [nvarchar](100) NULL);

--Create Book_Publisher table

CREATE TABLE Book.Book_Publisher ([Book_ID] [int] PRIMARY KEY NOT NULL,
								  [Publisher_ID] [int] NOT NULL);

--Create Person.Person table

CREATE TABLE Person.Person([Person_ID] [bigint] PRIMARY KEY NOT NULL,
						   [Person_Name] [nvarchar](50) NULL,
						   [Person_Surname] [nvarchar](50) NULL);

--Create Person.Person_Book table

CREATE TABLE Person.Person_Book ([Person_ID] [bigint] NOT NULL,
								 [Book_ID] [int] NOT NULL);

---Create Person_Mail table

CREATE TABLE Person.Person_Mail ([Mail_ID] [int] Primary Key identity(1,1) NOT NULL,
								 [E_Mail] [text] NOT NULL,
								 [Person_ID] [bigint] NOT NULL);

--Create Person.Person_Phone table

CREATE TABLE Person.Person_Phone ([Phone_Number] [bigint] PRIMARY KEY NOT NULL,
								  [Person_ID] [bigint] NOT NULL);

--Tabloları yukarıdaki şekilde öncelikle create edip devam ediniz.
--Aşağıda DML komutlarını örneklendirip tablo constraintlerini sonradan tanımlayacağız. 
--Örnek olarak insert ettiğimiz verileri sonradan sileceğiz. 

----------INSERT
-- !!! ilgili kolonun özelliklerine ve kısıtlarına uygun veri girilmeli !!!
-- Insert işlemi yapacağınız tablo sütunlarını aşağıdaki gibi parantez içinde belirtebilirsiniz.
-- Bu kullanımda sadece belirttiğiniz sütunlara değer girmek zorundasınız. Sütun sırası önem arz etmektedir.

INSERT INTO Person.Person (Person_ID, Person_Name, Person_Surname) VALUES (75056659595,'Zehra', 'Tekin')

INSERT INTO Person.Person (Person_ID, Person_Name) VALUES (889623212466,'Kerem')

--Eğer bir tablodaki tüm sütunlara insert etmeyecekseniz, seçtiğiniz sütunların haricindeki sütunlar Nullable olmalı.
--Eğer Not Null constrainti uygulanmış sütun varsa hata verecektir.
--Aşağıda Person_Surname sütununa değer girilmemiştir. 
--Person_Surname sütunu Nullable olduğu için Person_Surname yerine Null değer atayarak işlemi tamamlar.

INSERT INTO Person.Person (Person_ID, Person_Name) VALUES (78962212466,'Kerem')

--Insert edeceğim değerler tablo kısıtlarına ve sütun veri tiplerine uygun olmazsa aşağıdaki gibi işlemi gerçekleştirmez.

--Insert keywordunden sonra Into kullanmanıza gerek yoktur.
--Ayrıca Aşağıda olduğu gibi insert etmek istediğiniz sütunları belirtmeyebilirsiniz. 
--Buna rağmen sütun sırasına ve yukarıdaki kurallara dikkat etmelisiniz.
--Bu kullanımda tablonun tüm sütunlarına insert edileceği farz edilir ve sizden tüm sütunlar için değer ister.

INSERT Person.Person VALUES (15078893526,'Mert','Yetiş')

--Eğer değeri bilinmeyen sütunlar varsa bunlar yerine Null yazabilirsiniz. 
--Tabiki Null yazmak istediğiniz bu sütunlar Nullable olmalıdır.

INSERT Person.Person VALUES (55556698752, 'Esra', Null)

--Aynı anda birden fazla kayıt insert etmek isterseniz;

INSERT Person.Person VALUES (35532888963,'Ali','Tekin');-- Tüm tablolara değer atanacağı varsayılmıştır.
INSERT Person.Person VALUES (88232556264,'Metin','Sakin')

--Aynı tablonun aynı sütunlarına birçok kayıt insert etmek isterseniz aşağıdaki syntaxı kullanabilirsiniz.
--Burada dikkat edeceğiniz diğer bir konu Mail_ID sütununa değer atanmadığıdır.
--Mail_ID sütunu tablo oluşturulurken identity olarak tanımlandığı için otomatik artan değerler içerir.
--Otomatik artan bir sütuna değer insert edilmesine izin verilmez.

INSERT INTO Person.Person_Mail (E_Mail, Person_ID) 
VALUES ('zehtek@gmail.com', 75056659595),
	   ('meyet@gmail.com', 15078893526),
	   ('metsak@gmail.com', 35532558963);

--Yukarıdaki syntax ile aşağıdaki fonksiyonları çalıştırdığınızda,
--Yaptığınız son insert işleminde tabloya eklenen son kaydın identity' sini ve tabloda etkilenen kayıt sayısını getirirler.
--Not: fonksiyonları teker teker çalıştırın.

SELECT @@IDENTITY--last process last identity number
SELECT @@ROWCOUNT--last process row count

--Aşağıdaki syntax ile farklı bir tablodaki değerleri daha önceden oluşturmuş olduğunuz farklı bir tabloya insert edebilirsiniz.
--Sütun sırası, tipi, constraintler ve diğer kurallar yine önemli.

SELECT *
INTO Person.Person_2
FROM Person.Person-- Person_2 şeklinde yedek bir tablo oluşturun

INSERT Person.Person_2 (Person_ID, Person_Name, Person_Surname)
SELECT *
FROM Person.Person
WHERE Person_name LIKE 'M%'

--Aşağıdaki syntaxda göreceğiniz üzere hiçbir değer belirtilmemiş. 
--Bu şekilde tabloya tablonun default değerleriyle insert işlemi yapılacaktır.
--Tabiki sütun constraintleri buna elverişli olmalı. 

INSERT Book.Publisher
DEFAULT VALUES