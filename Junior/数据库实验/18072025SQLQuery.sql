CREATE TABLE �ֵ����´�
(
	��� char(20) PRIMARY KEY,
	���� char(20) NOT NULL,
	�绰 char(11) NOT NULL,
	��ַ char(100) NOT NULL
)

CREATE TABLE С��
(
	С���� char(20) PRIMARY KEY,
	��ַ char(100) NOT NULL,
	�ֵ���� char(20) NOT NULL,
	FOREIGN KEY(�ֵ����) REFERENCES �ֵ����´�(���)
)

CREATE TABLE ¥
(
	С���� char(20),
	¥�� char(2) NOT NULL,
	¥�� char(2) NOT NULL,
	�������� char(3) NOT NULL,
	PRIMARY KEY(С����,¥��),
	FOREIGN KEY(С����) REFERENCES С��(С����)
)

CREATE TABLE ס��
(
	С���� char(20),
	¥�� char(2) NOT NULL,
	���ƺ� char(10) NOT NULL,
	��� int NOT NULL,
	���� char(10) NOT NULL,
	PRIMARY KEY(С����,¥��,���ƺ�),
	FOREIGN KEY(С����,¥��) REFERENCES ¥(С����,¥��)
)

CREATE TABLE ����
(
	���֤�� char(18) NOT NULL PRIMARY KEY,
	���� char(10) NOT NULL,
	���� int,
	С���� char(20),
	¥�� char(2) NOT NULL,
	���ƺ� char(10) NOT NULL,
	FOREIGN KEY(С����,¥��,���ƺ�) REFERENCES ס��(С����,¥��,���ƺ�)
)

CREATE TABLE �ֵ�����
(
	��� int NOT NULL PRIMARY KEY,
	���� char(50) NOT NULL,
	���� DATE NOT NULL,
	���� char(100) NOT NULL,
	�ֵ���� char(20),
	FOREIGN KEY(�ֵ����) REFERENCES �ֵ����´�(���)
)

CREATE TABLE С������
(
	��� int NOT NULL PRIMARY KEY,
	���� char(50) NOT NULL,
	���� DATE NOT NULL,
	���� char(100) NOT NULL,
	С���� char(20),
	FOREIGN KEY(С����) REFERENCES С��(С����)
)

CREATE TABLE �μ�С���
(
	���� int NOT NULL,
	���֤�� char(18) NOT NULL,
	FOREIGN KEY(����) REFERENCES С������(���),
	FOREIGN KEY(���֤��) REFERENCES ����(���֤��)
)

CREATE TABLE �μӽֵ��
(
	���� int NOT NULL,
	���֤�� char(18) NOT NULL,
	FOREIGN KEY(����) REFERENCES С������(���),
	FOREIGN KEY(���֤��) REFERENCES ����(���֤��)
)