// 云函数入口文件
const cloud = require('wx-server-sdk')

cloud.init({env: cloud.DYNAMIC_CURRENT_ENV})
const db = cloud.database()
// 云函数入口函数
exports.main = async (event, context) => {
  const wxContext = cloud.getWXContext()
  const _ = db.command
  var datas = await db.collection("tickets")
  .where({
    id:event.id
  })
  .limit(1)
  .get()
  //var dataObj = JSON.stringify(JSON.parse(datas)["data"])
  //var numObj = JSON.stringify(JSON.parse(totalNums)["total"])
  return {
    data:datas.data[0],
    message:{
      id:event.id
      //total:numObj
    }
    //dataObj
  }
}