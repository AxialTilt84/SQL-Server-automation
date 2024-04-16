set quoted_identifier off
declare @dbname varchar(100)
declare @string varchar(3000)
declare cursor1 cursor for
select name from sysdatabases where dbid>4
open cursor1
fetch next from cursor1 into @dbname
while (@@fetch_status = 0)
begin
select @string="use master
go
alter database "+@dbname +" set offline with rollback immediate
go
alter database "+@dbname +" set online
go
sp_detach_db "+@dbname +"
go"
print @string
fetch next from cursor1 into @dbname
end
close cursor1
deallocate cursor1