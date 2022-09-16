// 云函数入口文件
const cloud = require('wx-server-sdk')

cloud.init({env: cloud.DYNAMIC_CURRENT_ENV})
const db = cloud.database()
// 云函数入口函数
exports.main = async (event, context) => {
  const wxContext = cloud.getWXContext()
  const _ = db.command
  var items = (event.currPage-1)*20
  var datas = await db.collection("orders")
  .where({
    openid:wxContext.OPENID
  })
  .orderBy('date','desc')
  .get()
  var pListList=[]
  datas.data.forEach(v=>{
    var pList=[]
    v.content.forEach(u=>{
      pList.push(u)
    })
    pListList.push(pList)
  })
  

  return {
    data:pListList,
    message:{
      openid:wxContext.OPENID
      //total:numObj
    }
    //dataObj
  }
}