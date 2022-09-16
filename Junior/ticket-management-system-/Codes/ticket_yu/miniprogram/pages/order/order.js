// pages/order/order.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    order:[]
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
    this.getOrder()
  },

  async getOrder() {
    var that = this
    wx.cloud.callFunction({
      // 云函数名称
      name: 'getOrder',
      // 传给云函数的参数
      success: function(res) {
        that.getDataByOrder(res.result.data)
        console.log(res.result) // 3
      },
      fail: console.error
    })
  },

  async getDataByOrder(pList) {
    var that = this
    wx.cloud.callFunction({
      // 云函数名称
      name: 'getDataByOrder',
      // 传给云函数的参数
      data: {
        orderList: pList,
      },
      success: function(res) {
        that.setData({
          order:res.result.data,
        })
        wx.setStorageSync('orders',res.result.data)
        console.log(res.result) // 3
      },
      fail: console.error
    })
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