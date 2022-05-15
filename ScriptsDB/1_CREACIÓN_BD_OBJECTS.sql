
USE [featureEugeniaAi]
GO
/****** Object:  Table [dbo].[FEAI_Invitaciones]    Script Date: 12/05/2022 12:34:20 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FEAI_Usuarios]    Script Date: 12/05/2022 12:34:20 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FEAI_Usuarios]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FEAI_Usuarios](
	[USU_Id] [int] IDENTITY(1,1) NOT NULL,
	[USU_Nombres] [varchar](200) NULL,
	[USU_ApePat] [varchar](75) NULL,
	[USU_ApeMat] [varchar](75) NULL,
	[USU_Email] [varchar](100) NULL,
	[USU_Contrasenia] [varchar](300) NULL,
	[USU_numDepto] [int],
	[timestamp] [datetime] NULL,
	[fecha_alta] [datetime] NULL,
 CONSTRAINT [PK_FEAI_Usuarios] PRIMARY KEY CLUSTERED 
(
	[USU_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FEAI_Invitaciones]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FEAI_Invitaciones](
	[INV_Id] [int] IDENTITY(1,1) NOT NULL,
	[INV_Nombre] [varchar](100) NULL,
	[USU_Id] [int] NOT NULL,
	[INV_FechaHoraEntrada] [datetime] NULL,
	[INV_FechaHoraCaducidad] [datetime] NULL,
	[timestamp] [datetime] NULL,
	[fecha_alta] [datetime] NULL,
 CONSTRAINT [PK_FEAI_Invitaciones] PRIMARY KEY CLUSTERED 
(
	[INV_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_FEAI_Invitaciones_timestamp]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FEAI_Invitaciones] ADD  CONSTRAINT [DF_FEAI_Invitaciones_timestamp]  DEFAULT (getdate()) FOR [timestamp]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_FEAI_Invitaciones_fecha_alta]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FEAI_Invitaciones] ADD  CONSTRAINT [DF_FEAI_Invitaciones_fecha_alta]  DEFAULT (getdate()) FOR [fecha_alta]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_FEAI_Usuarios_timestamp]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FEAI_Usuarios] ADD  CONSTRAINT [DF_FEAI_Usuarios_timestamp]  DEFAULT (getdate()) FOR [timestamp]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_FEAI_Usuarios_fecha_alta]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FEAI_Usuarios] ADD  CONSTRAINT [DF_FEAI_Usuarios_fecha_alta]  DEFAULT (getdate()) FOR [fecha_alta]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_FEAI_Usuarios_ABC]    Script Date: 12/05/2022 12:34:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FEAI_Usuarios_CRUD]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_FEAI_Usuarios_CRUD] AS' 
END
GO
ALTER PROCEDURE [dbo].[sp_FEAI_Usuarios_CRUD] 
    @ID INT = NULL,
    @Nombres VARCHAR(200)= NULL,
    @ApPat  VARCHAR(75) = NULL,
    @ApMat  VARCHAR(75) = NULL,
    @Email  VARCHAR(100) = NULL,
	@Contrasenia VARCHAR(300) = NULL,
	@NumDepto INT = 0,
	@Sucess INT = 1 OUTPUT,
	@MsgErr VARCHAR(200)= NULL OUTPUT
AS 
BEGIN 
BEGIN TRAN
BEGIN TRY
	--EN ESTE CASO LA VALIDACIÓN DE DATOS SERÁ POR EL FRONT AUNQUE TAMBIEN SE PUEDE DESDE EL SP

	IF @ID IS NULL 
	BEGIN
	--Se trata de un registro nuevo

	--Se valida primero que no exista un registro con los mismos nombres con fecha de Nac
		Declare @ExisteEmp VARCHAR='';

		SELECT @ExisteEmp=USU_ID FROM FEAI_Usuarios
		WHERE (USU_Nombres=@Nombres AND USU_ApePat=@ApPat AND USU_ApeMat=@ApMat) or USU_Email = @Email

		IF @ExisteEmp=''
		BEGIN
			INSERT INTO FEAI_Usuarios(
				USU_Nombres
				,USU_ApePat
				,USU_ApeMat
				,USU_Email
				,USU_Contrasenia
				,USU_numDepto
				,timestamp
				,fecha_alta
				) VALUES (
				@Nombres,
				@ApPat,
				@ApMat,
				@Email,
				@Contrasenia,
				@NumDepto,
				GETDATE(),
				GETDATE()
				)
				SET @Sucess = '1';
				SET @MsgErr = 'Se ha guardado el usuario correctamente';
		END ELSE
			SET @Sucess = 0;
			SET @MsgErr = 'Ya existe el usuario';

	END

	IF @ID IS NOT NULL --mandan un id de USUARIO
	BEGIN
	
		DECLARE @Id_find INT = 0;

		--se valida si se existe el usuario
		SELECT @Id_find=USU_Id FROM FEAI_Usuarios WHERE USU_Id = @ID

		--SELECT @Id_find
		IF @Id_find = 0
		BEGIN	-- noexiste el usuario
			SET @MsgErr = 'No existe el usuario';
			SET @Sucess = 0;
		END
		ELSE
		 --existe, se actualizan los datos
		
			UPDATE FEAI_Usuarios SET
				USU_Nombres = @Nombres,
				USU_ApePat = @ApPat,
				USU_ApeMat = @ApMat,
				USU_Email = @Email,
				USU_numDepto = @NumDepto,
				USU_Contrasenia = @Contrasenia,
				timeStamp = getdate()
			WHERE USU_Id = @Id_find
				
				SET @Sucess = 1;
				SET @MsgErr = 'Los datos del usuario se han actualizado correctamente';
		END

		COMMIT TRAN
END TRY 
BEGIN CATCH 
	SELECT @MsgErr = ERROR_MESSAGE(); 
	SET @Sucess = 0;

	ROLLBACK TRAN

END CATCH
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[sp_FEAI_Usuario_Buscar]    Script Date: 12/05/2022 12:34:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FEAI_Usuario_Buscar]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_FEAI_Usuario_Buscar] AS' 
END
GO
ALTER PROCEDURE [dbo].[sp_FEAI_Usuario_Buscar] 
    @Email VARCHAR(100) = '',
    @Contrasenia VARCHAR(300) = '',
	@Sucess INT = 0 OUT,
	@MsgErr VARCHAR(200)= NULL OUT
AS 
BEGIN 
BEGIN TRY

	IF @Email IS NOT NULL AND @Email <> '' --SE BUSCA UN usuario EN ESPECÍFICO
	BEGIN
		SELECT  USU_Id
				,USU_Nombres
				,USU_ApePat
				,USU_ApeMat
				,USU_Email
				,USU_Contrasenia
				,USU_numDepto 
		FROM FEAI_usuarios 
		WHERE USU_Email = @Email AND USU_Contrasenia = @Contrasenia

		SET @Sucess = 1;
	END

END TRY 
BEGIN CATCH 
	SELECT @MsgErr = ERROR_MESSAGE(); 
	SET @Sucess = 0;
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_FEAI_Invitaciones_Buscar]    Script Date: 12/05/2022 12:34:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FEAI_Invitaciones_Buscar]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_FEAI_Invitaciones_Buscar] AS' 
END
GO 
ALTER PROCEDURE [dbo].[sp_FEAI_Invitaciones_Buscar] 
	@Sucess INT = 0 OUT,
	@MsgErr VARCHAR(200)= NULL OUT
AS 
BEGIN 
BEGIN TRY

	SELECT INV_ID  
		,INV_Nombre
		,USU_Id
		,INV_FechaHoraEntrada
		,INV_FechaHoraCaducidad
		,timestamp
		,fecha_alta 
	FROM FEAI_Invitaciones

	SET @Sucess = 1;

END TRY 
BEGIN CATCH 
	SELECT @MsgErr = ERROR_MESSAGE(); 
	SET @Sucess = 0;
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_FEAI_Invitacion_Crear]    Script Date: 12/05/2022 12:34:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FEAI_Invitacion_Crear]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_FEAI_Invitacion_Crear] AS' 
END
GO
ALTER PROCEDURE [dbo].[sp_FEAI_Invitacion_Crear] 
	@INV_Nombre VARCHAR(100),
	@USU_Id INT = 0,
	@FechaHoraEntrada DATETIME,
	@FechaHoraCaducidad DATETIME,
	@Sucess INT = 0 OUT,
	@MsgErr VARCHAR(200)= NULL OUT
AS 
BEGIN 
BEGIN TRY

	INSERT INTO FEAI_Invitaciones (  
		INV_Nombre
		,USU_Id
		,INV_FechaHoraEntrada
		,INV_FechaHoraCaducidad
		,timestamp
		,fecha_alta)
		VALUES(
		@INV_Nombre,
		@USU_Id,
		@FechaHoraEntrada,
		@FechaHoraCaducidad,
		GETDATE(),
		GETDATE()
		)

	SET @Sucess = 1;

END TRY 
BEGIN CATCH 
	SELECT @MsgErr = ERROR_MESSAGE(); 
	SET @Sucess = 0;
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_FEAI_Invitaciones_Buscar]    Script Date: 12/05/2022 12:34:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FEAI_Invitaciones_Buscar]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_FEAI_Invitaciones_Buscar] AS' 
END
GO
ALTER PROCEDURE [dbo].[sp_FEAI_Invitaciones_Buscar] 
    @ID INT = NULL,
    @Nombre VARCHAR(300) = '', 
	@INV_FechaHoraInv DATETIME = NULL,
	@Sucess INT = 0 OUT,
	@MsgErr VARCHAR(200)= NULL OUT
AS 
BEGIN 
BEGIN TRY

	IF @ID IS NOT NULL AND @ID > 0 --SE BUSCA UN usuario EN ESPECÍFICO
	BEGIN
		
		SELECT 
			I.INV_Id, I.INV_Nombre,U.USU_Nombres, U.USU_ApeMat, U.USU_ApePat, U.USU_numDepto, U.USU_Email, I.INV_FechaHoraEntrada, I.INV_FechaHoraCaducidad
		FROM FEAI_Invitaciones AS I 
		LEFT JOIN FEAI_Usuarios AS U ON I.INV_Id = U.USU_Id
		WHERE I.INV_Id = @ID
		
		SET @Sucess = 1;
	END

	IF @ID IS NULL OR @ID = 0 -- Se busca un usuario segun parámetros
	BEGIN

		IF @Nombre <> ''
			SELECT 
				I.INV_Id, I.INV_Nombre,U.USU_Nombres, U.USU_ApeMat, U.USU_ApePat, U.USU_numDepto, U.USU_Email, I.INV_FechaHoraEntrada, I.INV_FechaHoraCaducidad
			FROM FEAI_Invitaciones AS I 
			LEFT JOIN FEAI_Usuarios AS U ON I.INV_Id = U.USU_Id
			WHERE 
					(I.INV_Nombre LIKE ('%' + @Nombre + '%') OR
					U.USU_Nombres LIKE ('%' + @Nombre + '%') OR -- NORMALMENTE SE TRATA DE NO USAR ESTE TIPO DE BUSQUEDAS POR PERFORMANCE, SE PUEDEN AGREGAR ÍNDICES DE TEXTO.
					U.USU_ApePat LIKE ('%' + @Nombre + '%') OR
					U.USU_ApeMat LIKE ('%' + @Nombre + '%'))
		ELSE
			
			SELECT
				I.INV_Id, I.INV_Nombre,U.USU_Nombres, U.USU_ApeMat, U.USU_ApePat, U.USU_numDepto, U.USU_Email, I.INV_FechaHoraEntrada, I.INV_FechaHoraCaducidad
			FROM FEAI_Invitaciones AS I 
			LEFT JOIN FEAI_Usuarios AS U ON I.INV_Id = U.USU_Id
			WHERE I.INV_Id <= 100 --para no usar select top
		
		IF @INV_FechaHoraInv <> '' OR @INV_FechaHoraInv IS NOT NULL
		BEGIN
			SELECT 
				I.INV_Id, I.INV_Nombre,U.USU_Nombres, U.USU_ApeMat, U.USU_ApePat, U.USU_numDepto, U.USU_Email, I.INV_FechaHoraEntrada, I.INV_FechaHoraCaducidad
			FROM FEAI_Invitaciones AS I 
			LEFT JOIN FEAI_Usuarios AS U ON I.INV_Id = U.USU_Id
			WHERE 
			(I.INV_FechaHoraEntrada BETWEEN (DATEADD(DAY,-1,@INV_FechaHoraInv)) AND (DATEADD(DAY,1,@INV_FechaHoraInv))
			) OR
			(I.INV_FechaHoraCaducidad BETWEEN (DATEADD(DAY,-1,@INV_FechaHoraInv)) AND (DATEADD(DAY,1,@INV_FechaHoraInv))
			)
		END

		SET @Sucess = 1;


	END
END TRY 
BEGIN CATCH 
	SELECT @MsgErr = ERROR_MESSAGE(); 
	SET @Sucess = 0;
END CATCH
END
GO
