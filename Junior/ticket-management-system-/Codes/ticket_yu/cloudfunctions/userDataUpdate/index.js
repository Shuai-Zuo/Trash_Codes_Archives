// 云函数入口文件
const cloud = require('wx-server-sdk')

cloud.init({env: cloud.DYNAMIC_CURRENT_ENV})
const db = cloud.database()
// 云函数入口函数
exports.main = async (event, context) => {
  const wxContext = cloud.getWXContext()
  const _ = db.command
  var tot
  try {
    if(event.opnum==0){
      db.collection('userDatas').where({
        openid:wxContext.OPENID
      })
      .update({
        data: {
          peidlist: event.list
        }
      })
    }else if(event.opnum==1){
      db.collection('userDatas').where({
        openid:wxContext.OPENID
      })
      .update({
        data: {
          likelist: event.list
        }
      })
    }
   
  }catch(e){
    console.log(e)
  }

  return {
    openid:wxContext.OPENID
  }
}