// 云函数入口文件
const cloud = require('wx-server-sdk')

cloud.init({env: cloud.DYNAMIC_CURRENT_ENV})
const db = cloud.database()
// 云函数入口函数
exports.main = async (event, context) => {
  const wxContext = cloud.getWXContext()
  const _ = db.command
  var oList = event.orderList
  console.log(oList)
  var pListList = oList
  /*oList.forEach(v=>{
    var pList=[]
    console.log(v)
    v.forEach(u=>{
      pList.push(u["peid"])
    })
    pListList.push(pList)
  })*/
  var dataList=[]
  for(var j = 0;j<pListList.length;j++){
  //pListList.forEach(v=>{
    var data=[]
    var dbdata

    for(var i = 0;i<pListList[j].length;i++){
      dbdata = await db.collection("tickets")
      .where({
        id:pListList[j][i]["peid"]
      })
      .limit(1)
      .get()
      data.push({
        ...dbdata.data[0],
        num:pListList[j][i]["num"]
      })
    }
    dataList.push(data)
  }/*)*/

  return {
    data:dataList,
    message:{
      peidlist:oList,
      openid:wxContext.OPENID,
      date:""
      //total:numObj
    }
    //dataObj
  }
}