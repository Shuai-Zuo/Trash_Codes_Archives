// pages/cart/cart.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    cart:[
      {
        id:0,
        name:"暗暗发誓发生发生发生飞洒飞洒发生",
        price:"1000",
        verticalPic:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",
        checked:true,
        num:1
      },
      {
        id:1,
        name:"暗暗发誓发生发生发生飞洒飞洒发生",
        price:"1000",
        verticalPic:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",
        checked:false,
        num:100
      },
      {
        id:2,
        name:"暗暗发誓发生发生发生飞洒飞洒发生",
        price:"1000",
        verticalPic:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",
        checked:false,
        num:1
      },
      {
        id:3,
        name:"暗暗发誓发生发生发生飞洒飞洒发生",
        price:"1000",
        verticalPic:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",
        checked:true,
        num:2
      },
      {
        id:4,
        name:"暗暗发誓发生发生发生飞洒飞洒发生",
        price:"1000",
        verticalPic:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",
        checked:true,
        num:4
      }

    
    ],
    totalPrice:0,
    totalNum:0,
    
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },


  async uploadOrders(cart) {
    var that = this
    wx.cloud.callFunction({
      // 云函数名称
      name: 'uploadOrders',
      // 传给云函数的参数
      data: {
        cart: cart,
        status: 1
      },
      success: function(res) {
        that.getOrder()
        console.log(res.result)
      },
      fail: console.error
    })
  },


  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    let cart=wx.getStorageSync("cart")||[];
    //let {cart}=this.data//换上边的
    cart=cart.filter(v=>v.checked);
    
    let totalPrice=0;
    let totalNum=0;
    
    cart.forEach(v=>{
      
        totalPrice+=v.num*v.price;
        totalNum+=v.num;
      
    })
    
    this.setData({
      cart,
      totalPrice,
      totalNum,
      
    });
   
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  },

  //设置购物车状态 计算 数据 
  setCart(cart){
    let totalPrice=0;
    let totalNum=0;
    
    cart.forEach(v=>{
      if(v.checked){
        totalPrice+=v.num*v.price;
        totalNum+=v.num;
      }
      else{
        allChecked=false;
      }
    })
    allChecked=cart.length!=0?allChecked:false;
    this.setData({
      cart,
      totalPrice,
      totalNum,
      allChecked
    });
    //wx.setStorageSync("cart", cart);
  },
  handldeOrderPay(){
    wx.showToast({
      title: '购买成功',
      icon: 'success',
      duration: 2000
    });
    var pList = []
    this.data.cart.forEach(v=>{
      pList.push({num:v.num,peid:v.id})
    })
    this.uploadOrders(pList)
    let newCart=wx.getStorageSync("cart");
    newCart=newCart.filter(v=>!v.checked);
    wx.setStorageSync("cart", newCart);
    wx.setStorageSync("jumpFromPay", true);
    
    setTimeout(function () {
      wx.switchTab({
        url:'/pages/cart/cart'
      })
    }, 2000)
  },

  async getOrder() {
    var that = this
    wx.cloud.callFunction({
      // 云函数名称
      name: 'getOrder',
      // 传给云函数的参数
      success: function(res) {
        //that.getDataByOrder(res.result.data)
        wx.setStorageSync('orders',res.result.data)
        console.log(res.result) // 3
      },
      fail: console.error
    })
  },


  
})