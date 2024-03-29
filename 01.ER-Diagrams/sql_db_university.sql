USE [master]
GO
/****** Object:  Database [University]    Script Date: 13.7.2013 г. 14:45:45 ч. ******/
CREATE DATABASE [University]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'University', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\University.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'University_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\University_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [University] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [University].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [University] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [University] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [University] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [University] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [University] SET ARITHABORT OFF 
GO
ALTER DATABASE [University] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [University] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [University] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [University] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [University] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [University] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [University] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [University] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [University] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [University] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [University] SET  DISABLE_BROKER 
GO
ALTER DATABASE [University] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [University] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [University] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [University] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [University] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [University] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [University] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [University] SET RECOVERY FULL 
GO
ALTER DATABASE [University] SET  MULTI_USER 
GO
ALTER DATABASE [University] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [University] SET DB_CHAINING OFF 
GO
ALTER DATABASE [University] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [University] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'University', N'ON'
GO
USE [University]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 13.7.2013 г. 14:45:45 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[Course_ID] [int] IDENTITY(1,1) NOT NULL,
	[Course_name] [nvarchar](30) NOT NULL,
	[Department_ID] [int] NOT NULL,
	[Professor_ID] [int] NOT NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Departments]    Script Date: 13.7.2013 г. 14:45:46 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[Department_ID] [int] IDENTITY(1,1) NOT NULL,
	[Department_name] [nvarchar](30) NOT NULL,
	[Faculty_ID] [int] NOT NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[Department_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faculties]    Script Date: 13.7.2013 г. 14:45:46 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faculties](
	[Faculty_ID] [int] IDENTITY(1,1) NOT NULL,
	[Faculty_name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Faculties] PRIMARY KEY CLUSTERED 
(
	[Faculty_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Profesors]    Script Date: 13.7.2013 г. 14:45:46 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profesors](
	[Professor_ID] [int] IDENTITY(1,1) NOT NULL,
	[Professor_name] [nvarchar](10) NOT NULL,
	[Department_ID] [int] NOT NULL,
 CONSTRAINT [PK_Profesors] PRIMARY KEY CLUSTERED 
(
	[Professor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Professors_Titles]    Script Date: 13.7.2013 г. 14:45:46 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Professors_Titles](
	[Professor_ID] [int] NOT NULL,
	[Title_ID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Students]    Script Date: 13.7.2013 г. 14:45:46 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Student_ID] [int] IDENTITY(1,1) NOT NULL,
	[Student_name] [nvarchar](10) NOT NULL,
	[Faculty_ID] [int] NOT NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Students_courses]    Script Date: 13.7.2013 г. 14:45:46 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students_courses](
	[Student_ID] [int] NOT NULL,
	[Course_ID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Titles]    Script Date: 13.7.2013 г. 14:45:46 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Titles](
	[Title_ID] [int] NOT NULL,
	[Title_name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Titles] PRIMARY KEY CLUSTERED 
(
	[Title_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_Departments] FOREIGN KEY([Department_ID])
REFERENCES [dbo].[Departments] ([Department_ID])
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK_Courses_Departments]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_Profesors] FOREIGN KEY([Professor_ID])
REFERENCES [dbo].[Profesors] ([Professor_ID])
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK_Courses_Profesors]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [FK_Departments_Faculties] FOREIGN KEY([Faculty_ID])
REFERENCES [dbo].[Faculties] ([Faculty_ID])
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [FK_Departments_Faculties]
GO
ALTER TABLE [dbo].[Profesors]  WITH CHECK ADD  CONSTRAINT [FK_Profesors_Departments] FOREIGN KEY([Department_ID])
REFERENCES [dbo].[Departments] ([Department_ID])
GO
ALTER TABLE [dbo].[Profesors] CHECK CONSTRAINT [FK_Profesors_Departments]
GO
ALTER TABLE [dbo].[Professors_Titles]  WITH CHECK ADD  CONSTRAINT [FK_Professors_Titles_Profesors] FOREIGN KEY([Professor_ID])
REFERENCES [dbo].[Profesors] ([Professor_ID])
GO
ALTER TABLE [dbo].[Professors_Titles] CHECK CONSTRAINT [FK_Professors_Titles_Profesors]
GO
ALTER TABLE [dbo].[Professors_Titles]  WITH CHECK ADD  CONSTRAINT [FK_Professors_Titles_Titles] FOREIGN KEY([Title_ID])
REFERENCES [dbo].[Titles] ([Title_ID])
GO
ALTER TABLE [dbo].[Professors_Titles] CHECK CONSTRAINT [FK_Professors_Titles_Titles]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Faculties] FOREIGN KEY([Faculty_ID])
REFERENCES [dbo].[Faculties] ([Faculty_ID])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Faculties]
GO
ALTER TABLE [dbo].[Students_courses]  WITH CHECK ADD  CONSTRAINT [FK_Students_courses_Courses] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Courses] ([Course_ID])
GO
ALTER TABLE [dbo].[Students_courses] CHECK CONSTRAINT [FK_Students_courses_Courses]
GO
ALTER TABLE [dbo].[Students_courses]  WITH CHECK ADD  CONSTRAINT [FK_Students_courses_Students] FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Students] ([Student_ID])
GO
ALTER TABLE [dbo].[Students_courses] CHECK CONSTRAINT [FK_Students_courses_Students]
GO
USE [master]
GO
ALTER DATABASE [University] SET  READ_WRITE 
GO
