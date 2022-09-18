CREATE TABLE 街道办事处
(
	编号 char(20) PRIMARY KEY,
	名称 char(20) NOT NULL,
	电话 char(11) NOT NULL,
	地址 char(100) NOT NULL
)

CREATE TABLE 小区
(
	小区名 char(20) PRIMARY KEY,
	地址 char(100) NOT NULL,
	街道编号 char(20) NOT NULL,
	FOREIGN KEY(街道编号) REFERENCES 街道办事处(编号)
)

CREATE TABLE 楼
(
	小区名 char(20),
	楼号 char(2) NOT NULL,
	楼层 char(2) NOT NULL,
	房屋套数 char(3) NOT NULL,
	PRIMARY KEY(小区名,楼号),
	FOREIGN KEY(小区名) REFERENCES 小区(小区名)
)

CREATE TABLE 住户
(
	小区名 char(20),
	楼号 char(2) NOT NULL,
	门牌号 char(10) NOT NULL,
	面积 int NOT NULL,
	户主 char(10) NOT NULL,
	PRIMARY KEY(小区名,楼号,门牌号),
	FOREIGN KEY(小区名,楼号) REFERENCES 楼(小区名,楼号)
)

CREATE TABLE 居民
(
	身份证号 char(18) NOT NULL PRIMARY KEY,
	姓名 char(10) NOT NULL,
	年龄 int,
	小区名 char(20),
	楼号 char(2) NOT NULL,
	门牌号 char(10) NOT NULL,
	FOREIGN KEY(小区名,楼号,门牌号) REFERENCES 住户(小区名,楼号,门牌号)
)

CREATE TABLE 街道文体活动
(
	编号 int NOT NULL PRIMARY KEY,
	名称 char(50) NOT NULL,
	日期 DATE NOT NULL,
	场地 char(100) NOT NULL,
	街道编号 char(20),
	FOREIGN KEY(街道编号) REFERENCES 街道办事处(编号)
)

CREATE TABLE 小区文体活动
(
	编号 int NOT NULL PRIMARY KEY,
	名称 char(50) NOT NULL,
	日期 DATE NOT NULL,
	场地 char(100) NOT NULL,
	小区名 char(20),
	FOREIGN KEY(小区名) REFERENCES 小区(小区名)
)

CREATE TABLE 参加小区活动
(
	活动编号 int NOT NULL,
	身份证号 char(18) NOT NULL,
	FOREIGN KEY(活动编号) REFERENCES 小区文体活动(编号),
	FOREIGN KEY(身份证号) REFERENCES 居民(身份证号)
)

CREATE TABLE 参加街道活动
(
	活动编号 int NOT NULL,
	身份证号 char(18) NOT NULL,
	FOREIGN KEY(活动编号) REFERENCES 小区文体活动(编号),
	FOREIGN KEY(身份证号) REFERENCES 居民(身份证号)
)