// 云函数入口文件
const cloud = require('wx-server-sdk')

cloud.init({env: cloud.DYNAMIC_CURRENT_ENV})
const db = cloud.database()
// 云函数入口函数
exports.main = async (event, context) => {
  const wxContext = cloud.getWXContext()
  const _ = db.command
  var tot
  db.collection('userDatas').where({openid:wxContext.OPENID}).count().then(res => {
    //console.log(res.total)
    tot = res.total
    console.log(tot)
    if(tot==0){
      db.collection('userDatas').add({
        data:{
          openid:wxContext.OPENID,
          likelist:[],
          peidlist:[]
        }
      })
        .then(res => {
          console.log(res)
        })
        .catch(console.error)
    }
  })

  return {
    event,
    openid:wxContext.OPENID
  }
}