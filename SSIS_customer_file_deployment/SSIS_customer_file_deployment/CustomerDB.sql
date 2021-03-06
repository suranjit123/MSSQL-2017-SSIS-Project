USE [master]
GO
/****** Object:  Database [DataWarehouse]    Script Date: 2/20/2019 12:30:13 AM ******/
CREATE DATABASE [DataWarehouse]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DataWarehouse', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DataWarehouse.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DataWarehouse_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DataWarehouse_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DataWarehouse] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DataWarehouse].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DataWarehouse] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DataWarehouse] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DataWarehouse] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DataWarehouse] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DataWarehouse] SET ARITHABORT OFF 
GO
ALTER DATABASE [DataWarehouse] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DataWarehouse] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DataWarehouse] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DataWarehouse] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DataWarehouse] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DataWarehouse] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DataWarehouse] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DataWarehouse] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DataWarehouse] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DataWarehouse] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DataWarehouse] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DataWarehouse] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DataWarehouse] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DataWarehouse] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DataWarehouse] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DataWarehouse] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DataWarehouse] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DataWarehouse] SET RECOVERY FULL 
GO
ALTER DATABASE [DataWarehouse] SET  MULTI_USER 
GO
ALTER DATABASE [DataWarehouse] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DataWarehouse] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DataWarehouse] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DataWarehouse] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DataWarehouse] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DataWarehouse', N'ON'
GO
ALTER DATABASE [DataWarehouse] SET QUERY_STORE = OFF
GO
USE [DataWarehouse]
GO
/****** Object:  Table [dbo].[dim_CountryName]    Script Date: 2/20/2019 12:30:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_CountryName](
	[CountryId] [int] NOT NULL,
	[CountryName] [nvarchar](50) NULL,
	[IsNew] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_productName]    Script Date: 2/20/2019 12:30:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_productName](
	[ProductId] [int] NOT NULL,
	[ProductName] [nvarchar](50) NULL,
	[DateCreated] [datetime] NULL,
	[DateExpired] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_salesperson]    Script Date: 2/20/2019 12:30:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_salesperson](
	[SalesPersonId] [int] NOT NULL,
	[SalesPersonName] [nvarchar](50) NULL,
 CONSTRAINT [PK_dim_salesperson] PRIMARY KEY CLUSTERED 
(
	[SalesPersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_stateName]    Script Date: 2/20/2019 12:30:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_stateName](
	[StateId] [int] NOT NULL,
	[StateName] [nvarchar](50) NULL,
 CONSTRAINT [PK_dim_stateName] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactCustomer]    Script Date: 2/20/2019 12:30:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactCustomer](
	[CustomerCode] [nvarchar](50) NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAmt] [smallmoney] NULL,
	[SalesDate] [date] NULL,
	[CountryId_fk] [int] NULL,
	[StateId_fk] [int] NULL,
	[ProductId_fk] [int] NULL,
	[SalesPersonId_fk] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactCustomer]  WITH NOCHECK ADD  CONSTRAINT [FK_FactCustomer_dim_salesperson] FOREIGN KEY([SalesPersonId_fk])
REFERENCES [dbo].[dim_salesperson] ([SalesPersonId])
GO
ALTER TABLE [dbo].[FactCustomer] CHECK CONSTRAINT [FK_FactCustomer_dim_salesperson]
GO
ALTER TABLE [dbo].[FactCustomer]  WITH NOCHECK ADD  CONSTRAINT [FK_FactCustomer_dim_stateName] FOREIGN KEY([StateId_fk])
REFERENCES [dbo].[dim_stateName] ([StateId])
GO
ALTER TABLE [dbo].[FactCustomer] CHECK CONSTRAINT [FK_FactCustomer_dim_stateName]
GO
USE [master]
GO
ALTER DATABASE [DataWarehouse] SET  READ_WRITE 
GO
