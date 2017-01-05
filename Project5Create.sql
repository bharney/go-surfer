USE [master]
GO
/****** Object:  Database [GoSurfer]    Script Date: 5/12/2015 9:08:35 PM ******/
CREATE DATABASE [GoSurfer]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GoSurfer', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\GoSurfer.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'GoSurfer_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\GoSurfer_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [GoSurfer] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GoSurfer].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GoSurfer] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GoSurfer] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GoSurfer] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GoSurfer] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GoSurfer] SET ARITHABORT OFF 
GO
ALTER DATABASE [GoSurfer] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GoSurfer] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [GoSurfer] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GoSurfer] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GoSurfer] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GoSurfer] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GoSurfer] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GoSurfer] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GoSurfer] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GoSurfer] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GoSurfer] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GoSurfer] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GoSurfer] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GoSurfer] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GoSurfer] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GoSurfer] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GoSurfer] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GoSurfer] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GoSurfer] SET RECOVERY FULL 
GO
ALTER DATABASE [GoSurfer] SET  MULTI_USER 
GO
ALTER DATABASE [GoSurfer] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GoSurfer] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GoSurfer] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GoSurfer] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'GoSurfer', N'ON'
GO
USE [GoSurfer]
GO
/****** Object:  Table [dbo].[Catalog]    Script Date: 5/12/2015 9:08:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Catalog](
	[CatalogID] [int] IDENTITY(1,1) NOT NULL,
	[CatalogName] [ntext] NOT NULL,
	[CatalogDescription] [nvarchar](max) NULL,
	[CatalogImage] [nvarchar](max) NULL,
	[ParentCatalogID] [int] NULL,
	[CatalogURL] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Catalog] PRIMARY KEY CLUSTERED 
(
	[CatalogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 5/12/2015 9:08:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[ProductDescription] [nvarchar](max) NOT NULL,
	[ProductImageURL] [nvarchar](max) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[ProductCatalog] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[ProductDetailURL] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Review]    Script Date: 5/12/2015 9:08:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[ReviewUserID] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Date] [datetime] NOT NULL,
	[ProductID] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 5/12/2015 9:08:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[CartSessionID] [nvarchar](max) NOT NULL,
	[ProductID] [int] NOT NULL,
	[OrderQty] [int] NOT NULL,
	[DateTimeCreated] [datetime] NOT NULL,
	[ProductDescription] [nvarchar](max) NOT NULL,
	[ProductImageURL] [nvarchar](max) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[ProductDetailURL] [nvarchar](max) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ShoppingCart] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 5/12/2015 9:08:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[Address1] [nvarchar](max) NULL,
	[Address2] [nvarchar](max) NULL,
	[State] [nvarchar](max) NULL,
	[City] [nvarchar](max) NULL,
	[Zip] [nvarchar](max) NULL,
	[Country] [nvarchar](max) NULL,
	[Phone] [nvarchar](max) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_ProductImageURL]  DEFAULT ((1)) FOR [ProductImageURL]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_ProductDetailURL]  DEFAULT ('ProductDetails.aspx') FOR [ProductDetailURL]
GO
ALTER TABLE [dbo].[Review] ADD  CONSTRAINT [DF_Review_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[ShoppingCart] ADD  CONSTRAINT [DF_ShoppingCart_DateTimeCreated]  DEFAULT (getdate()) FOR [DateTimeCreated]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Catalog] FOREIGN KEY([ProductCatalog])
REFERENCES [dbo].[Catalog] ([CatalogID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Catalog]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_Product]
GO
USE [master]
GO
ALTER DATABASE [GoSurfer] SET  READ_WRITE 
GO
