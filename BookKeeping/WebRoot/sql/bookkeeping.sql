USE [BillAssistant]
GO
/****** Object:  StoredProcedure [dbo].[up_addBookkeep]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[up_addBookkeep]
	@userid as varchar(50), --记账用户id
	@money as float,--金额
	@datetime as datetime,--记账时间
	@payid as int,--支付类型id
	@sortid as int,--分类类型id
	@type as int,--记账类型
	@remark as text--记账备注
as
begin
	begin tran --开始事物
	declare @error as int
	declare @result as int --返回受影响行数
	declare @count as int --接收受影响行数
	set @count = 0
	set @result = 0
	set @error = 0

	--更新记账记录
	insert into T_Bookkeeping values(@userid,@money,@datetime,@payid,@sortid,@type,@remark)
		set @count=+@@ROWCOUNT
		set @error =@@ERROR +@error
	if @@ERROR = 0
	begin
		set @result = @count  -- 获取受影响行数
	end
	--计算金额变量
	--更新用户金额
	if @type=0
	begin
	update T_User set totalmoney=totalmoney-@money where userid=@userid
		set @count=+@@ROWCOUNT
		set @error =@@ERROR +@error 
	end
	else
	begin
	update T_User set totalmoney=totalmoney+@money where userid=@userid
		set @count=+@@ROWCOUNT
		set @error =@@ERROR +@error
	end
	if @error = 0
	begin
		set @result = @count  -- 获取受影响行数
	end

	if @error = 0
	begin
		commit tran -- 提交事务
		return 1 --代表成功
	end
	else
	begin
		rollback tran -- 回滚事务
		return 0 --代表失败
	end
end

GO
/****** Object:  StoredProcedure [dbo].[up_addUser]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[up_addUser]
	@userid as varchar(50), --用户id
	@username as varchar(50),--用户名
	@pwd as varchar(50) --密码
as
begin
	begin tran --开始事物
	declare @error as int
	declare @result as int --返回受影响行数
	declare @count as int --接收受影响行数
	set @count = 0
	set @result = 0
	set @error = 0

	--用户注册
	insert into T_User values(@userid,@username,@pwd,0)
		set @count=+@@ROWCOUNT
		set @error =@@ERROR +@error
	if @@ERROR = 0
	begin
		set @result = @count  -- 获取受影响行数
	end
	--为新用户添加默认分类
	insert into T_UserAndSortType values(@userid,13),(@userid,14),(@userid,29),
	(@userid,30),(@userid,31),(@userid,32),(@userid,9),(@userid,10),(@userid,11),
	(@userid,12),(@userid,21),(@userid,22),(@userid,23),(@userid,24),(@userid,25)
		set @count=+@@ROWCOUNT
		set @error =@@ERROR +@error 
	if @error = 0
	begin
		set @result = @count  -- 获取受影响行数
	end

	if @error = 0
	begin
		commit tran -- 提交事务
		return 1 --代表成功
	end
	else
	begin
		rollback tran -- 回滚事务
		return 0 --代表失败
	end
end

GO
/****** Object:  StoredProcedure [dbo].[up_deleteBookkeep]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[up_deleteBookkeep]
	@bookkeepid as int --记账记录id
as
begin
	begin tran --开始事物
	declare @number as int --记账记录原有金额
	declare @userid as varchar(50) --记账用户id
	declare @error as int
	declare @result as int --返回受影响行数
	declare @count as int --接收受影响行数
	set @count = 0
	set @result = 0
	set @error = 0

	SELECT @number=money,@userid=userid FROM T_Bookkeeping where id=@bookkeepid
	--删除记账记录
	delete from T_Bookkeeping where id=@bookkeepid
		set @count=+@@ROWCOUNT
		set @error =@@ERROR +@error
	if @@ERROR = 0
	begin
		set @result = @count  -- 获取受影响行数
	end
	--更新用户金额
	update T_User set totalmoney=totalmoney-@number where userid=@userid
		set @count=+@@ROWCOUNT
		set @error =@@ERROR +@error 
	if @error = 0
	begin
		set @result = @count  -- 获取受影响行数
	end

	if @error = 0
	begin
		commit tran -- 提交事务
		return 1 --代表成功
	end
	else
	begin
		rollback tran -- 回滚事务
		return 0 --代表失败
	end
end

GO
/****** Object:  StoredProcedure [dbo].[up_deleteSort]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[up_deleteSort]
 @id as int --记账记录id
as
begin
 begin tran --开始事物
 declare @error as int
 declare @result as int --返回受影响行数
 declare @count as int --接收受影响行数
 set @count = 0
 set @result = 0
 set @error = 0

 --删除记账记录
 delete from T_UserAndSortType where sortTypeID=@id
  set @count=+@@ROWCOUNT
  set @error =@@ERROR +@error
 if @@ERROR = 0
 begin
  set @result = @count  -- 获取受影响行数
 end
 --删除记账记录
 delete from T_SortType where id=@id
  set @count=+@@ROWCOUNT
  set @error =@@ERROR +@error
 if @@ERROR = 0
 begin
  set @result = @count  -- 获取受影响行数
 end

 if @error = 0
 begin
  commit tran -- 提交事务
  return 1 --代表成功
 end
 else
 begin
  rollback tran -- 回滚事务
  return 0 --代表失败
 end
end
GO
/****** Object:  StoredProcedure [dbo].[up_editBookkeep]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[up_editBookkeep]
	@bookkeepid as int, --记账记录id
	@type as int,--记账类型
	@money as float,--金额
	@datetime as datetime,--记账时间
	@payid as int,--支付类型id
	@sortid as int,--分类类型id
	@remark as text--记账备注
as
begin
	begin tran --开始事物
	declare @number as float --记账记录原有金额
	declare @userid as varchar(50) --记账用户id
	declare @endnumber as float --金额数量变量
	declare @error as int
	declare @result as int --返回受影响行数
	declare @count as int --接收受影响行数
	set @count = 0
	set @result = 0
	set @error = 0

	SELECT @number=money,@userid=userid FROM T_Bookkeeping where id=@bookkeepid
	--更新记账记录
	update T_Bookkeeping set money=@money,payid=@payid,sortid=@sortid,remark=@remark,datetime=@datetime where id=@bookkeepid
		set @count=+@@ROWCOUNT
		set @error =@@ERROR +@error
	if @@ERROR = 0
	begin
		set @result = @count  -- 获取受影响行数
	end
	--计算金额变量
	set @endnumber = @money-@number
	--更新用户金额
	if @type=0
	begin
		update T_User set totalmoney=totalmoney-@endnumber where userid=@userid
			set @error =@@ERROR +@error 
			set @count=+@@ROWCOUNT
		if @error = 0
		begin
			set @result = @count  -- 获取受影响行数
		end
	end
	else
	begin
		update T_User set totalmoney=totalmoney+@endnumber where userid=@userid
			set @count=+@@ROWCOUNT
			set @error =@@ERROR +@error 
		if @error = 0
		begin
			set @result = @count  -- 获取受影响行数
		end
	end
	if @error = 0
	begin
		commit tran -- 提交事务
		return 1 --代表成功
	end
	else
	begin
		rollback tran -- 回滚事务
		return 0 --代表失败
	end
end

GO
/****** Object:  Table [dbo].[T_Bookkeeping]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_Bookkeeping](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userid] [varchar](50) NOT NULL,
	[money] [float] NOT NULL,
	[datetime] [datetime] NOT NULL,
	[payid] [int] NOT NULL,
	[sortid] [int] NOT NULL,
	[type] [int] NOT NULL,
	[remark] [text] NULL,
 CONSTRAINT [PK_T_Bookkeeping] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_PayType]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_PayType](
	[payid] [int] IDENTITY(1,1) NOT NULL,
	[photoid] [int] NOT NULL,
	[payname] [varchar](50) NOT NULL,
 CONSTRAINT [PK_T_PayType] PRIMARY KEY CLUSTERED 
(
	[payid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_Photo]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_Photo](
	[photoid] [int] IDENTITY(1,1) NOT NULL,
	[photoname] [varchar](200) NOT NULL,
 CONSTRAINT [PK_T_Photo] PRIMARY KEY CLUSTERED 
(
	[photoid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_SortType]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_SortType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[photoid] [int] NOT NULL,
	[sortname] [varchar](50) NOT NULL,
	[types] [int] NULL,
 CONSTRAINT [PK_T_SortType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_User]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_User](
	[userid] [varchar](50) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[pwd] [varchar](50) NOT NULL,
	[totalmoney] [float] NOT NULL,
 CONSTRAINT [PK_T_User] PRIMARY KEY CLUSTERED 
(
	[userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_UserAndSortType]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_UserAndSortType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userid] [varchar](50) NOT NULL,
	[sortTypeID] [int] NOT NULL,
 CONSTRAINT [PK_T_UserAndSortType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[V_Bookkeeping]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Bookkeeping]
AS
SELECT   dbo.T_Bookkeeping.id, dbo.T_Bookkeeping.userid, dbo.T_User.username, dbo.T_User.totalmoney, 
                dbo.T_Bookkeeping.money, dbo.T_Bookkeeping.datetime, dbo.T_Bookkeeping.payid, dbo.T_PayType.payname, 
                dbo.T_PayType.photoid, dbo.T_Photo.photoname, dbo.T_Bookkeeping.sortid, dbo.T_SortType.sortname, 
                dbo.T_SortType.types, dbo.T_SortType.photoid AS sortphotoid, T_Photo_1.photoname AS sortphotoname, 
                dbo.T_Bookkeeping.type, dbo.T_Bookkeeping.remark
FROM      dbo.T_Bookkeeping INNER JOIN
                dbo.T_PayType ON dbo.T_Bookkeeping.payid = dbo.T_PayType.payid LEFT OUTER JOIN
                dbo.T_SortType ON dbo.T_Bookkeeping.sortid = dbo.T_SortType.id LEFT OUTER JOIN
                dbo.T_User ON dbo.T_Bookkeeping.userid = dbo.T_User.userid LEFT OUTER JOIN
                dbo.T_Photo ON dbo.T_PayType.photoid = dbo.T_Photo.photoid LEFT OUTER JOIN
                dbo.T_Photo AS T_Photo_1 ON dbo.T_SortType.photoid = T_Photo_1.photoid


GO
/****** Object:  View [dbo].[V_SortType]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SortType]
AS
SELECT   dbo.T_UserAndSortType.id, dbo.T_UserAndSortType.userid, dbo.T_User.username, dbo.T_User.totalmoney, 
                dbo.T_UserAndSortType.sortTypeID, dbo.T_SortType.sortname, dbo.T_SortType.types, dbo.T_SortType.photoid, 
                dbo.T_Photo.photoname
FROM      dbo.T_UserAndSortType INNER JOIN
                dbo.T_User ON dbo.T_UserAndSortType.userid = dbo.T_User.userid LEFT OUTER JOIN
                dbo.T_SortType ON dbo.T_UserAndSortType.sortTypeID = dbo.T_SortType.id LEFT OUTER JOIN
                dbo.T_Photo ON dbo.T_SortType.photoid = dbo.T_Photo.photoid


GO
/****** Object:  View [dbo].[V_Statistics]    Script Date: 2019/9/9 10:23:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Statistics]
AS
SELECT   dbo.T_Bookkeeping.sortid, dbo.T_Bookkeeping.money, dbo.T_Bookkeeping.datetime, dbo.T_User.totalmoney, 
                dbo.T_PayType.payname, dbo.T_PayType.payid, dbo.T_SortType.sortname, dbo.T_Bookkeeping.type, 
                dbo.T_Bookkeeping.userid
FROM      dbo.T_Bookkeeping INNER JOIN
                dbo.T_User ON dbo.T_Bookkeeping.userid = dbo.T_User.userid LEFT OUTER JOIN
                dbo.T_PayType ON dbo.T_Bookkeeping.payid = dbo.T_PayType.payid LEFT OUTER JOIN
                dbo.T_SortType ON dbo.T_Bookkeeping.sortid = dbo.T_SortType.id

GO
ALTER TABLE [dbo].[T_Bookkeeping]  WITH CHECK ADD  CONSTRAINT [FK_T_Bookkeeping_T_PayType] FOREIGN KEY([payid])
REFERENCES [dbo].[T_PayType] ([payid])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[T_Bookkeeping] CHECK CONSTRAINT [FK_T_Bookkeeping_T_PayType]
GO
ALTER TABLE [dbo].[T_Bookkeeping]  WITH CHECK ADD  CONSTRAINT [FK_T_Bookkeeping_T_SortType] FOREIGN KEY([sortid])
REFERENCES [dbo].[T_SortType] ([id])
GO
ALTER TABLE [dbo].[T_Bookkeeping] CHECK CONSTRAINT [FK_T_Bookkeeping_T_SortType]
GO
ALTER TABLE [dbo].[T_Bookkeeping]  WITH CHECK ADD  CONSTRAINT [FK_T_Bookkeeping_T_User] FOREIGN KEY([userid])
REFERENCES [dbo].[T_User] ([userid])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[T_Bookkeeping] CHECK CONSTRAINT [FK_T_Bookkeeping_T_User]
GO
ALTER TABLE [dbo].[T_PayType]  WITH CHECK ADD  CONSTRAINT [FK_T_PayType_T_Photo] FOREIGN KEY([photoid])
REFERENCES [dbo].[T_Photo] ([photoid])
GO
ALTER TABLE [dbo].[T_PayType] CHECK CONSTRAINT [FK_T_PayType_T_Photo]
GO
ALTER TABLE [dbo].[T_SortType]  WITH CHECK ADD  CONSTRAINT [FK_T_SortType_T_Photo] FOREIGN KEY([photoid])
REFERENCES [dbo].[T_Photo] ([photoid])
GO
ALTER TABLE [dbo].[T_SortType] CHECK CONSTRAINT [FK_T_SortType_T_Photo]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "T_Bookkeeping"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 146
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T_PayType"
            Begin Extent = 
               Top = 6
               Left = 218
               Bottom = 127
               Right = 360
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T_SortType"
            Begin Extent = 
               Top = 6
               Left = 398
               Bottom = 146
               Right = 542
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T_User"
            Begin Extent = 
               Top = 6
               Left = 580
               Bottom = 146
               Right = 734
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T_Photo"
            Begin Extent = 
               Top = 132
               Left = 218
               Bottom = 234
               Right = 374
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T_Photo_1"
            Begin Extent = 
               Top = 150
               Left = 38
               Bottom = 252
               Right = 194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
      ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Bookkeeping'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'   Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Bookkeeping'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Bookkeeping'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "T_UserAndSortType"
            Begin Extent = 
               Top = 6
               Left = 414
               Bottom = 108
               Right = 567
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T_User"
            Begin Extent = 
               Top = 3
               Left = 661
               Bottom = 143
               Right = 815
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T_SortType"
            Begin Extent = 
               Top = 6
               Left = 196
               Bottom = 127
               Right = 340
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "T_Photo"
            Begin Extent = 
               Top = 18
               Left = 0
               Bottom = 120
               Right = 156
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_SortType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_SortType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_SortType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[52] 2[5] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "T_Bookkeeping"
            Begin Extent = 
               Top = 0
               Left = 38
               Bottom = 145
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T_User"
            Begin Extent = 
               Top = 0
               Left = 402
               Bottom = 139
               Right = 556
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T_PayType"
            Begin Extent = 
               Top = 0
               Left = 219
               Bottom = 114
               Right = 387
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "T_SortType"
            Begin Extent = 
               Top = 123
               Left = 230
               Bottom = 243
               Right = 374
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Statistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Statistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Statistics'
GO
