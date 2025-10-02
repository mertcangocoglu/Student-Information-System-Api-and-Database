CREATE DATABASE obs2;

USE obs2;

CREATE TABLE fakulteler (
    F_No VARCHAR(3) NOT NULL,
    F_Ad VARCHAR(50) NOT NULL,
    Adres TEXT DEFAULT 'Antalya',
    Telefon VARCHAR(11),
    D_Sicil_No VARCHAR(4),
    Eposta VARCHAR(50),
    CONSTRAINT pk_fakulteler PRIMARY KEY (F_No)
);

CREATE TABLE ogrenim_tur (
    Tur_No VARCHAR(1) NOT NULL,
    Tur VARCHAR(50),
    CONSTRAINT pk_ogrenim_tur PRIMARY KEY (Tur_No)
);

CREATE TABLE unvanlar (
    Unvan_No VARCHAR(2) NOT NULL,
    Unvan VARCHAR(50),
    CONSTRAINT pk_unvanlar PRIMARY KEY (Unvan_No)
);

CREATE TABLE kimlik (
    Tc_Kimlik VARCHAR(11) NOT NULL,
    Ad VARCHAR(50),
    Soyad VARCHAR(50),
    D_Tarih DATE,
    D_Yer VARCHAR(50),
    A_Ad VARCHAR(50),
    B_Ad VARCHAR(50),
    Eposta VARCHAR(50),
    Resim IMAGE,
    Adres TEXT,
    Telefon VARCHAR(11),
    CONSTRAINT pk_kimlik PRIMARY KEY (Tc_Kimlik),
    CONSTRAINT unq_tel UNIQUE (Telefon)
);

CREATE TABLE bolumler (
    B_No VARCHAR(3) NOT NULL,
    B_Ad VARCHAR(100),
    F_No VARCHAR(3),
    Tur_No VARCHAR(1),
    BB_Sicil_No VARCHAR(4),
    CONSTRAINT pk_bolumler PRIMARY KEY (B_No),
    CONSTRAINT fk_fakulteler_bolumler FOREIGN KEY (F_No) REFERENCES fakulteler (F_No),
    CONSTRAINT fk_ogrenim_tur_bolumler FOREIGN KEY (Tur_No) REFERENCES ogrenim_tur (Tur_No),
);

CREATE TABLE alanlar (
    A_No INT NOT NULL,
    Alan VARCHAR(50),
    CONSTRAINT pk_alanlar PRIMARY KEY (A_No)
);

CREATE TABLE personeller (
    Sicil_No VARCHAR(4) NOT NULL,
    TC_Kimlik VARCHAR(11),
    B_No VARCHAR(3),
    A_No INT,
    Unvan_No VARCHAR(2),
    CONSTRAINT pk_personeller PRIMARY KEY (Sicil_No),
    CONSTRAINT fk_kimlik_personeller FOREIGN KEY (TC_Kimlik) REFERENCES kimlik (Tc_Kimlik),
    CONSTRAINT fk_bolumler_personeller FOREIGN KEY (B_No) REFERENCES bolumler (B_No),
    CONSTRAINT fk_alanlar_personeller FOREIGN KEY (A_No) REFERENCES alanlar (A_No),
    CONSTRAINT fk_unvanlar_personeller FOREIGN KEY (Unvan_No) REFERENCES unvanlar (Unvan_No)
);

alter table bolumler add constraint fk_personeller_bolumler foreign key(BB_Sicil_No) references personeller(Sicil_No)

CREATE TABLE dersler (
    D_Kod VARCHAR(7) NOT NULL,
    D_Ad VARCHAR(50),
    T INT,
    U INT,
    K INT,
    B_No VARCHAR(3),
    Yariyil VARCHAR(2),
    AKTS INT,
    D_Saat INT,
    D_Tur VARCHAR(20),
    CONSTRAINT pk_dersler PRIMARY KEY (D_Kod),
    CONSTRAINT fk_bolumler_dersler FOREIGN KEY (B_No) REFERENCES bolumler (B_No)
);

CREATE TABLE donemler (
    D_No VARCHAR(3) NOT NULL,
    Donem VARCHAR(50),
    CONSTRAINT pk_donemler PRIMARY KEY (D_No)
);

CREATE TABLE dersler_personeller (
    Kayit_No INT IDENTITY(1,1) NOT NULL,
    D_Kod VARCHAR(7),
    Sicil_No VARCHAR(4),
    D_No VARCHAR(3),
    CONSTRAINT pk_derslerpersoneller PRIMARY KEY (Kayit_No),
    CONSTRAINT fk_dersler_derslerpersoneller FOREIGN KEY (D_Kod) REFERENCES dersler (D_Kod),
    CONSTRAINT fk_personeller_derslerpersoneller FOREIGN KEY (Sicil_No) REFERENCES personeller (Sicil_No),
    CONSTRAINT fk_donemler_derslerpersoneller FOREIGN KEY (D_No) REFERENCES donemler (D_No)
);

CREATE TABLE ogrenci_kayit (
    Ogrenci_No VARCHAR(11) NOT NULL,
    TC_Kimlik VARCHAR(11),
    B_No VARCHAR(3),
    K_Tarih DATE,
    K_Tur VARCHAR(50),
    M_Tarih DATE,
    GNO FLOAT,
    Durum BIT,
    CONSTRAINT pk_ogrenci_kayit PRIMARY KEY (Ogrenci_No),
    CONSTRAINT fk_kimlik_ogrenci_kayit FOREIGN KEY (TC_Kimlik) REFERENCES kimlik (Tc_Kimlik),
    CONSTRAINT fk_bolumler_ogrenci_kayit FOREIGN KEY (B_No) REFERENCES bolumler (B_No)
);

CREATE TABLE ders_kayit (
    Kayit_No INT IDENTITY(1,1) NOT NULL,
    Ogrenci_No VARCHAR(11),
    D_Kod VARCHAR(7),
    Vize INT,
    Final INT,
    Uygulama INT,
    Butunleme INT,
    Durum BIT,
    D_No VARCHAR(3),
    CONSTRAINT pk_ders_kayit PRIMARY KEY (Kayit_No),
    CONSTRAINT chk_vize CHECK (vize >= 0 AND Vize <= 100),
    CONSTRAINT chk_final CHECK (Final >= 0 AND Final <= 100),
    CONSTRAINT chk_uygulama CHECK (Uygulama >= 0 AND Uygulama <= 100),
    CONSTRAINT chk_butunleme CHECK (Butunleme >= 0 AND Butunleme <= 100),
    CONSTRAINT fk_ogrenci_kayit_ders_kayit FOREIGN KEY (Ogrenci_No) REFERENCES ogrenci_kayit (Ogrenci_No),
    CONSTRAINT fk_dersler_ders_kayit FOREIGN KEY (D_Kod) REFERENCES dersler (D_Kod),
    CONSTRAINT fk_donemler_ders_kayit FOREIGN KEY (D_No) REFERENCES donemler (D_No)
);

