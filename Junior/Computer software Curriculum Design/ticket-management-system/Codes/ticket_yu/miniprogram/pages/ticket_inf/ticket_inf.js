// pages/ticket_inf/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    peid:"",
    love:false,
    performData:[]
  },


  async getSpecificInfo(id) {
    var that = this
    wx.cloud.callFunction({
      // 云函数名称
      name: 'getSpecificInfo',
      // 传给云函数的参数
      data: {
        id : id
      },
      success: function(res) {
        
        console.log(res.result)
        that.setData({
          performData:res.result.data
        })
        //console.log(res.result) // 3
      },
      fail: console.error
    })
  },


  handle_love_tap(e){
    var that = this
    let {love}=this.data;
    if(!love){
      wx.getStorage({
        key:'likelist',
        success:function(res){
          var lData = res.data
          if(lData.indexOf(that.data.peid)==-1){
            lData.unshift(that.data.peid)
            that.userDataUpdate(lData,1)
            wx.setStorage({
              key:'likelist',
              data: lData
            })
          }
        }
      })
      wx.showToast({
        title: '已收藏',
        icon: 'success',
        duration: 2000
      });
    }else{
      wx.getStorage({
        key:'likelist',
        success:function(res){
          var lData = res.data
          var index = lData.indexOf(that.data.peid)
          if(index!=-1){
            lData.splice(index,1)
            that.userDataUpdate(lData,1)
            wx.setStorage({
              key:'likelist',
              data: lData
            })
          }
        }
      })
      wx.showToast({
        title: '取消收藏',
        icon: 'success',
        duration: 2000
      });
    }
    this.setData({
      love:!love
    })
  },
  handlePay(){
    var that = this
    var peids = []
    wx.getStorage({
      key:'peidlist',
      success:function(res){
        res.data.forEach(v => {
          peids.push(v["peid"])      
        });
        var arrIndex = peids.indexOf(that.data.peid)
        if(arrIndex==-1){
          that.userDataUpdate([...res.data,{peid:that.data.peid,num:1}],0)
          wx.setStorage({
            key:'peidlist',
            data:[...res.data,{peid:that.data.peid,num:1}]
          })
        }
        else{
          var changeData = res.data
          changeData[arrIndex]["num"] = changeData[arrIndex]["num"]
          that.userDataUpdate(changeData,0)
          wx.setStorage({
            key:'peidlist',
            data:changeData
          })
        }
        wx.switchTab({
          url:"/pages/cart/cart"
        })
      }
    })
    
    //需要将演出信息存入订单缓存中
  },
  


  handleCartAdd(e){
    var that = this
    var peids = []
    wx.getStorage({
      key:'peidlist',
      success:function(res){
        res.data.forEach(v => {
          peids.push(v["peid"])      
        });
        var arrIndex = peids.indexOf(that.data.peid)
        if(arrIndex==-1){
          that.userDataUpdate([...res.data,{peid:that.data.peid,num:1}],0)
          wx.setStorage({
            key:'peidlist',
            data:[...res.data,{peid:that.data.peid,num:1}]
          })
        }
        else{
          var changeData = res.data
          changeData[arrIndex]["num"] = changeData[arrIndex]["num"]+1
          that.userDataUpdate(changeData,0)
          wx.setStorage({
            key:'peidlist',
            data:changeData
          })
        }

        wx.showToast({
          title: '已添加',
          icon: 'success',
          duration: 2000
        });
      }
    })
  },
  
  async userDataUpdate(peidlist, opnum) {
    wx.cloud.callFunction({
      // 云函数名称
      name: 'userDataUpdate',
      // 传给云函数的参数
      data: {
        opnum : opnum,
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
   * 
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var pid = options.peid
    var that = this
    this.setData({
      peid:pid
    })
    this.getSpecificInfo(pid)
    wx.getStorage({
      key:'likelist',
      success:function(res){
        if(res.data.indexOf(pid)!=-1){
          that.setData({
            love:true
          })
        }
      }
    })
  },



  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function (options) {
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    
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