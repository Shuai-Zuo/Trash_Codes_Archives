// pages/cart/cart.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    perform:[],
    cart:[],
    allChecked:false,
    totalPrice:0,
    totalNum:0
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


  async getSpecificInfo(peidlist) {
    var that = this 
    var peids = []
    peidlist.forEach(v => {
      peids.push(v["peid"])      
    });

    wx.cloud.callFunction({
      // 云函数名称
      name: 'getSpecificDataList',
      // 传给云函数的参数
      data: {
        peidlist : peids
      },
      success: function(res) {
        
        console.log(res.result)
        var carts = res.result.data
        carts.forEach(v=>{
          for(var i = 0;i<that.data.cart.length;i++){
            if(v.id===that.data.cart[i].id){
              var temp = that.data.cart
              temp[i].num = peidlist[peids.indexOf(v.id)]["num"]
              that.setData({
                cart:temp
              })
              return
            }
          }
          var cartgood={
            id:v.id,
            name:v.name,
            price:v.price,
            verticalPic:v.verticalPic,
            checked:true,
            num:peidlist[peids.indexOf(v.id)]["num"]
          }
          that.setData({
            cart:[...that.data.cart,cartgood]
          })
        })
        that.setCart(that.data.cart)



        //console.log(perform)
        //console.log(res.result) // 3
      },
      fail: console.error
    })
  },


  async userDataUpdate(peidlist) {
    wx.cloud.callFunction({
      // 云函数名称
      name: 'userDataUpdate',
      // 传给云函数的参数
      data: {
        opnum : 0,
        list : peidlist
      },
      success: function(res) {
        console.log(res.result)
        //console.log(perform)
        //console.log(res.result) // 3
      },
      fail: console.error
    })
  },


  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    const peidlist=wx.getStorageSync("peidlist")||[]
    console.log(peidlist)
    if(wx.getStorageSync('jumpFromPay')==true){
      this.data.cart=wx.getStorageSync('cart')
      var pList=[]
      this.data.cart.forEach(v=>{
        pList.push({
          num:v["num"],
          peid:v["id"]
        })
      })
      this.userDataUpdate(pList)
      wx.setStorageSync('jumpFromPay',false)
      wx.setStorageSync("peidlist",pList)
      this.setCart(this.data.cart)
    }
    else{
      this.getSpecificInfo(peidlist)
    }
      //cart.push(cartgood)
  
    //console.log(cart)
    //that.setCart(cart)

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
  handleItemChange(e){
    const id=e.currentTarget.dataset.id;
    let {cart}=this.data;
    let index=cart.findIndex(v=>v.id===id);
    cart[index].checked=!cart[index].checked;
    this.setCart(cart);
  },
  //设置购物车状态 计算 数据 
  setCart(cart){
    let totalPrice=0;
    let totalNum=0;
    let allChecked=true;
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
  handleItemAllChecked(){
    let {cart,allChecked}=this.data;
    allChecked=!allChecked;
    cart.forEach(v=>v.checked=allChecked);
    this.setCart(cart);
  },
  handleItemNumEdit(e){
    const {operation,id}=e.currentTarget.dataset;
    var that = this
    let {cart}=this.data;
    const index=cart.findIndex(v=>v.id===id);
    if(cart[index].num===1&&operation===-1){
      wx.showModal({
        title: '提示',
        content: '您是否要删除？',
        success :(res) =>{
          if (res.confirm) {
            console.log(index)
            wx.getStorage({
              key:'peidlist',
              success:function(res){
                var listIndex = res.data.findIndex(v=>v.peid===cart[index].id)
                var cData = res.data
                cData.splice(listIndex,1);
                that.userDataUpdate(cData)
                wx.setStorage({
                  key:'peidlist',
                  data:cData
                })
                cart.splice(index,1);
                that.setCart(cart);
              }
            })
          } else if (res.cancel) {
            console.log('用户点击取消')
          }
        }
      })
    }
    else{
    cart[index].num+=operation;
    wx.getStorage({
      key:'peidlist',
      success:function(res){
          var listIndex = res.data.findIndex(v=>v.peid===cart[index].id)
          var cData = res.data
          cData[listIndex].num+=operation
          that.userDataUpdate(cData)
          wx.setStorage({
            key:'peidlist',
            data:cData
          })
      }
    })


    this.setCart(cart);
    }
  },

  handlePay(){
    const {totalNum}=this.data;
    if(totalNum===0){
      wx.showToast({
        title: '还没有选购商品',
        icon: 'error',
        duration: 2000
      });
      return;  
    }
    wx.setStorageSync('cart', this.data.cart)
    wx.navigateTo({
      url: '/pages/pay/pay'
    });
      
  }
})