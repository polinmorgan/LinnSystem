USE [master]
GO
/****** Object:  Database [polina_test]    Script Date: 11/30/2016 1:34:25 AM ******/
CREATE DATABASE [polina_test]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'polina_test', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\polina_test.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'polina_test_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\polina_test_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [polina_test] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [polina_test].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [polina_test] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [polina_test] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [polina_test] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [polina_test] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [polina_test] SET ARITHABORT OFF 
GO
ALTER DATABASE [polina_test] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [polina_test] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [polina_test] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [polina_test] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [polina_test] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [polina_test] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [polina_test] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [polina_test] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [polina_test] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [polina_test] SET  DISABLE_BROKER 
GO
ALTER DATABASE [polina_test] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [polina_test] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [polina_test] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [polina_test] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [polina_test] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [polina_test] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [polina_test] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [polina_test] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [polina_test] SET  MULTI_USER 
GO
ALTER DATABASE [polina_test] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [polina_test] SET DB_CHAINING OFF 
GO
ALTER DATABASE [polina_test] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [polina_test] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [polina_test] SET DELAYED_DURABILITY = DISABLED 
GO
USE [polina_test]
GO
/****** Object:  User [TEST_user]    Script Date: 11/30/2016 1:34:25 AM ******/
CREATE USER [TEST_user] FOR LOGIN [TEST_user] WITH DEFAULT_SCHEMA=[TEST]
GO
/****** Object:  Schema [TEST]    Script Date: 11/30/2016 1:34:26 AM ******/
CREATE SCHEMA [TEST]
GO
/****** Object:  Table [dbo].[consignment]    Script Date: 11/30/2016 1:34:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[consignment](
	[ConsignmentId] [int] IDENTITY(1,1) NOT NULL,
	[ConsignmentDate] [date] NULL,
	[Address1] [varchar](150) NULL,
	[Address2] [varchar](150) NULL,
	[Address3] [varchar](150) NULL,
	[City] [varchar](50) NULL,
	[PhoneNumber] [varchar](50) NULL,
	[CountryISO2] [varchar](50) NULL,
	[PostCode] [varchar](20) NULL,
 CONSTRAINT [PK_consignment] PRIMARY KEY CLUSTERED 
(
	[ConsignmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[item]    Script Date: 11/30/2016 1:34:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[item](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[ItemCode] [varchar](50) NOT NULL,
	[Quantity] [int] NOT NULL CONSTRAINT [DF_item_Quantity]  DEFAULT ((0)),
	[UnitWeight] [float] NOT NULL CONSTRAINT [DF_item_UnitWeight]  DEFAULT ((0)),
	[PackageID] [int] NULL,
 CONSTRAINT [PK_item] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[package]    Script Date: 11/30/2016 1:34:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[package](
	[PackgeId] [int] IDENTITY(1,1) NOT NULL,
	[PackageWidth] [float] NOT NULL CONSTRAINT [DF_package_PackageWidht]  DEFAULT ((0)),
	[PackageHeight] [float] NOT NULL CONSTRAINT [DF_package_PackageHeight]  DEFAULT ((0)),
	[PackageDepth] [float] NOT NULL CONSTRAINT [DF_package_PackageDepth]  DEFAULT ((0)),
	[PackageType] [varchar](50) NULL,
	[ConsignmentId] [int] NULL,
 CONSTRAINT [PK_package] PRIMARY KEY CLUSTERED 
(
	[PackgeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tempConsigment]    Script Date: 11/30/2016 1:34:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tempConsigment](
	[ConsignmentDate] [date] NULL,
	[Address1] [varchar](150) NULL,
	[Address2] [varchar](150) NULL,
	[Address3] [varchar](150) NULL,
	[City] [varchar](50) NULL,
	[PhoneNumber] [varchar](50) NULL,
	[CountryISO2] [varchar](50) NULL,
	[PostCode] [varchar](20) NULL,
	[PackageWidth] [float] NULL,
	[PackageHeight] [float] NULL,
	[PackageDepth] [float] NULL,
	[PackageType] [varchar](50) NULL,
	[ItemCode] [varchar](50) NULL,
	[Quantity] [int] NULL,
	[UnitWeight] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [NonClusteredIndex-20161130-010244]    Script Date: 11/30/2016 1:34:26 AM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20161130-010244] ON [dbo].[item]
(
	[PackageID] ASC
)
INCLUDE ( 	[ItemCode],
	[Quantity],
	[UnitWeight]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [TEST].[sp_Consignment_Insert]    Script Date: 11/30/2016 1:34:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [TEST].[sp_Consignment_Insert] 
	-- Add the parameters for the stored procedure here
	@ConsignmentDate date,
	@Address1 varchar(150),
	@Address2 varchar(150),
	@Address3 varchar (150),
	@City varchar(50),
	@PhoneNumber varchar(50),
	@CountryISO2 varchar(50),
	@PostCode varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @ConsignmentID int =0
    -- Insert statements for procedure here
	if ((select count (*) from tempConsigment where [ConsignmentDate] =@ConsignmentDate 
	and [Address1] = @Address1 and[Address2] = @Address2  and [Address3] =@Address3 and City =@City
	and PhoneNumber= @PhoneNumber and CountryiSO2= @CountryIso2 and PostCode=@PostCode)> 0)
	begin
	 transaction begin 
	 insert [dbo].[item]
	 select   ItemCode,  Quantity, UnitWeight, null as PackageID
	 
	 from [dbo].[tempConsigment]
	 where [ConsignmentDate] =@ConsignmentDate 
	and [Address1] = @Address1 and[Address2] = @Address2  and [Address3] =@Address3 and City =@City
	and PhoneNumber= @PhoneNumber and CountryiSO2= @CountryIso2 and PostCode=@PostCode 
	
	insert [dbo].[package]
	select  distinct [PackageWidth],[PackageHeight],[PackageDepth], PackageType, null as ConsigmentID
	from [dbo].[tempConsigment]
	 where [ConsignmentDate] =@ConsignmentDate 
	and [Address1] = @Address1 and[Address2] = @Address2  and [Address3] =@Address3 and City =@City
	and PhoneNumber= @PhoneNumber and CountryiSO2= @CountryIso2 and PostCode=@PostCode 
	
	update  [dbo].[item]
	set PackageID = p.PackgeId
	from item  as i join tempConsigment as tC 
	on i.ItemCode=tC.ItemCode and i.Quantity= tc.Quantity 
	and i.UnitWeight= tc.UnitWeight join package as p
	on tc.PackageWidth= p.PackageWidth and tc.PackageDepth= p.PackageDepth and tc.PackageHeight= tc.PackageHeight
		 where [ConsignmentDate] =@ConsignmentDate 
	and [Address1] = @Address1 and[Address2] = @Address2  and [Address3] =@Address3 and City =@City
	and PhoneNumber= @PhoneNumber and CountryiSO2= @CountryIso2 and PostCode=@PostCode
	and i.PackageID is null and p.ConsignmentId is null

	 insert into  consignment
	 ([ConsignmentDate],[Address1], [Address2], [Address3],City, PhoneNumber, CountryISO2,PostCode )
	 values 
	 (@ConsignmentDate ,
	@Address1 ,
	@Address2 ,
	@Address3 ,
	@City ,
	@PhoneNumber ,
	@CountryISO2 ,
	@PostCode)
	 select @ConsignmentID = SCOPE_IDENTITY();
	 update package
	 set  ConsignmentId= @ConsignmentID
	 from package as p join tempConsigment as tc 
	 on  p.PackageWidth=  tc.PackageWidth and p.PackageDepth=tc.PackageDepth
	  and p.PackageDepth =tc.PackageDepth and p.PackageType= tc.PackageType
	 	 where [ConsignmentDate] =@ConsignmentDate 
	and [Address1] = @Address1 and[Address2] = @Address2  and [Address3] =@Address3 and City =@City
	and PhoneNumber= @PhoneNumber and CountryiSO2= @CountryIso2 and PostCode=@PostCode
	and p.ConsignmentId is null
	 delete from tempConsigment
	 where [ConsignmentDate] =@ConsignmentDate 
	and [Address1] = @Address1 and[Address2] = @Address2  and [Address3] =@Address3 and City =@City
	and PhoneNumber= @PhoneNumber and CountryiSO2= @CountryIso2 and PostCode=@PostCode
	  commit  
	  select @ConsignmentID 
	end 
END

GO
/****** Object:  StoredProcedure [TEST].[sp_Consignment_Select]    Script Date: 11/30/2016 1:34:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [TEST].[sp_Consignment_Select] 
	-- Add the parameters for the stored procedure here
 @ConsignmentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select c.ConsignmentId, c.ConsignmentDate,c.Address1, c.Address2, c.Address3, c.City,c.CountryISO2, 
c.PhoneNumber, c.PostCode,p.PackageDepth, p.PackageHeight, p.PackageType, p.PackageWidth, p.PackgeId,
i.ItemId, i.Quantity, i.ItemCode, i.UnitWeight,  tw.totalUnitWeight

from [dbo].[item] as i join  package as p  on i.PackageID=p.PackgeId
join consignment as c on  p.ConsignmentId=c.ConsignmentId 
join ( select ii.PackageID, sum (ii.UnitWeight) as totalUnitWeight    from item  as ii group by PackageID ) as tw
on p.PackgeId=tw.PackageID

 where c.ConsignmentId =@ConsignmentId
 order by totalUnitWeight desc
END

GO
/****** Object:  StoredProcedure [TEST].[sp_TempConsignment_Insert]    Script Date: 11/30/2016 1:34:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [TEST].[sp_TempConsignment_Insert] 
	-- Add the parameters for the stored procedure here
	@ConsignmentDate date,
	@Address1 varchar(150),
	@Address2 varchar(150),
	@Address3 varchar (150),
	@City varchar(50),
	@PhoneNumber varchar(50),
	@CountryISO2 varchar(50),
	@PostCode varchar(20),
	@PackageWidth float,
	@PackageHeight float,
	@PackageDepth float,
	@PackageType varchar(50),
	@ItemCode varchar(50),
	@Quantity int, 
	@UnitWeight float
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into [dbo].[tempConsigment] 
	(ConsignmentDate,
	Address1 ,
	Address2 ,
	Address3 ,
	City ,
	PhoneNumber ,
	CountryISO2 ,
	PostCode,
	PackageWidth,
	PackageHeight,
	PackageDepth,
	PackageType ,
	ItemCode ,
	Quantity , 
	UnitWeight )
	values (
	@ConsignmentDate,
	@Address1 ,
	@Address2 ,
	@Address3 ,
	@City ,
	@PhoneNumber ,
	@CountryISO2 ,
	@PostCode,
	@PackageWidth,
	@PackageHeight,
	@PackageDepth,
	@PackageType ,
	@ItemCode ,
	@Quantity , 
	@UnitWeight)
END

GO
USE [master]
GO
ALTER DATABASE [polina_test] SET  READ_WRITE 
GO
