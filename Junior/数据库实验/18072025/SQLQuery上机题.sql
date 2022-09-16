select 名称,COUNT(*) as 参加人数
from 街道文体活动,参加街道活动
where 街道文体活动.编号=参加街道活动.活动编号
group by 名称
having COUNT(*) >= 5

select 楼.小区名,COUNT(*) as 楼宇数
from 楼,小区,街道办事处
where 街道办事处.名称 = '南磨房街道' and 编号=街道编号 and 楼.小区名 = 小区.小区名
group by 楼.小区名

select 街道办事处.名称,sum(房屋套数) as 总套数
from 楼,小区,街道办事处
where 街道办事处.名称 = '南磨房街道' and 编号=街道编号 and 楼.小区名 = 小区.小区名
group by 街道办事处.名称

select 小区.小区名,count(*) as 落户人口数
from 小区,街道办事处,居民
where 街道办事处.名称 = '南磨房街道' and 编号=街道编号 and 小区.小区名 = 居民.小区名
group by 小区.小区名

select 小区.小区名,楼号,count(*) as 楼宇落户人口
from 小区,街道办事处,居民
where 街道办事处.名称 = '南磨房街道' and 编号=街道编号 and 小区.小区名 = 居民.小区名
group by 小区.小区名,楼号
order by 楼宇落户人口 DESC