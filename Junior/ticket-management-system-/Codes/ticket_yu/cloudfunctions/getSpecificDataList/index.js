// 云函数入口文件
const cloud = require('wx-server-sdk')

cloud.init({env: cloud.DYNAMIC_CURRENT_ENV})
const db = cloud.database()
// 云函数入口函数
exports.main = async (event, context) => {
  const wxContext = cloud.getWXContext()
  const _ = db.command
  var data=[]
  var dbdata
  for(var i = 0;i<event.peidlist.length;i++){
    dbdata = await db.collection("tickets")
    .where({
      id:event.peidlist[i]
    })
    .limit(1)
    .get()

    data.push(dbdata.data[0])
  }
  //var dataObj = JSON.stringify(JSON.parse(datas)["data"])
  //var numObj = JSON.stringify(JSON.parse(totalNums)["total"])
  return {
    data:data,
    message:{
      peidlist:event.peidlist
      //total:numObj
    }
    //dataObj
  }
}