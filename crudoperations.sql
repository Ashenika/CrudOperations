/*
 Navicat Premium Data Transfer

 Source Server         : MS_SQL_Server
 Source Server Type    : SQL Server
 Source Server Version : 15002000
 Source Host           : DESKTOP-6ERJC9K:1433
 Source Catalog        : dockyard
 Source Schema         : dbo

 Target Server Type    : SQL Server
 Target Server Version : 15002000
 File Encoding         : 65001

 Date: 03/02/2021 11:14:13
*/


-- ----------------------------
-- Table structure for Job
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Job]') AND type IN ('U'))
	DROP TABLE [dbo].[Job]
GO

CREATE TABLE [dbo].[Job] (
  [JobTitle] nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [JobImage] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [CityId] int  NULL,
  [IsActive] bit  NULL,
  [CreatedBY] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [CreatedDateTime] datetime2(7)  NULL,
  [UpdatedBY] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [UpdatedDateTime] datetime2(7)  NULL,
  [JobID] int  IDENTITY(1,1) NOT NULL
)
GO

ALTER TABLE [dbo].[Job] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of Job
-- ----------------------------
SET IDENTITY_INSERT [dbo].[Job] ON
GO

INSERT INTO [dbo].[Job] ([JobTitle], [JobImage], [CityId], [IsActive], [CreatedBY], [CreatedDateTime], [UpdatedBY], [UpdatedDateTime], [JobID]) VALUES (N'Ashe', N'1200px-Winkel_triple_projection_SW.jpg', N'2', N'1', N'1', N'2021-01-21 20:13:45.9766667', N'1', N'2021-01-21 20:28:13.3333333', N'1')
GO

INSERT INTO [dbo].[Job] ([JobTitle], [JobImage], [CityId], [IsActive], [CreatedBY], [CreatedDateTime], [UpdatedBY], [UpdatedDateTime], [JobID]) VALUES (N'Ash', N'100ed15441fd2e89706fa1ae5181dcdb.jpg', N'1', N'1', N'1', N'2021-01-21 20:15:55.4666667', N'1', N'2021-01-21 20:15:55.4666667', N'2')
GO

INSERT INTO [dbo].[Job] ([JobTitle], [JobImage], [CityId], [IsActive], [CreatedBY], [CreatedDateTime], [UpdatedBY], [UpdatedDateTime], [JobID]) VALUES (N'Ash', N'100ed15441fd2e89706fa1ae5181dcdb.jpg', N'2', N'1', N'1', N'2021-01-21 20:20:06.2233333', N'1', N'2021-01-21 20:20:06.2233333', N'3')
GO

SET IDENTITY_INSERT [dbo].[Job] OFF
GO


-- ----------------------------
-- Procedure structure for SP_Add_Job
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_Add_Job]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE[dbo].[SP_Add_Job]
GO

CREATE PROCEDURE [dbo].[SP_Add_Job]
  @JobTitle NVARCHAR(250) ,      
    @JobImage NVARCHAR(Max) ,      
    @CityId int ,      
    @IsActive BIT ,      
    @CreatedBY NVARCHAR(50) ,      
    @CreatedDateTime DATETIME ,      
    @UpdatedBY NVARCHAR(50),    
    @UpdatedDateTime DATETIME  
AS
BEGIN
	-- routine body goes here, e.g.
	-- SELECT 'Navicat for SQL Server'
	DECLARE @JobId as BIGINT    
        INSERT  INTO [Job]      
                (JobTitle ,      
                 JobImage ,      
                 CityId ,      
                 IsActive ,      
                 CreatedBY ,      
                 CreatedDateTime ,      
                 UpdatedBY ,      
                 UpdatedDateTime    
             )      
        VALUES  ( @JobTitle ,      
                  @JobImage ,      
                  @CityId ,      
                  @IsActive ,      
                  @CreatedBY ,        
                  @CreatedDateTime ,     
                  @UpdatedBY ,      
                  @UpdatedDateTime                      
                      
             );     
        SET @JobId = SCOPE_IDENTITY();     
        SELECT  @JobId AS JobId; 
END
GO


-- ----------------------------
-- Procedure structure for SP_Update_Job
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_Update_Job]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE[dbo].[SP_Update_Job]
GO

CREATE PROCEDURE [dbo].[SP_Update_Job]
    @JobId INT,  
    @JobTitle NVARCHAR(250) ,        
    @JobImage NVARCHAR(Max) ,        
    @CityId INT ,        
    @IsActive BIT ,    
    @UpdatedBY NVARCHAR(50),      
    @UpdatedDateTime DATETIME   
AS
BEGIN
	-- routine body goes here, e.g.
	-- SELECT 'Navicat for SQL Server'
	 UPDATE job   
     SET    
            job.JobTitle = @JobTitle,    
            job.JobImage = @JobImage ,    
            job.CityId = @CityId ,    
            job.IsActive = @IsActive ,    
            job.UpdatedBY = @UpdatedBY ,    
            job.UpdatedDateTime = @UpdatedDateTime  
  FROM [Job] job    
  WHERE JobId = @JobId
END
GO


-- ----------------------------
-- Procedure structure for SP_Job_List
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_Job_List]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE[dbo].[SP_Job_List]
GO

CREATE PROCEDURE [dbo].[SP_Job_List]

AS
BEGIN
	-- routine body goes here, e.g.
	-- SELECT 'Navicat for SQL Server'
	  SET NOCOUNT ON;  
    select * from [Job]   
END
GO


-- ----------------------------
-- Primary Key structure for table Job
-- ----------------------------
ALTER TABLE [dbo].[Job] ADD CONSTRAINT [PK__Job__056690E2795FBC1C] PRIMARY KEY CLUSTERED ([JobID])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

