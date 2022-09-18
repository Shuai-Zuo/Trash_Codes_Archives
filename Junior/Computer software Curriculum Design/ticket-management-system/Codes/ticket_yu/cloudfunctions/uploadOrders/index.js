// 云函数入口文件
const cloud = require('wx-server-sdk')

cloud.init({env: cloud.DYNAMIC_CURRENT_ENV})
const db = cloud.database()
// 云函数入口函数
exports.main = async (event, context) => {
  const wxContext = cloud.getWXContext()
  const _ = db.command
  db.collection('orders').add({
    data:{
      openid:wxContext.OPENID,
      content:event.cart,
      status:event.status,//0待支付，1已支付，2已使用，3已删除
      date:db.serverDate()
    }

      })
      .then(res => {
        console.log(res)
      })
      .catch(console.error)

  return {
    event,
    openid:wxContext.OPENID
  }
}