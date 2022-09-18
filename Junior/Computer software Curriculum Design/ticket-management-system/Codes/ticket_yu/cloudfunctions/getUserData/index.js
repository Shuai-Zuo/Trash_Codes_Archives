// 云函数入口文件
const cloud = require('wx-server-sdk')

cloud.init({env: cloud.DYNAMIC_CURRENT_ENV})
const db = cloud.database()
// 云函数入口函数
exports.main = async (event, context) => {
  const wxContext = cloud.getWXContext()
  const _ = db.command
  var userdata = await db.collection("userDatas")
  .where({
    openid:wxContext.OPENID
  })
  .get()
  //var dataObj = JSON.stringify(JSON.parse(datas)["data"])
  //var numObj = JSON.stringify(JSON.parse(totalNums)["total"])
  return {
    data: userdata.data,
    message: {
      openid:wxContext.OPENID
      //total:numObj
    }
    //dataObj
  }
}