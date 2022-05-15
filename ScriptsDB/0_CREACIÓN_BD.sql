USE [master]
GO

/****** Object:  Database [featureEugeniaAi]    Script Date: 12/05/2022 12:47:59 p. m. ******/
CREATE DATABASE [featureEugeniaAi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'featureEugeniaAi', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQL2019\MSSQL\DATA\featureEugeniaAi.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'featureEugeniaAi_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQL2019\MSSQL\DATA\featureEugeniaAi_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
