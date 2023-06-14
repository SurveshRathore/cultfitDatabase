create database cultFitDB

use cultFitDB

create table AdminTable
(
	adminId int primary key identity(1,1),
	adminFirstName varchar(255),
	adminLastName varchar(255),
	adminEmail varchar(255),
	adminPassword varchar(255),
)

create table UserTable
(
	UserId int primary key identity(1,1),
	UserFirstName varchar(255),
	UserLastName varchar(255),
	UserEmail varchar(255),
	UserContactNumber varchar(255),
	UserPasswrod varchar(255)
)

create table FitnessCultpassTable
(
	FitnessCultpassId int primary key identity(1,1),
	FitnessCultpassType varchar(255),
	FitnessCultpassDescription varchar(255),
	cultpassPrice varchar(255),
	cultpassEMI varchar(255),
	cultpassDiscount varchar(255),
)

create table FitnessTable
(
	FitnessId int primary key identity(1,1),
	FitnessCultPassName varchar(255), 
	FitnessCultpassDescription varchar(255),
    FitnessStartTime date,
    FitnessEndTime date,
    FitnessOriginalPrice int,
    FitnessOfferPrice int,
    FitnessPerMonthCost int	
)

create table CareTable
(
	CareId int primary key identity(1,1),
	FitnessType varchar(255),
	FitnessDescription varchar(255),
	FitnessCultpassId int,	
)

create table LabTestTable
(
	LabTestId int primary key identity(1,1),
	LabTestName varchar(255),
	LabTestDescription varchar(255),
	LabTestOriginalPrice int,
	LabTestOfferPrice int
)



create table MeditationTable
(
	MeditationId int primary key identity(1,1),
	MeditationName varchar(255),
	MeditationDescription varchar(255),
	NumberOfPacks int,	
	MeditationImage varchar(255)
)

create table CenterTable
(
	CenterId int primary key identity(1,1),
	CenterName varchar(255),
	CenterAddress varchar(255),
	CenterContactNumber int,	
)