select * from fakulteler

insert into fakulteler values('1','Diþ Hekimliði Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('2','Edebiyat Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('3','Eðitim Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('4','Fen Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('5','Güzel Sanatlar Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('6','Hemþirelik Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('7','Hukuk Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('8','Ýktisadi ve Ýdari Bilimler Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('9','Ýlahiyat Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('10','Ýletiþim Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('11','Kemer Denizcilik Fakültesi','Kemer','','','')
insert into fakulteler values('12','Kumluca Saðlýk Bilimleri Fakültesi','Kumluca','','','')
insert into fakulteler values('13','Manavgat Sosyal ve Beþeri Bilimler Fakültesi','Manavgat','','','')
insert into fakulteler values('14','Manavgat Turizm Fakültesi','Manavgat','','','')
insert into fakulteler values('15','Mimarlýk Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('16','Mühendislik Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('17','Saðlýk Bilimleri Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('18','Serik Ýþletme Fakültesi','Serik','','','')
insert into fakulteler values('19','Spor Bilimleri Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('20','Su Ürünleri Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('21','Týp Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('22','Turizm Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('23','Uygulamalý Bilimler Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('24','Ziraat Fakültesi','Ana Kampüs','','','')
insert into fakulteler values('25','Antalya Devlet Konservatuvarý','Ana Kampüs','','','')
insert into fakulteler values('26','Adalet Meslek Yüksekokulu','Ana Kampüs','','','')
insert into fakulteler values('27','Demre Dr. Hasan Ünal Meslek Yüksekokulu','Demre','','','')
insert into fakulteler values('28','Elmalý Meslek Yüksekokulu','Elmalý','','','')
insert into fakulteler values('29','Finike Meslek Yüksekokulu','Finike','','','')
insert into fakulteler values('30','Göynük Mutfak Sanatlarý Meslek Yüksekokulu','Kemer','','','')
insert into fakulteler values('31','Korkuteli Meslek Yüksekokulu','Korkuteli','','','')
insert into fakulteler values('32','Kumluca Meslek Yüksekokulu','Kumluca','','','')
insert into fakulteler values('33','Manavgat Meslek Yüksekokulu','Manavgat','','','')
insert into fakulteler values('34','Saðlýk Hizmetleri Meslek Yüksekokulu','Ana Kampüs','','','')
insert into fakulteler values('35','Serik Gülsün Süleyman Süral Meslek Yüksekokulu','Serik','','','')
insert into fakulteler values('36','Sosyal Bilimler Meslek Yüksekokulu','Muratpaþa','','','')
insert into fakulteler values('37','Teknik Bilimler Meslek Yüksekokulu','Ana Kampüs','','','')


select * from ogrenim_tur

insert into ogrenim_tur  values ('1','Ön Lisans')
insert into ogrenim_tur  values ('2','Lisans')
insert into ogrenim_tur  values ('3','Yüksek Lisans')
insert into ogrenim_tur  values ('4','Doktora')
insert into ogrenim_tur  values ('5','Uzaktan')
insert into ogrenim_tur  values ('6','Formasyon')
insert into ogrenim_tur  values ('7','2 yýllýk')
update ogrenim_tur set Tur='Uzaktan Eðitim' where Tur_No='5'
delete from ogrenim_tur where Tur_No='7'

select * from unvanlar

insert into unvanlar values ('1','Prof. Dr.')
insert into unvanlar values ('2','Doç. Dr.')
insert into unvanlar values ('3','Doktr. Ögretim. Üyesi')
insert into unvanlar values ('4','Öðr. Gör.')
insert into unvanlar values ('5','Dr. Öðr. Gör.')
insert into unvanlar values ('6','Araþ. Gör.')
insert into unvanlar values ('7','Uzman')
insert into unvanlar values ('8','Mühendis')
insert into unvanlar values ('9','Doktor')
insert into unvanlar values ('10','Ýmparator')
insert into unvanlar values ('11','Rektör')
update unvanlar set Unvan='Dr. Öðr. Üy.' where Unvan_No='3'
update unvanlar set Unvan='Öðr. Gör. Doç. Dr.' where Unvan_No='10'
delete from unvanlar where Unvan_No=''
update unvanlar set Unvan='Öðr. Gör Dr.' where Unvan_No='11'
insert into unvanlar values ('12','Arþ. Gör. Doç. Dr.' )
insert into unvanlar values ('13','Arþ. Gör. Dr.' )
update unvanlar set Unvan='Arþ. Gör.' where Unvan_No='6'

update unvanlar set Unvan=('Öðr. Gör. Dr.') where Unvan_No='11'

select * from kimlik

insert into kimlik (TC_Kimlik,Ad,Soyad) values ('00000000000','Bilinmiyor','Bilinmiyor')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000001','Recep','ERHAN','rerhan@akdeniz.edu.tr','Antalya','05000000001')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000002','Hamdi','YETKÝN','hamdiyetkin@akdeniz.edu.tr','Antalya','05000000002')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000003','Saniye Gamze','KIRKALTIOÐLU','sgamzekirkaltioglu@akdeniz.edu.tr','Antalya','05000000003')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000004','Sezer','GÖL','sezergol@akdeniz.edu.tr','Antalya','05000000004')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000005','Fahriye','SUCU','fsucu@akdeniz.edu.tr','Antalya','05000000005')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000006','Ömer','TORUN','omertorun@akdeniz.edu.tr','Antalya','05000000006')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000007','Hamit','ÖZEKÝCÝ','hozekici@akdeniz.edu.tr','Antalya','05000000007')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000008','Ýsmail Tarýk','ALTIGÜN','itarik@akdeniz.edu.tr','Antalya','05000000008')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000009','Uluð','ÜNLÜ','ulugunlu@akdeniz.edu.tr','Antalya','05000000009')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000010','Ayþe','CANÝK','acanik@akdeniz.edu.tr','Antalya','05000000010')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000011','Yunus','AKGÜN','yakgun@akdeniz.edu.tr','Antalya','05000000011')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000012','Serra','SONER','ssoner@akdeniz.edu.tr','Antalya','05000000012')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000013','Kerem Kasým','ÇELÝK','kcelik@akdeniz.edu.tr','Antalya','05000000013')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000014','Rabia Meltem','GÖNEN','rmeltemgonen@akdeniz.edu.tr','Antalya','05000000014')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000015','Fulya','YELÝZ','fyeliz@akdeniz.edu.tr','Antalya','05000000015')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000016','Nermin','KAÇAR','nerminkacar@akdeniz.edu.tr','Antalya','05000000016')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000017','Nuri','AÇIL','nuriacil@akdeniz.edu.tr','Antalya','05000000017')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000018','Tayfur','OBA','toba@akdeniz.edu.tr','Antalya','05000000018')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000019','Cenk','TURAN','cturan@akdeniz.edu.tr','Antalya','05000000019')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000020','Ayþe','ÇÝMEN','acimen@akdeniz.edu.tr','Antalya','05000000020')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000021','Nihal','NARÝN','nihalnarin@akdeniz.edu.tr','Antalya','05000000021')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000022','Murat Özer','ALP','muratalp@akdeniz.edu.tr','Antalya','05000000022')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000023','Hasan','TOPAL','htopal@oakdeniz.edu.tr','Antalya','05000000023')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000024','Asiye Beyza','AY','abeyzaay@akdeniz.edu.tr','Antalya','05000000024')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000025','Mehmet','TÜRKER','aturker@akdeniz.edu.tr','Antalya','05000000025')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000026','Nisa','YEÞÝL','nyesil@akdeniz.edu.tr','Antalya','05000000026')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000027','Güven','TOHUM','gtohum@akdeniz.edu.tr','Antalya','05000000027')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000028','Ahmet','KARA','ahmetkara@akdeniz.edu.tr','Antalya','05000000028')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000029','Furkan','YILDIZ','fyildiz@akdeniz.edu.tr','Antalya','05000000029')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000030','Osimhen','YAKUP','osimhenyakup@akdeniz.edu.tr','Antalya','05000000030')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000031','Ýsmail','JAKOBS','ijakobs@akdeniz.edu.tr','Antalya','05000000031')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000032','Ayþe','KARADEMÝR','akarademir@akdeniz.edu.tr','Antalya','05000000032')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000033','Naci','ÜSTÜN','nustun@akdeniz.edu.tr','Antalya','05000000033')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000034','Ýrem','BÝL','irembil@akdeniz.edu.tr','Antalya','05000000034')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000035','Artuð Kerem','COÞAR','akeremcosar@akdeniz.edu.tr','Antalya','05000000035')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000036','Nesrin','ÇIRAK','ncirak@akdeniz.edu.tr','Antalya','05000000036')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000037','Aslýhan','GÖRÜR','asligorur@akdeniz.edu.tr','Antalya','05000000037')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000038','Ahmet','DEMÝR','ademir@akdeniz.edu.tr','Antalya','05000000038')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000039','Tuðba','YEÞÝL','tugbayesil@akdeniz.edu.tr','Antalya','05000000039')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000040','Devran','EMÝR','devranemir@akdeniz.edu.tr','Antalya','05000000040')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000041','Mertcan','GÖÇOÐLU','mertcangocoglu@ogr.akdeniz.edu.tr','Bursa','05000000041')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000042','Alperen','YAKA','alperenyaka@ogr.akdeniz.edu.tr','Aydýn','05000000042')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000043','Batuhan','SUNGUR','bsungur@ogr.akdeniz.edu.tr','Yalova','05000000043')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000044','Kenan','DEMÝRAY','kdemiray@ogr.akdeniz.edu.tr','Denizli','05000000044')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000045','Buket','KILIÇ','bkilic@ogr.akdeniz.edu.tr','Muðla','05000000045')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000046','Çaðla','SARI','caglasari@ogr.akdeniz.edu.tr','Samsun','05000000046')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000047','Þule','KAYA','sulekaya@ogr.akdeniz.edu.tr','Artvin','05000000047')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000048','Emel','AYDIN','emelaydin@ogr.akdeniz.edu.tr','Konya','05000000048')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000049','Kemal','SUBAÞI','kemalsubasi@ogr.akdeniz.edu.tr','Sakarya','05000000049')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000050','Ceyda','AKAR','ceydaakar@ogr.akdeniz.edu.tr','Burdur','05000000050')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000051','Mehmet','KISA','mkisa@ogr.akdeniz.edu.tr','Kýrýkkale','05000000051')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000052','Irmak','DOÐUALP','idogualp@ogr.akdeniz.edu.tr','Bursa','05000000052')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000053','Harun','CANÝK','hcanik@ogr.akdeniz.edu.tr','Ankara','05000000053')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000054','Seda','DEMÝRCÝ','sdemirci@ogr.akdeniz.edu.tr','Çorum','05000000054')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000055','Tuðra','ÝNCESU','tugbaincesu@ogr.akdeniz.edu.tr','Sivas','05000000055')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000056','Belma','GÜMÜÞ','bgumus@ogr.akdeniz.edu.tr','Ýzmir','05000000056')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000057','Gökhan','ANADOL','gokhananadol@ogr.akdeniz.edu.tr','Ankara','05000000057')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000058','Ayþe','SÜMER','asümer@ogr.akdeniz.edu.tr','Çanakkale','05000000058')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000059','Deniz Mert','ENES','dmertens@ogr.akdeniz.edu.tr','Ýstanbul','05000000059')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000060','Fatih','BURUK','fburuk@ogr.akdeniz.edu.tr','Adana','05000000060')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000061','Çetin','KIRIK','cetinkirik@ogr.akdeniz.edu.tr','Balýkesir','05437732054')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000062','Sude','ESKÝ','sudeeski@ogr.akdeniz.edu.tr','Sakarya','05462340232')
insert into kimlik (TC_Kimlik,Ad,Soyad,Eposta,Adres,Telefon) values ('00000000063','Mert Serhat','EKER','msserhateker@akdeniz.edu.tr','Antalya','05023446235')


