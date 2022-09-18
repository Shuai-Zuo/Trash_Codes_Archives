// pages/favorite/favorite.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    collect:[]
  },


  async getSpecificInfo(likelist) {
    var that = this 
    wx.cloud.callFunction({
      // 云函数名称
      name: 'getSpecificDataList',
      // 传给云函数的参数
      data: {
        peidlist : likelist
      },
      success: function(res) {  
        console.log(res.result)
        that.setData({
          collect:res.result.data
        })
        //console.log(perform)
        //console.log(res.result) // 3
      },
      fail: console.error
    })
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

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    const lList=wx.getStorageSync("likelist")||[];
    this.getSpecificInfo(lList)
    //const collect=wx.getStorageSync("collect")||[];
    //let {collect}=this.data;//测试用
    /*this.setData({
      collect
    })*/
      
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

  }
})