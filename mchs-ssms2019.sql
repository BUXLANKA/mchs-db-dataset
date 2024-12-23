USE [master]
GO
/****** Object:  Database [MCHS]    Script Date: 16.12.2024 16:40:04 ******/
CREATE DATABASE [MCHS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MCHS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\MCHS.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MCHS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\MCHS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MCHS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MCHS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MCHS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MCHS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MCHS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MCHS] SET ARITHABORT OFF 
GO
ALTER DATABASE [MCHS] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [MCHS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MCHS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MCHS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MCHS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MCHS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MCHS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MCHS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MCHS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MCHS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MCHS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MCHS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MCHS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MCHS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MCHS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MCHS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MCHS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MCHS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MCHS] SET  MULTI_USER 
GO
ALTER DATABASE [MCHS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MCHS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MCHS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MCHS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MCHS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MCHS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [MCHS] SET QUERY_STORE = ON
GO
ALTER DATABASE [MCHS] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MCHS]
GO
/****** Object:  User [s_admin]    Script Date: 16.12.2024 16:40:04 ******/
CREATE USER [s_admin] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [s_admin]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [s_admin]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [s_admin]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [s_admin]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [s_admin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [s_admin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [s_admin]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [s_admin]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [s_admin]
GO
/****** Object:  Table [dbo].[UserData]    Script Date: 16.12.2024 16:40:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserData](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Firstname] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[Lastname] [varchar](50) NULL,
	[PositionID] [int] NOT NULL,
	[Phone] [varchar](12) NOT NULL,
	[Email] [varchar](30) NOT NULL,
	[Login] [varchar](20) NOT NULL,
	[Password] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PositionList]    Script Date: 16.12.2024 16:40:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PositionList](
	[PositionID] [int] IDENTITY(1,1) NOT NULL,
	[PositionName] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Position__60BB9A59CDDE45CC] PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[UserDataTableView]    Script Date: 16.12.2024 16:40:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[UserDataTableView] as
select
	UserData.UserID,
	userdata.Firstname,
	userdata.Surname,
	userdata.Lastname,
	PositionList.PositionName as Position,
	userdata.Phone,
	userdata.Email,
	userdata.Login,
	userdata.Password
from UserData
join PositionList on UserData.PositionID = PositionList.PositionID;
GO
/****** Object:  Table [dbo].[Emergencies]    Script Date: 16.12.2024 16:40:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Emergencies](
	[EmergencyID] [int] IDENTITY(1,1) NOT NULL,
	[EmTypeID] [int] NOT NULL,
	[Description] [varchar](max) NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[RegID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmergencyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Regions]    Script Date: 16.12.2024 16:40:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Regions](
	[RegID] [int] IDENTITY(1,1) NOT NULL,
	[RegName] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RegID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmergTypeList]    Script Date: 16.12.2024 16:40:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmergTypeList](
	[EmTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Typename] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusList]    Script Date: 16.12.2024 16:40:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusList](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[Statusname] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[EmergencyTableView]    Script Date: 16.12.2024 16:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [dbo].[EmergencyTableView] as
select
	e.EmergencyID,
	etl.Typename as Type,
	e.Description,
	e.StartDate,
	e.EndDate,
	reg.RegName as Region,
	e.UserID,
	sl.Statusname
from Emergencies e
join EmergTypeList etl on e.EmTypeID = etl.EmTypeID
join Regions reg on e.RegID = reg.RegID
join StatusList sl on e.StatusID = sl.StatusID
GO
SET IDENTITY_INSERT [dbo].[Emergencies] ON 

INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (1, 27, N'empty', CAST(N'2024-03-01T00:00:00.000' AS DateTime), CAST(N'2024-03-02T00:00:00.000' AS DateTime), 3, 3, 1)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (2, 3, N'empty', CAST(N'2024-03-02T00:00:00.000' AS DateTime), CAST(N'2024-03-03T00:00:00.000' AS DateTime), 7, 3, 1)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (3, 5, N'empty', CAST(N'2024-03-03T00:00:00.000' AS DateTime), CAST(N'2024-03-04T00:00:00.000' AS DateTime), 7, 1, 3)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (4, 21, N'empty', CAST(N'2024-03-04T00:00:00.000' AS DateTime), CAST(N'2024-03-05T00:00:00.000' AS DateTime), 1, 5, 3)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (5, 13, N'empty', CAST(N'2024-03-05T00:00:00.000' AS DateTime), CAST(N'2024-03-06T00:00:00.000' AS DateTime), 4, 23, 3)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (6, 22, N'empty', CAST(N'2024-03-06T00:00:00.000' AS DateTime), CAST(N'2024-03-07T00:00:00.000' AS DateTime), 5, 19, 1)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (7, 26, N'empty', CAST(N'2024-03-07T00:00:00.000' AS DateTime), CAST(N'2024-03-08T00:00:00.000' AS DateTime), 7, 11, 2)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (8, 22, N'empty', CAST(N'2024-03-08T00:00:00.000' AS DateTime), CAST(N'2024-03-09T00:00:00.000' AS DateTime), 1, 29, 1)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (9, 22, N'empty', CAST(N'2024-03-09T00:00:00.000' AS DateTime), CAST(N'2024-03-10T00:00:00.000' AS DateTime), 2, 9, 2)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (10, 1, N'empty', CAST(N'2024-03-10T00:00:00.000' AS DateTime), CAST(N'2024-03-11T00:00:00.000' AS DateTime), 3, 13, 2)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (11, 16, N'empty', CAST(N'2024-03-11T00:00:00.000' AS DateTime), CAST(N'2024-03-12T00:00:00.000' AS DateTime), 8, 17, 1)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (12, 24, N'empty', CAST(N'2024-03-12T00:00:00.000' AS DateTime), CAST(N'2024-03-13T00:00:00.000' AS DateTime), 1, 21, 3)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (13, 10, N'empty', CAST(N'2024-03-13T00:00:00.000' AS DateTime), CAST(N'2024-03-14T00:00:00.000' AS DateTime), 6, 18, 3)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (14, 2, N'empty', CAST(N'2024-03-14T00:00:00.000' AS DateTime), CAST(N'2024-03-15T00:00:00.000' AS DateTime), 2, 21, 2)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (15, 25, N'empty', CAST(N'2024-03-15T00:00:00.000' AS DateTime), CAST(N'2024-03-16T00:00:00.000' AS DateTime), 7, 27, 2)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (16, 13, N'empty', CAST(N'2024-03-16T00:00:00.000' AS DateTime), CAST(N'2024-03-17T00:00:00.000' AS DateTime), 6, 21, 2)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (17, 8, N'empty', CAST(N'2024-03-17T00:00:00.000' AS DateTime), CAST(N'2024-03-18T00:00:00.000' AS DateTime), 6, 3, 1)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (18, 8, N'empty', CAST(N'2024-03-18T00:00:00.000' AS DateTime), CAST(N'2024-03-19T00:00:00.000' AS DateTime), 5, 1, 3)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (20, 1, N'-', CAST(N'2024-03-21T00:00:00.000' AS DateTime), CAST(N'2024-11-14T00:00:00.000' AS DateTime), 1, 1, 2)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (21, 1, N'empty', CAST(N'2024-03-29T00:00:00.000' AS DateTime), CAST(N'2024-10-10T00:00:00.000' AS DateTime), 3, 1, 3)
INSERT [dbo].[Emergencies] ([EmergencyID], [EmTypeID], [Description], [StartDate], [EndDate], [RegID], [UserID], [StatusID]) VALUES (22, 8, N'взрыв газа в жилом дома', CAST(N'2024-03-18T00:00:00.000' AS DateTime), CAST(N'2024-03-19T00:00:00.000' AS DateTime), 6, 4, 2)
SET IDENTITY_INSERT [dbo].[Emergencies] OFF
GO
SET IDENTITY_INSERT [dbo].[EmergTypeList] ON 

INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (1, N'Пожар')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (2, N'Наводнение')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (3, N'Землетрясение')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (4, N'Ураган')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (5, N'Оползень')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (6, N'Сель')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (7, N'Снежная лавина')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (8, N'Взрыв')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (9, N'Химическая авария')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (10, N'Биологическая угроза')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (11, N'Радиационная авария')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (12, N'Авария на транспорте')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (13, N'Техногенная катастрофа')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (14, N'Затопление')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (15, N'Обрушение здания')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (16, N'Массовое ДТП')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (17, N'Загрязнение окружающей среды')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (18, N'Террористический акт')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (19, N'Эпидемия')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (20, N'Пандемия')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (21, N'Гидродинамическая авария')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (22, N'Лесной пожар')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (23, N'Токсический выброс')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (24, N'Электроэнергетическая авария')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (25, N'Пылевая буря')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (26, N'Солнечная активность')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (27, N'Авария на плотине')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (28, N'Засуха')
INSERT [dbo].[EmergTypeList] ([EmTypeID], [Typename]) VALUES (29, N'Авария на атомной станции')
SET IDENTITY_INSERT [dbo].[EmergTypeList] OFF
GO
SET IDENTITY_INSERT [dbo].[PositionList] ON 

INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (1, N'Спасатель')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (2, N'Инспектор')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (3, N'Пожарный')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (4, N'Водитель')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (5, N'Инженер')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (6, N'Зам.начальника')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (7, N'Диспетчер')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (8, N'Системный администратор')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (9, N'Оператор БД')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (10, N'Сетевой администратор')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (11, N'Администратор серверов')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (12, N'Специалист по информационной безопасности')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (13, N'Технический специалист')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (14, N'Инженер по технической поддержке')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (15, N'Младший системный администратор')
INSERT [dbo].[PositionList] ([PositionID], [PositionName]) VALUES (16, N'Начальник')
SET IDENTITY_INSERT [dbo].[PositionList] OFF
GO
SET IDENTITY_INSERT [dbo].[Regions] ON 

INSERT [dbo].[Regions] ([RegID], [RegName]) VALUES (1, N'Автозаводский')
INSERT [dbo].[Regions] ([RegID], [RegName]) VALUES (2, N'Канавинский')
INSERT [dbo].[Regions] ([RegID], [RegName]) VALUES (3, N'Ленинский')
INSERT [dbo].[Regions] ([RegID], [RegName]) VALUES (4, N'Московский')
INSERT [dbo].[Regions] ([RegID], [RegName]) VALUES (5, N'Нижегородский')
INSERT [dbo].[Regions] ([RegID], [RegName]) VALUES (6, N'Приокский')
INSERT [dbo].[Regions] ([RegID], [RegName]) VALUES (7, N'Советский')
INSERT [dbo].[Regions] ([RegID], [RegName]) VALUES (8, N'Сормовский')
SET IDENTITY_INSERT [dbo].[Regions] OFF
GO
SET IDENTITY_INSERT [dbo].[StatusList] ON 

INSERT [dbo].[StatusList] ([StatusID], [Statusname]) VALUES (1, N'В работе')
INSERT [dbo].[StatusList] ([StatusID], [Statusname]) VALUES (2, N'Завершён')
INSERT [dbo].[StatusList] ([StatusID], [Statusname]) VALUES (3, N'Отменён')
SET IDENTITY_INSERT [dbo].[StatusList] OFF
GO
SET IDENTITY_INSERT [dbo].[UserData] ON 

INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (1, N'Алексей', N'Иванов', N'Сергеевич', 1, N'89031234567', N'ivanov@mchs.ru', N'ivanov_a', N'#9gpw-Cu')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (2, N'Дмитрий', N'Смирнов', N'Викторович', 2, N'89039876543', N'smirnov@mchs.ru', N'smirnov_d', N'@5_W"f0R')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (3, N'Иван', N'Кузнецов', N'Алексеевич', 3, N'89037654321', N'kuznetsov@mchs.ru', N'kuznetsov_i', N'a9jl`XX#')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (4, N'Сергей', N'Попов', N'Иванович', 4, N'89036543210', N'popov@mchs.ru', N'popov', N'o4fGTN%]')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (5, N'Михаил', N'Васильев', N'Дмитриевич', 1, N'89031237654', N'vasilev@mchs.ru', N'vasilev_m', N'xUQV5~J&')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (6, N'Александр', N'Соколов', N'Сергеевич', 5, N'89035432198', N'sokolov@mchs.ru', N'sokolov_a', N'0`0OUyBy')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (7, N'Владимир', N'Михайлов', N'Олегович', 6, N'89037654987', N'mikhailov@mchs.ru', N'mikhailov_v', N'Fe`;dFg3')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (8, N'Андрей', N'Фёдоров', N'Николаевич', 7, N'89039874356', N'fedorov@mchs.ru', N'fedorov_a', N'sO^q&A;6')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (9, N'Евгений', N'Морозов', N'Сергеевич', 3, N'89031437654', N'morozov@mchs.ru', N'morozov_e', N'7+k6Vlpg')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (10, N'Антон', N'Новиков', N'Дмитриевич', 4, N'89031249876', N'novikov@mchs.ru', N'novikov_a', N'<]3;fX$w')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (11, N'Станислав', N'Беляев', N'Александрович', 1, N'89036789012', N'belyaev@mchs.ru', N'belyaev_s', N'p7yU_`T}')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (12, N'Николай', N'Волков', N'Викторович', 2, N'89038974321', N'volkov@mchs.ru', N'volkov_n', N';_*zYr5N')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (13, N'Олег', N'Медведев', N'Павлович', 3, N'89037651234', N'medvedev@mchs.ru', N'medvedev_o', N']Im5a/+*')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (14, N'Артем', N'Сидоров', N'Андреевич', 4, N'89031239876', N'sidorov@mchs.ru', N'sidorov_a', N'K{7W-gek')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (15, N'Игорь', N'Павлов', N'Игоревич', 5, N'89038975321', N'pavlov@mchs.ru', N'pavlov_i', N'4Ve3Ks?{')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (16, N'Юрий', N'Васильев', N'Николаевич', 6, N'89031257643', N'vasilev_y@mchs.ru', N'vasilev_y', N'Bt:+''8}*')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (17, N'Анатолий', N'Захаров', N'Сергеевич', 1, N'89039871234', N'zakharov@mchs.ru', N'zakharov_a', N'safetySave')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (18, N'Григорий', N'Титов', N'Дмитриевич', 2, N'89039875432', N'titov@mchs.ru', N'titov_g', N'?mnD&5AG')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (19, N'Константин', N'Орлов', N'Иванович', 3, N'89037358581', N'orlov@mchs.ru', N'orlov_k', N'}Xu1:''pY')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (20, N'Виталий', N'Крылов', N'Сергеевич', 4, N'89037659843', N'krylov@mchs.ru', N'krylov_v', N')M26utC0')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (21, N'Борис', N'Романов', N'Дмитриевич', 1, N'89031239812', N'romanov@mchs.ru', N'romanov_b', N'3F43ax&T')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (22, N'Петр', N'Богданов', N'Викторович', 2, N'89039874567', N'bogdanov@mchs.ru', N'bogdanov_p', N'_V8p3iB+')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (23, N'Вячеслав', N'Тимофеев', N'Александрович', 3, N'89037653421', N'timofeev@mchs.ru', N'timofeev_v', N'Fogp1y)4')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (24, N'Семен', N'Васильев', N'Олегович', 4, N'89031239823', N'svasilev@mchs.ru', N'vasilev_s', N'9I9/qmE)')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (25, N'Егор', N'Ефимов', N'Павлович', 5, N'89037654213', N'efimov@mchs.ru', N'efimov_e', N'|=VeY2k_')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (26, N'Максим', N'Никитин', N'Алексеевич', 6, N'89031235678', N'nikitin@mchs.ru', N'nikitin_m', N'H@;''Nai4')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (27, N'Владислав', N'Марков', N'Дмитриевич', 1, N'89031234987', N'markov@mchs.ru', N'markov_v', N'+LqdU1S~')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (28, N'Роман', N'Захаров', N'Викторович', 2, N'89037654312', N'zakharov_r@mchs.ru', N'zakharov_r', N'`E|0sfY6')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (29, N'Алексей', N'Зуев', N'Александрович', 3, N'89031234965', N'zuev@mchs.ru', N'zuev_a', N'D2}vbY*&')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (30, N'Иван', N'Киселев', N'Олегович', 4, N'89031298765', N'kiselev@mchs.ru', N'kiselev_i', N',R7mX>1r')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (31, N'Андрей', N'Лебедев', N'Артемович', 8, N'89038967654', N'levedev@mchs.ru', N'levedev_a', N'vMJ&K6]T')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (32, N'Юрий', N'Григорьев', N'Игоревич', 9, N'89036549876', N'grigorev@mchs.ru', N'grigorev_y', N'xH%>3"JF')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (33, N'Роман', N'Чернов', N'Александрович', 10, N'89035246789', N'chernov@mchs.ru', N'chernov_r', N'wIZ9L|~m')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (34, N'Марина', N'Белова', N'Юрьевна', 11, N'89031365498', N'belova@mchs.ru', N'belova_m', N'$_?=z7<O')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (35, N'Тимур', N'Логинов', N'Валерьевич', 12, N'89037609854', N'loginov@mchs.ru', N'loginov_t', N'TJ4P["rz')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (36, N'Анатолий', N'Шевченко', N'Павлович', 13, N'89039874521', N'shevchenko@mchs.ru', N'shevchenko_a', N'|4uA}sUx')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (37, N'Иван', N'Никифоров', N'Дмитриевич', 15, N'89034567890', N'nikiforov@mchs.ru', N'nikiforov_i', N'P_B7g;=''')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (38, N'Петр', N'Егорьев', N'Александрович', 16, N'89031234500', N'egoryev@mchs.ru', N'egoryev_p', N'Zr1ggKW`')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (39, N'test', N'test', N'test', 9, N'81234561213', N'test@test.test', N'admin', N'admin')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (42, N'user2', N'user2', N'user2', 1, N'87654321423', N'user@test.test', N'user', N'user')
INSERT [dbo].[UserData] ([UserID], [Firstname], [Surname], [Lastname], [PositionID], [Phone], [Email], [Login], [Password]) VALUES (43, N'user3', N'user3', N'user3', 7, N'89000000000', N'user3@test.test', N'disp', N'disp')
SET IDENTITY_INSERT [dbo].[UserData] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__UserData__5C7E359E25AA14E5]    Script Date: 16.12.2024 16:40:05 ******/
ALTER TABLE [dbo].[UserData] ADD UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__UserData__5E55825B959D1B76]    Script Date: 16.12.2024 16:40:05 ******/
ALTER TABLE [dbo].[UserData] ADD UNIQUE NONCLUSTERED 
(
	[Login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__UserData__87909B15BC98D1D2]    Script Date: 16.12.2024 16:40:05 ******/
ALTER TABLE [dbo].[UserData] ADD UNIQUE NONCLUSTERED 
(
	[Password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__UserData__A9D105345EF6C239]    Script Date: 16.12.2024 16:40:05 ******/
ALTER TABLE [dbo].[UserData] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Emergencies] ADD  DEFAULT (getdate()) FOR [StartDate]
GO
ALTER TABLE [dbo].[Emergencies] ADD  DEFAULT (getdate()) FOR [EndDate]
GO
ALTER TABLE [dbo].[Emergencies]  WITH CHECK ADD  CONSTRAINT [FK_Emergencies_EmTypeID] FOREIGN KEY([EmTypeID])
REFERENCES [dbo].[EmergTypeList] ([EmTypeID])
GO
ALTER TABLE [dbo].[Emergencies] CHECK CONSTRAINT [FK_Emergencies_EmTypeID]
GO
ALTER TABLE [dbo].[Emergencies]  WITH CHECK ADD  CONSTRAINT [FK_Emergencies_RegID] FOREIGN KEY([RegID])
REFERENCES [dbo].[Regions] ([RegID])
GO
ALTER TABLE [dbo].[Emergencies] CHECK CONSTRAINT [FK_Emergencies_RegID]
GO
ALTER TABLE [dbo].[Emergencies]  WITH CHECK ADD  CONSTRAINT [FK_Emergencies_StatusID] FOREIGN KEY([StatusID])
REFERENCES [dbo].[StatusList] ([StatusID])
GO
ALTER TABLE [dbo].[Emergencies] CHECK CONSTRAINT [FK_Emergencies_StatusID]
GO
ALTER TABLE [dbo].[Emergencies]  WITH CHECK ADD  CONSTRAINT [FK_Emergencies_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserData] ([UserID])
GO
ALTER TABLE [dbo].[Emergencies] CHECK CONSTRAINT [FK_Emergencies_UserID]
GO
ALTER TABLE [dbo].[UserData]  WITH CHECK ADD  CONSTRAINT [FK_UserData_Position] FOREIGN KEY([PositionID])
REFERENCES [dbo].[PositionList] ([PositionID])
GO
ALTER TABLE [dbo].[UserData] CHECK CONSTRAINT [FK_UserData_Position]
GO
ALTER TABLE [dbo].[UserData]  WITH CHECK ADD  CONSTRAINT [CK_EmailFormat] CHECK  (([Email] like '%_@__%.__%'))
GO
ALTER TABLE [dbo].[UserData] CHECK CONSTRAINT [CK_EmailFormat]
GO
ALTER TABLE [dbo].[UserData]  WITH CHECK ADD  CONSTRAINT [CK_PhoneFormat] CHECK  (([Phone] like '[7-8][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[UserData] CHECK CONSTRAINT [CK_PhoneFormat]
GO
USE [master]
GO
ALTER DATABASE [MCHS] SET  READ_WRITE 
GO