select * from alanlar

insert into alanlar values (1,'Yazýlým')
insert into alanlar values (2,'Donaným')
insert into alanlar values (3,'Muhasebe')
insert into alanlar values (4,'ÝKY')
insert into alanlar values (5,'Ýktisat')
insert into alanlar values (6,'Proje Yönetimi')
insert into alanlar values (7,'Ýþletme')
insert into alanlar values (8,'Havacýlýk')
insert into alanlar values (9,'Edebiyat')
update alanlar set Alan='Ýnsan Kaynaklarý Yönetimi' where A_No=4
delete from alanlar where A_No=9

select * from bolumler

insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('1','Yönetim Biliþim Sistemleri','23','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('2','Uluslararasý Ticaret ve Lojistik','23','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('3','Pazarlama','23','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('4','Finans ve Bankacýlýk','23','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('5','Sigortacýlýk','23','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('6','Havacýlýk Yönetimi','23','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('7','Bilgisayar Mühendisliði','16','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('8','Endüstri Mühdendisliði','16','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('9','Psikoloji','2','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('10','Tarih','2','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('11','Hukuk','7','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('12','Mimarlýk','15','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('13','Týp','21','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('14','Elektrik Elektronik Mührendisliði','16','2')
insert into bolumler (B_No,B_Ad,F_No,Tur_No) values ('15','Bilgisayar Programcýlýðý','28','1')

select * from personeller

insert into personeller (Sicil_No,TC_Kimlik) values ('0000','00000000000')
insert into personeller values ('0001','00000000001','2','7','1')
insert into personeller values ('0002','00000000002','4','5','1')
insert into personeller values ('0003','00000000003','2','7','1')
insert into personeller values ('0004','00000000004','1','1','1')
insert into personeller values ('0005','00000000005','2','7','1')
insert into personeller values ('0006','00000000006','1','6','2')
insert into personeller values ('0007','00000000007','2','7','2')
insert into personeller values ('0008','00000000008','3','7','2')
insert into personeller values ('0009','00000000009','4','3','2')
insert into personeller values ('0010','00000000010','3','7','2')
insert into personeller values ('0011','00000000011','5','5','2')
insert into personeller values ('0012','00000000012','4','3','2')
insert into personeller values ('0013','00000000013','1','1','2')
insert into personeller values ('0014','00000000014','3','7','2')
insert into personeller values ('0015','00000000015','5','5','2')
insert into personeller values ('0016','00000000016','1','4','2')
insert into personeller values ('0017','00000000017','4','3','2')
insert into personeller values ('0018','00000000018','1','1','2')
insert into personeller values ('0019','00000000019','6','8','2')
insert into personeller values ('0020','00000000020','4','3','2')
insert into personeller values ('0021','00000000021','4','3','2')
insert into personeller values ('0022','00000000022','6','8','3')
insert into personeller values ('0023','00000000023','2','7','3')
insert into personeller values ('0024','00000000024','2','7','3')
insert into personeller values ('0025','00000000025','5','5','3')
insert into personeller values ('0026','00000000026','6','8','3')
insert into personeller values ('0027','00000000027','1','2','3')
insert into personeller values ('0028','00000000028','4','3','3')
insert into personeller values ('0029','00000000029','4','3','10')
insert into personeller values ('0030','00000000030','2','7','11')
insert into personeller values ('0031','00000000031','2','7','11')
insert into personeller values ('0032','00000000032','3','7','11')
insert into personeller values ('0033','00000000033','3','7','12')
insert into personeller values ('0034','00000000034','2','7','11')
insert into personeller values ('0035','00000000035','2','7','11')
insert into personeller values ('0036','00000000036','2','7','6')
insert into personeller values ('0037','00000000037','3','7','6')
insert into personeller values ('0038','00000000038','4','3','6')
insert into personeller values ('0039','00000000039','1','1','6')
insert into personeller values ('0040','00000000040','5','5','6')
insert into personeller values ('0041','00000000063','15','1','4')


select * from dersler

insert into dersler values ('YBS151','Biliþim Sistemlerine ve Teknolojilerine Giriþ',2,0,2,'1','1',4,2,'Z')
insert into dersler values ('YBS153','Algoritma ve Programlamaya Giriþ',3,0,3,'1','1',4,3,'Z')
insert into dersler values ('YBS155','Matematik',3,0,3,'1','1',4,3,'Z')
insert into dersler values ('YBS157','Pazarlama Ýlkeleri',3,0,3,'1','1',4,3,'Z')
insert into dersler values ('YBS159','Ýktisada Giriþ 1',3,0,4,'1','1',4,3,'Z')
insert into dersler values ('TDB101','Türk Dili 1',2,0,2,'1','1',2,2,'Z')
insert into dersler values ('ATA101','Atatürk Ýlkeleri ve Ýnkýlap Tarihi 1',2,0,2,'1','1',2,2,'Z')
insert into dersler values ('YBD101','Ýngilizce 1',2,0,2,'1','1',4,2,'Z')
insert into dersler values ('KPD101','Kariyer Planlama',1,0,1,'1','1',2,1,'Z')


insert into dersler values ('YBS152','Yönetim ve Organizasyon',3,0,3,'1','2',5,3,'Z')
insert into dersler values ('YBS154','Ýleri Düzey Ofis Uygulamalarý',2,0,2,'1','2',4,2,'Z')
insert into dersler values ('YBS156','Bilgisayar Donanýmý ve Ýþletim Sistemleri',3,0,3,'1','2',4,3,'Z')
insert into dersler values ('YBS158','Veri Yapýlarý ve Algoritmalar',3,0,3,'1','2',5,3,'Z')
insert into dersler values ('YBS160','Ýktisada Giriþ 2',3,0,3,'1','2',4,3,'Z')
insert into dersler values ('TDB102','Türk Dili 2',2,0,2,'1','2',2,2,'Z')
insert into dersler values ('ATA102','Atatürk Ýlkeleri ve Ýnkýlap Tarihi 2',2,0,2,'1','2',2,2,'Z')
insert into dersler values ('YBD102','Ýngilizce 2',2,0,2,'1','2',4,2,'Z')


insert into dersler values ('YBS251','Nesne Yönelimli Programlama 1',3,0,3,'1','3',4,3,'Z')
insert into dersler values ('YBS253','Web Tabanlý Programlama 1',3,0,3,'1','3',4,3,'Z')
insert into dersler values ('YBS255','Veritabanýna Giriþ',3,0,3,'1','3',4,3,'Z')
insert into dersler values ('YBS257','Proje Yönetimi',3,0,3,'1','3',4,3,'Z')
insert into dersler values ('YBS259','Örgütsel Davranýþ',3,0,3,'1','3',4,3,'Z')
insert into dersler values ('YBS261','Ýstatistik 1',3,0,3,'1','3',3,3,'Z')
insert into dersler values ('YBS263','Uygulamalý Giriþimcilik',3,0,3,'1','3',4,3,'Z')
insert into dersler values ('YBS265','Genel Muhasebe 1',3,0,3,'1','3',3,3,'Z')

insert into dersler values ('YBS252','Nesne Yönelimli Programlama 2',3,0,3,'1','4',4,3,'Z')
insert into dersler values ('YBS254','Web Tabanlý Programlama 2',3,0,3,'1','4',4,3,'Z')
insert into dersler values ('YBS256','Veritabaný Yönetim Sistemleri',3,0,3,'1','4',4,3,'Z')
insert into dersler values ('YBS258','Bilimsel Araþtýrma Yöntemleri',3,0,3,'1','4',4,3,'Z')
insert into dersler values ('YBS260','Üretim Yönetimi',3,0,3,'1','4',4,3,'Z')
insert into dersler values ('YBS262','Ýstatistik 1',3,0,3,'1','4',3,3,'Z')
insert into dersler values ('YBS264','Sistem Analizi ve Tasarýmý',3,0,3,'1','4',4,3,'Z')
insert into dersler values ('YBS266','Genel Muhasebe 2',3,0,3,'1','4',3,3,'Z')
update dersler set D_Ad='Ýstatistik 2' where D_Kod='YBS262'

insert into dersler values ('YBS351','Veri Ýletiþimi ve Bilgisayar Aðlarý',3,0,3,'1','5',4,3,'Z')
insert into dersler values ('YBS353','Mobil Uygulama Geliþtirme',3,0,3,'1','5',4,3,'Z')
insert into dersler values ('YBS355','Grafik ve Biliþim Arayüz Tasarýmý',3,0,3,'1','5',4,3,'Z')
insert into dersler values ('YBS357','Yöneylem Araþtýrmasý 1',3,0,3,'1','5',4,3,'Z')
insert into dersler values ('YBS359','Stratejik Yönetim',3,0,3,'1','5',4,3,'Z')
insert into dersler values ('YBS361','Karar Verme Teknikleri',3,0,3,'1','5',4,3,'Z')

insert into dersler values ('YBS381','Dijital Ürün Yönetimi',3,0,3,'1','5',3,3,'S')
insert into dersler values ('YBS383','Bilgisayarlý Muhasebe',3,0,3,'1','5',3,3,'S')
insert into dersler values ('YBS385','Biliþim Hukuku',3,0,3,'1','5',3,3,'S')
insert into dersler values ('YBS387','Tüketici Davranýþlarý',3,0,3,'1','5',3,3,'S')
insert into dersler values ('TDP301','Toplumsal Destek Projeleri',1,2,1,'1','5',3,1,'S')
insert into dersler values ('TDB115','Akademik Türkçe(Yabancu Uyruklu)',2,0,2,'1','5',3,2,'S')
insert into dersler values ('EMD101','Yabancý Dil Olarak Türkçe',3,0,3,'1','5',3,3,'S')

insert into dersler values ('YBS352','Bilgi Sistemleri Entegrasyonu',3,0,3,'1','6',4,3,'Z')
insert into dersler values ('YBS354','Yapay Zekâ ve Makine Öðrenmesi',3,0,3,'1','6',4,3,'Z')
insert into dersler values ('YBS356','Ýnsan Kaynaklarý Yönetimi',3,0,3,'1','6',4,3,'Z')
insert into dersler values ('YBS358','Yöneylem Araþtýrmasý 2',3,0,3,'1','6',4,3,'Z')
insert into dersler values ('YBS360','Sistem Yönetimi ve Güvenliði',3,0,3,'1','6',4,3,'Z')
insert into dersler values ('YBS362','Finansal Yönetim',3,0,3,'1','6',4,3,'Z')

insert into dersler values ('YBS382','Ýnsan Bilgisayar Etkileþimi',2,0,2,'1','6',3,2,'S')
insert into dersler values ('YBS384','Simülasyon Modelleri ve Analizi',3,0,3,'1','6',3,3,'S')
insert into dersler values ('YBS386','Bilgisayar Tabanlý Optimizasyon Uygulamalarý',3,0,3,'1','6',3,3,'S')
insert into dersler values ('YBS388','Bilgisayarla Görme',3,0,3,'1','6',3,3,'S')
insert into dersler values ('YBS390','Toplam Kalite Yönetimi',3,0,3,'1','6',3,3,'S')
insert into dersler values ('GNC300','Gönüllülük Çalýþmalarý',1,2,1,'1','6',3,3,'S')

insert into dersler values ('YBS451','Kurumsal Kaynak Planlama',3,0,3,'1','7',5,3,'Z')
insert into dersler values ('YBS453','Yönetim Biliþim Sitemlerinde Güncel Konular',2,0,2,'1','7',6,2,'Z')

insert into dersler values ('YBS481','Kurumsal Veri Yönetimi',3,0,3,'1','7',4,3,'S')
insert into dersler values ('YBS483','Uygulamalý Veri Madenciliði',3,0,3,'1','7',4,3,'S')
insert into dersler values ('YBS485','Derin Öðrenme',3,0,3,'1','7',4,3,'S')
insert into dersler values ('YBS487','Müþteri Ýliþkileri Yönetimi',3,0,3,'1','7',4,3,'S')
insert into dersler values ('YBS489','Tedarik Zinciri Yönetimi',3,0,3,'1','7',4,3,'S')
insert into dersler values ('YBS491','E-Ýþ Yönetimi',3,0,3,'1','7',4,3,'S')
insert into dersler values ('YBS493','Maliyet Muhasebesi',3,0,3,'1','7',4,3,'S')
insert into dersler values ('YBS495','Robotik Uygulamalarý',3,0,3,'1','7',4,3,'S')
insert into dersler values ('YBS497','Ýþ Hukuku ve Etik',3,0,3,'1','7',4,3,'S')

insert into dersler values ('YBS402','Ýþ Yerinde Eðitim',0,40,0,'1','8',30,40,'Z')

select * from donemler

insert into donemler values ('1','1-Güz')
insert into donemler values ('2','1-Bahar')
insert into donemler values ('3','2-Güz')
insert into donemler values ('4','2-Bahar')
insert into donemler values ('5','3-Güz')
insert into donemler values ('6','3-Bahar')
insert into donemler values ('7','4-Güz')
insert into donemler values ('8','4-Bahar')

select * from dersler_personeller

insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS151','0027','1')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS153','0006','1')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS155','0006','1')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS157','0025','1')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS159','0015','1')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('TDB101','0000','1')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('ATA101','0000','1')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBD101','0000','1')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('KPD101','0016','1')

insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS152','0016','2')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS154','0018','2')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS156','0027','2')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS158','0013','2')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS160','0024','2')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('TDB102','0000','2')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('ATA102','0000','2')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBD102','0000','2')

insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS251','0027','3')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS253','0018','3')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS255','0013','3')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS257','0006','3')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS259','0016','3')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS261','0017','3')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS263','0016','3')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS265','0029','3')

insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS252','0018','4')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS254','0018','4')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS256','0013','4')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS258','0004','4')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS260','0006','4')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS262','0017','4')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS264','0006','4')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS266','0029','4')

insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS351','0013','5')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS353','0013','5')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS355','0000','5')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS357','0006','5')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS359','0016','5')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS361','0004','5')

insert into dersler_personeller (D_Kod,D_No) values ('YBS381','5')
insert into dersler_personeller (D_Kod,D_No) values ('YBS383','5')
insert into dersler_personeller (D_Kod,D_No) values ('YBS385','5')
insert into dersler_personeller (D_Kod,D_No) values ('YBS387','5')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('TDP301','0016','5')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('TDB115','0000','5')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('EMD101','0000','5')

insert into dersler_personeller (D_Kod,D_No) values ('YBS352','6')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS354','0004','6')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS356','0016','6')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS358','0006','6')
insert into dersler_personeller (D_Kod,D_No) values ('YBS360','6')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS362','0002','6')

insert into dersler_personeller (D_Kod,D_No) values ('YBS382','6')
insert into dersler_personeller (D_Kod,D_No) values ('YBS384','6')
insert into dersler_personeller (D_Kod,D_No) values ('YBS386','6')
insert into dersler_personeller (D_Kod,D_No) values ('YBS388','6')
insert into dersler_personeller (D_Kod,D_No) values ('YBS390','6')
insert into dersler_personeller (D_Kod,D_No) values ('GNC300','6')

insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS451','0006','7')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS453','0018','7')

insert into dersler_personeller (D_Kod,D_No) values ('YBS481','7')
insert into dersler_personeller (D_Kod,D_No) values ('YBS483','7')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS485','0013','7')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS487','0025','7')
insert into dersler_personeller (D_Kod,D_No) values ('YBS489','7')
insert into dersler_personeller (D_Kod,D_No) values ('YBS491','7')
insert into dersler_personeller (D_Kod,D_No) values ('YBS493','7')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS495','0027','7')
insert into dersler_personeller (D_Kod,D_No) values ('YBS497','7')

insert into dersler_personeller (D_Kod,D_No) values ('YBS402','8')

insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS353','0041','5')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS255','0041','3')
insert into dersler_personeller (D_Kod,Sicil_No,D_No) values ('YBS256','0041','4')

select * from ogrenci_kayit

insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000001','00000000041','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000002','00000000042','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000003','00000000043','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000004','00000000044','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000005','00000000045','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000006','00000000046','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000007','00000000047','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000008','00000000048','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000009','00000000049','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000010','00000000050','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000011','00000000051','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000012','00000000052','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000013','00000000053','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000014','00000000054','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000015','00000000055','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000016','00000000056','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000017','00000000057','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000018','00000000058','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000019','00000000059','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20220000020','00000000060','1','20220822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20230805033','00000000061','14','20230822','YKS')
insert into ogrenci_kayit (Ogrenci_No,TC_Kimlik,B_No,K_Tarih,K_Tur) values ('20224753062','00000000062','1','20220822','YKS')


