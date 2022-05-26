# ToDo-List
`Java 11` `Spring MVC` `Hibernate` `html 5` `jQuery 3.6.0` `bootstrap 5.1.3` 

# SQL Server
DROP TABLE IF exists ToDoList;

CREATE TABLE ToDoList (

	Id INT primary key IDENTITY(1,1),
  
	Content NVARCHAR(50),
  
	Finished Tinyint,
  
	FinishedTime DATETIME2,
  
);

insert into ToDoList(Content, Finished, FinishedTime) Values('data1',1,'2022-04-25 20:20:20');

select * from ToDoList;


# 專案匯入步驟如下
1.請於SQL Server內創建帳號為Donglin，密碼為P@ssw0rd並登入

2.請將檔案 SQL Server.sql 開啟並執行。

3.於eclipse中將檔案ToDo-List匯入。

4.開啟網頁並輸入網址為: http://localhost:8080/ToDo-List

