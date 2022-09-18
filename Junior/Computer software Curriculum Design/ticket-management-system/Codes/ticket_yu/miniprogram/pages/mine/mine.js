Page({
  data: {
    userInfo: {},
    hasUserInfo: false,
    canIUseGetUserProfile: false,
    collectNum:0,//被收藏商品数量
    orderNum:0
  },
  onLoad() {
    if (wx.getUserProfile) {
      this.setData({
        canIUseGetUserProfile: true
      })
    }
  },
  onShow: function () {
    const collect=wx.getStorageSync("likelist")||[];
    var orders=wx.getStorageSync("orders")||[];
    //let {collect}=this.data;//测试用
    this.setData({
      collectNum:collect.length,
      orderNum:orders.length
    });
      
  },
  getUserProfile(e) {
    
    wx.getUserProfile({
      desc: '用于完善会员资料', 
      success: (res) => {
        this.setData({
          userInfo: res.userInfo,
          hasUserInfo: true
        })
      }
    })
  },
  getUserInfo(e) {
    this.setData({
      userInfo: e.detail.userInfo,
      hasUserInfo: true
    })
  },
  handletap(){
    wx.navigateTo({
      url: '/pages/team_profile/team_profile'

    });
      
  }
})