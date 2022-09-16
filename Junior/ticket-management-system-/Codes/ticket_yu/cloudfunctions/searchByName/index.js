// 云函数入口文件
const cloud = require('wx-server-sdk')

cloud.init({env: cloud.DYNAMIC_CURRENT_ENV})
const db = cloud.database()
// 云函数入口函数
exports.main = async (event, context) => {
  const wxContext = cloud.getWXContext()
  const _ = db.command
  //var items = (event.currPage-1)*20
  var totalNums = await db.collection("tickets").count()
  var datas = await db.collection("tickets")
  .where({
    name:db.RegExp({
      regexp: event.name,
      options: 'i',
    })
  })
  //.limit(40)
  .get()
  //var dataObj = JSON.stringify(JSON.parse(datas)["data"])
  //var numObj = JSON.stringify(JSON.parse(totalNums)["total"])
  return {
    data:datas.data,
    message:{
      //currPage:event.currPage,
      total:totalNums.total
      //total:numObj
    }
    //dataObj
  }
}