select * from ders_kayit

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS151',100,100,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS153',95,100,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS155',100,60,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS157',85,35,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS159',95,95,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','TDB101',80,95,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','ATA101',85,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBD101',95,90,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','KPD101',60,75,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS152',95,75,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS154',70,85,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS156',92,92,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000001','YBS158',46,45,70,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS160',90,65,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','TDB102',85,80,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','ATA102',55,80,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBD102',90,85,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS251',91,100,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS253',85,72,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Durum,D_No) values ('20220000001','YBS255',100,75,75,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS257',50,75,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS259',68,76,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS261',100,90,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS263',86,86,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS265',85,75,1,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS252',90,85,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS254',85,85,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS256',90,80,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS258',70,80,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS260',65,75,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS262',90,90,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS264',75,55,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000001','YBS266',75,65,1,'4')


insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS151',85,95,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS153',40,40,0,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS155',80,75,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS157',65,55,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS159',90,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','TDB101',85,90,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','ATA101',90,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBD101',90,90,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','KPD101',65,70,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS152',86,75,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS154',77,85,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS156',88,86,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS158',50,64,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS160',90,70,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','TDB102',80,73,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','ATA102',69,82,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBD102',80,89,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS251',87,91,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS253',79,72,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Durum,D_No) values ('20220000002','YBS255',100,75,75,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS257',40,50,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS259',65,73,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS261',80,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS263',81,72,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS265',61,59,1,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS252',80,72,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS254',74,82,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS256',68,74,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS258',65,61,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS260',57,64,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS262',93,85,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000002','YBS264',49,33,70,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000002','YBS266',73,65,1,'4')


insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS151',80,90,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS153',47,13,0,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS155',62,73,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000003','YBS157',58,24,69,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS159',77,75,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','TDB101',83,67,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','ATA101',89,90,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBD101',96,79,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','KPD101',66,69,1,'1')



insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS152',85,73,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS154',76,84,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS156',80,86,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS158',30,24,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS160',55,70,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','TDB102',75,78,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','ATA102',80,80,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBD102',80,53,1,'2')



insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS251',66,59,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS253',71,78,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Butunleme,Durum,D_No) values ('20220000003','YBS255',65,40,65,75,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS257',35,20,0,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS259',73,78,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS261',65,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS263',74,58,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000003','YBS265',55,40,67,1,'3')



insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS252',55,78,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000003','YBS254',63,32,81,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000003','YBS256',35,23,43,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS258',56,67,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS260',69,49,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS262',76,82,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000003','YBS264',50,47,71,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000003','YBS266',39,25,0,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000004','YBS151',32,65,79,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS153',54,75,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS155',75,47,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS157',23,24,0,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS159',74,56,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','TDB101',86,78,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','ATA101',56,90,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBD101',68,86,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','KPD101',56,73,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS152',87,56,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS154',77,45,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS156',66,48,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS158',96,72,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS160',54,66,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','TDB102',88,78,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','ATA102',76,94,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBD102',67,83,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000004','YBS251',63,34,61,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS253',73,57,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Durum,D_No) values ('20220000004','YBS255',76,64,60,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS257',86,63,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS259',93,82,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS261',77,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS263',54,69,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000004','YBS265',34,40,44,0,'3')



insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS252',77,54,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS254',64,88,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS256',75,86,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS258',67,64,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000004','YBS260',69,28,57,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS262',54,72,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS264',90,79,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000004','YBS266',86,92,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS151',92,84,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS153',73,77,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000005','YBS155',53,47,74,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS157',83,96,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS159',81,72,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','TDB101',80,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','ATA101',78,94,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBD101',70,70,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','KPD101',65,78,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS152',87,77,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS154',64,62,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS156',84,83,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS158',59,66,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS160',95,90,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000005','TDB102',33,27,70,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','ATA102',96,74,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBD102',67,83,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS251',99,93,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS253',85,80,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Durum,D_No) values ('20220000005','YBS255',100,70,85,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS257',70,84,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS259',90,82,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS261',82,69,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS263',98,90,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS265',43,87,1,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS252',84,83,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS254',90,90,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS256',79,83,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS258',77,58,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS260',94,76,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS262',80,71,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS264',81,79,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000005','YBS266',96,100,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS151',54,75,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS153',35,63,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS155',74,87,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS157',84,92,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS159',76,79,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','TDB101',80,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','ATA101',89,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBD101',80,91,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','KPD101',74,66,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS152',85,75,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000006','YBS154',43,21,68,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000006','YBS156',54,36,71,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS158',12,35,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS160',60,60,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','TDB102',90,85,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','ATA102',92,84,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBD102',75,80,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS251',60,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000006','YBS253',40,40,50,0,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Uygulama,Durum,D_No) values ('20220000006','YBS255',50,30,40,45,0,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000006','YBS257',64,45,58,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS259',56,60,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS261',34,45,0,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS263',66,78,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS265',80,74,1,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS252',45,64,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS254',55,70,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS256',30,10,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS258',60,60,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000006','YBS260',65,35,60,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS262',80,80,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000006','YBS264',40,46,60,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000006','YBS266',70,67,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS151',75,75,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS153',65,63,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS155',85,70,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS157',43,12,0,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS159',52,60,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000007','TDB101',40,20,74,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','ATA101',95,80,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000007','YBD101',59,10,66,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','KPD101',70,60,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS152',38,75,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS154',55,70,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS156',80,71,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS158',36,64,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS160',82,81,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','TDB102',90,80,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','ATA102',74,81,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBD102',70,80,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS251',60,74,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS253',75,86,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Durum,D_No) values ('20220000007','YBS255',85,90,90,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS257',80,88,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS259',91,82,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS261',74,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS263',95,75,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS265',66,83,1,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS252',45,64,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS254',55,70,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS256',30,10,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS258',60,70,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS260',55,35,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS262',68,80,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000007','YBS264',40,46,60,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000007','YBS266',83,67,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS151',61,51,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS153',55,98,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS155',44,16,0,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS157',84,92,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS159',95,65,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','TDB101',80,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','ATA101',90,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBD101',82,91,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','KPD101',58,66,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS152',97,57,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS154',64,62,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS156',84,63,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS158',89,66,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS160',95,90,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','TDB102',84,95,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','ATA102',96,74,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBD102',68,73,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS251',60,63,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS253',40,72,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Uygulama,Durum,D_No) values ('20220000008','YBS255',40,40,72,75,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS257',75,64,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS259',56,60,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000008','YBS261',36,28,37,0,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS263',77,81,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS265',76,62,1,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS252',96,43,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000008','YBS254',36,30,76,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS256',79,83,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS258',82,58,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000008','YBS260',50,23,84,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS262',73,71,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS264',81,57,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000008','YBS266',96,57,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS151',65,76,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000009','YBS153',40,40,67,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000009','YBS155',45,20,28,0,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS157',58,61,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000009','YBS159',40,50,70,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','TDB101',85,70,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','ATA101',76,72,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBD101',50,71,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','KPD101',60,65,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS152',60,70,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000009','YBS154',40,40,50,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Uygulama,Durum,D_No) values ('20220000009','YBS156',50,30,40,45,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000009','YBS158',64,45,58,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS160',56,60,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','TDB102',34,45,00,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','ATA102',66,78,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBD102',80,74,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS251',75,75,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS253',65,63,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS255',85,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS257',43,12,0,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS259',52,60,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000009','YBS261',40,20,74,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS263',95,80,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000009','YBS265',59,10,66,1,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS252',85,75,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000009','YBS254',43,21,68,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000009','YBS256',54,36,71,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS258',12,35,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS260',60,60,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS262',90,85,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS264',92,84,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000009','YBS266',75,80,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS151',70,60,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS153',51,67,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS155',62,70,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS157',81,74,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS159',56,63,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','TDB101',85,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','ATA101',93,81,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBD101',84,91,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','KPD101',74,56,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS152',85,75,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000010','YBS154',20,30,46,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000010','YBS156',55,28,64,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS158',88,62,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS160',95,60,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','TDB102',86,80,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','ATA102',81,84,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBD102',90,80,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS251',60,74,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS253',75,86,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Durum,D_No) values ('20220000010','YBS255',85,90,90,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS257',67,64,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000010','YBS259',48,40,72,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS261',74,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000010','YBS263',47,38,68,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS265',66,83,1,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS252',77,54,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS254',64,78,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS256',55,86,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS258',67,64,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000010','YBS260',69,26,57,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS262',60,59,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000010','YBS264',35,29,40,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000010','YBS266',63,70,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000011','YBS151',21,30,49,0,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS153',61,50,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS155',43,80,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS157',84,92,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS159',75,65,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','TDB101',80,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','ATA101',90,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBD101',91,82,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','KPD101',66,58,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS152',38,75,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS154',55,70,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS156',80,71,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS158',36,64,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS160',82,81,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','TDB102',90,80,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','ATA102',74,81,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBD102',70,80,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS251',63,75,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS253',81,43,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,Uygulama,D_No) values ('20220000011','YBS255',70,74,65,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS257',50,60,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS259',56,76,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS261',40,74,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS263',82,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000011','YBS265',47,30,77,1,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS252',79,53,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS254',68,49,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000011','YBS256',32,39,40,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS258',60,70,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS260',78,35,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS262',68,80,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000011','YBS264',40,46,60,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000011','YBS266',92,67,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS151',67,81,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000012','YBS153',52,36,74,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000012','YBS155',49,12,43,0,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS157',79,62,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS159',84,68,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','TDB101',90,71,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','ATA101',78,94,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBD101',76,60,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','KPD101',58,69,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000012','YBS152',40,35,73,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS154',64,57,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS156',81,63,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS158',79,62,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Butunleme,Final,Durum,D_No) values ('20220000012','YBS160',35,39,90,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','TDB102',85,75,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','ATA102',67,74,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBD102',68,63,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000012','YBS251',43,40,75,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS253',70,63,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Durum,D_No) values ('20220000012','YBS255',85,55,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS257',55,79,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Durum,D_No) values ('20220000012','YBS259',61,73,80,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000012','YBS261',40,20,74,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS263',95,80,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000012','YBS265',53,10,39,0,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000012','YBS252',45,22,78,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS254',46,70,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000012','YBS256',23,36,80,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS258',60,68,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS260',76,42,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS262',59,70,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000012','YBS264',33,33,40,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000012','YBS266',71,67,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS151',63,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS153',55,72,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS155',74,87,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS157',84,69,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS159',71,79,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','TDB101',80,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','ATA101',89,75,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBD101',80,91,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','KPD101',83,66,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS152',77,57,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS154',64,72,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS156',81,63,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000013','YBS158',39,30,42,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS160',75,90,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','TDB102',84,95,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','ATA102',67,74,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBD102',58,71,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS251',70,65,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS253',43,79,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Uygulama,Durum,D_No) values ('20220000013','YBS255',32,30,50,45,0,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS257',75,54,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS259',56,60,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS261',79,63,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS263',76,81,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000013','YBS265',20,10,20,0,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000013','YBS252',28,40,81,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000013','YBS254',15,30,48,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS256',65,59,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS258',85,62,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000013','YBS260',30,53,74,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS262',63,77,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS264',81,54,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000013','YBS266',93,47,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBS151',60,60,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000014','YBS153',57,32,64,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBS155',55,66,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBS157',84,71,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000014','YBS159',46,33,20,0,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','TDB101',84,67,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','ATA101',83,78,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBD101',84,63,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','KPD101',73,58,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000014','YBS152',34,43,82,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBS154',72,59,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000014','YBS156',28,44,47,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBS158',59,72,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Butunleme,Final,Durum,D_No) values ('20220000014','YBS160',35,39,90,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','TDB102',65,75,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','ATA102',88,52,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBD102',89,71,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000014','YBS251',41,51,60,0,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBS253',63,77,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Durum,D_No) values ('20220000014','YBS255',66,84,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBS257',56,63,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBS259',83,62,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000014','YBS261',48,50,77,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBS263',64,59,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000014','YBS265',24,50,60,0,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000014','YBS252',17,52,65,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBS254',75,60,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000014','YBS256',40,36,68,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBS258',58,73,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000014','YBS260',54,37,65,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBS262',60,71,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000014','YBS264',38,46,85,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000014','YBS266',64,77,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000015','YBS151',44,35,73,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS153',75,53,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS155',84,67,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,Butunleme,D_No) values ('20220000015','YBS157',37,39,48,0,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS159',86,69,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','TDB101',85,58,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','ATA101',68,53,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBD101',50,71,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','KPD101',84,66,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS152',75,64,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS154',45,80,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000015','YBS156',11,43,50,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS158',85,74,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS160',62,88,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,Butunleme,D_No) values ('20220000015','TDB102',20,25,64,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','ATA102',84,61,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBD102',50,80,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000015','YBS251',45,19,50,0,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS253',75,53,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Butunleme,Durum,D_No) values ('20220000015','YBS255',46,40,70,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS257',33,17,0,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS259',72,48,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS261',43,76,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS263',85,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS265',55,66,1,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS252',46,87,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000015','YBS254',33,41,55,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS256',89,53,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS258',82,58,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000015','YBS260',50,23,84,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS262',63,71,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000015','YBS264',39,44,51,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000015','YBS266',83,57,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000016','YBS151',34,45,63,0,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS153',76,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS155',63,51,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS157',83,44,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000016','YBS159',42,41,72,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','TDB101',76,88,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','ATA101',66,90,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBD101',68,96,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','KPD101',66,73,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS152',63,74,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000016','YBS154',57,41,73,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000016','YBS156',64,16,61,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS158',65,93,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS160',61,60,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','TDB102',70,85,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000016','ATA102',55,34,77,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBD102',75,70,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS251',76,88,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000016','YBS253',44,45,50,0,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Durum,D_No) values ('20220000016','YBS255',65,78,65,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS257',98,87,0,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS259',56,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS261',100,93,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS263',83,90,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000016','YBS265',49,30,21,0,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS252',74,65,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS254',63,81,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000016','YBS256',23,55,60,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS258',54,86,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000016','YBS260',47,36,64,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS262',76,62,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000016','YBS264',40,47,51,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000016','YBS266',69,85,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS151',64,80,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS153',81,64,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000017','YBS155',52,25,68,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS157',76,62,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS159',66,63,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','TDB101',85,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,Butunleme,D_No) values ('20220000017','ATA101',42,39,83,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBD101',84,61,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','KPD101',94,56,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000017','YBS152',49,44,76,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS154',85,70,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS156',100,89,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000017','YBS158',48,42,70,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS160',90,65,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','TDB102',85,80,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','ATA102',58,90,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBD102',100,85,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS251',34,14,0,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000017','YBS253',65,30,63,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Durum,D_No) values ('20220000017','YBS255',94,60,80,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS257',63,92,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000017','YBS259',52,27,78,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000017','YBS261',41,23,74,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS263',86,79,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000017','YBS265',59,28,68,1,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS252',75,56,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS254',87,95,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS256',60,79,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS258',73,80,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000017','YBS260',65,41,75,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS262',97,76,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000017','YBS264',75,11,52,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000017','YBS266',65,65,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000018','YBS151',67,33,60,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS153',86,55,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS155',67,82,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS157',92,64,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS159',74,63,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000018','TDB101',53,26,76,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','ATA101',79,90,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBD101',78,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000018','KPD101',46,43,75,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS152',95,100,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS154',88,71,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000018','YBS156',40,50,67,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS158',93,74,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS160',82,61,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000018','TDB102',50,42,70,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','ATA102',79,81,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBD102',89,80,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000018','YBS251',62,33,66,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS253',77,54,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Durum,D_No) values ('20220000018','YBS255',78,84,85,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS257',84,62,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS259',91,82,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS261',77,83,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS263',57,65,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000018','YBS265',33,41,53,0,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS252',100,73,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000018','YBS254',44,25,73,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000018','YBS256',51,34,36,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS258',84,65,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS260',64,80,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS262',70,65,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000018','YBS264',40,54,83,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000018','YBS266',77,80,1,'4')


insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000019','YBS151',40,35,43,0,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS153',74,73,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS155',65,87,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS157',90,74,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS159',69,86,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','TDB101',73,94,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000019','ATA101',37,40,90,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBD101',76,86,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','KPD101',84,73,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000019','YBS152',23,56,60,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS154',90,100,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000019','YBS156',50,45,76,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS158',79,82,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Butunleme,Final,Durum,D_No) values ('20220000019','YBS160',35,39,90,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','TDB102',95,80,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','ATA102',87,94,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Uygulama,Durum,D_No) values ('20220000019','YBD102',100,83,85,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000019','YBS251',56,42,83,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS253',81,73,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,Uygulama,D_No) values ('20220000019','YBS255',90,77,75,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS257',80,66,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000019','YBS259',24,49,99,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS261',70,74,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS263',92,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000019','YBS265',47,30,77,1,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS252',90,53,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,Uygulama,D_No) values ('20220000019','YBS254',64,78,95,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS256',55,86,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS258',67,64,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000019','YBS260',63,27,58,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS262',60,59,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000019','YBS264',38,24,41,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000019','YBS266',67,70,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000020','YBS151',38,45,75,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS153',68,84,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS155',85,90,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS157',73,81,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS159',16,20,0,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000020','TDB101',45,10,73,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','ATA101',96,84,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000020','YBD101',54,42,68,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','KPD101',70,61,1,'1')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS152',83,91,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000020','YBS154',57,35,37,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS156',94,100,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS158',85,92,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS160',90,81,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,Butunleme,D_No) values ('20220000020','TDB102',50,44,73,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','ATA102',89,94,1,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBD102',80,89,1,'2')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS251',100,87,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,Butunleme,D_No) values ('20220000020','YBS253',82,14,97,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,Uygulama,D_No) values ('20220000020','YBS255',94,79,100,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS257',64,86,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000020','YBS259',52,44,83,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS261',41,78,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS263',86,70,1,'3')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000020','YBS265',47,30,45,0,'3')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000020','YBS252',48,30,81,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS254',74,98,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS256',85,66,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS258',67,64,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Butunleme,Durum,D_No) values ('20220000020','YBS260',50,45,50,0,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS262',84,78,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,Butunleme,D_No) values ('20220000020','YBS264',35,54,90,1,'4')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20220000020','YBS266',76,52,1,'4')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20230805033','YBD101',67,85,1,'1')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20230805033','YBS158',100,20,0,'2')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20230805033','YBS495',40,99,1,'7')

insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20224753062','YBS353',5,15,0,'5')
insert into ders_kayit (Ogrenci_No,D_Kod,Vize,Final,Durum,D_No) values ('20224753062','YBS355',50,65,1,'5')

