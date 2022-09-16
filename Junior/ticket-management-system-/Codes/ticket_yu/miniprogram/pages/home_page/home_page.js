// pages/home_page/index.js
Page({
  
  data: {
    totItems:0,
    currentPage:1,
    swiperList:[
      {
        id:0,
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/s1.png?sign=cf8e1328e74f0728aa688a19ef6ec78c&t=1625405620"
      },
      {
        id:1,
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/s2.png?sign=aeec899032ab42c2194a80aaabdaef08&t=1625405770"
      }
    ],
    catesList:[
      {
        name:""
      }
    ],
    groups:[
      {
        id:0,
        name:"演唱会",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/live.png?sign=4495ec9ad0596a7b1b1ca8bfd217b6a5&t=1625475055",
        num:"",
        url_:"/pages/all_ticket/all_ticket",
        tab_index:1
      },
      {
        id:1,
        name:"音乐会",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/concert.png?sign=3f14074c3a93830c39cdaa85f8d62ed2&t=1625482069",
        num:"",
        url_:"/pages/all_ticket/all_ticket",
        tab_index:2
      },
      {
        id:2,
        name:"话剧歌剧",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/ju.png?sign=e7354f41cc231129f16cd0360093fc66&t=1625475116",
        num:"",
        url_:"/pages/all_ticket/all_ticket",
        tab_index:4
      },
      {
        id:3,
        name:"展览休闲",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/exhibition.png?sign=2a1b86a675420d5bcc26adaf02bb2197&t=1625475129",
        num:"",
        url_:"/pages/all_ticket/all_ticket",
        tab_index:3
      },
      {
        id:4,
        name:"全部分类",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/allClass.png?sign=566b4410ec700626a8ac48f5bfdd1999&t=1625475153",
        num:"",
        url_:"/pages/all_ticket/all_ticket",
        tab_index:0
      }
    ],
    showInfo:[
      {
        id:0,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",
        
      },
      {
        id:1,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",

      },
      {
        id:2,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",

      },
      {
        id:3,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",

      },
      {
        id:4,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",

      },
      {
        id:5,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",

      },
      {
        id:6,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",

      },
      {
        id:7,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",

      },
      {
        id:8,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",

      },
      {
        id:9,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",

      },
      {
        id:10,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",

      }
    ],

    performList:[]
  },

  onShow: function(options){
    
    
    //this.getOpenid()
  },

  onReady: function (options) {
    this.userDataUpload()
    this.getUSerData()
    this.getOrder()
  
    //this.searchByName()

    wx.setStorageSync('jumpFromPay', false)
  },

  onLoad: function (options) {
    
    this.getData(1)
  },

  async getPerformanceData(){

  },
  
  async getData(pages) {
    var that = this
    wx.cloud.callFunction({
      // 云函数名称
      name: 'getData',
      // 传给云函数的参数
      data: {
        currPage: pages,
      },
      success: function(res) {
        var pages = Math.ceil(res.result.message.total/20)
        that.setData({
          performList:[...that.data.performList,...res.result.data],
          totItems:pages
        })
        console.log(res.result) // 3
      },
      fail: console.error
    })
  },

  async getUSerData() {
    var that = this
    wx.cloud.callFunction({
      // 云函数名称
      name: 'getUserData',
      // 传给云函数的参数
      success: function(res) {
        wx.setStorage({
          key:'peidlist',
          data:res.result.data[0].peidlist
        })
        wx.setStorage({
          key:'likelist',
          data:res.result.data[0].likelist
        })
        console.log(res.result) // 3
      },
      fail: console.error
    })
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


  async searchByName() {
    var that = this
    wx.cloud.callFunction({
      // 云函数名称
      name: 'searchByName',
      // 传给云函数的参数
      data:{
        name:"小"
      },
      success: function(res) {
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
        console.log(res.result) // 3
      },
      fail: console.error
    })
  },








  userDataUpload() {
    var that = this
    wx.cloud.callFunction({
      // 云函数名称
      name: 'userDataUpload',
      // 传给云函数的参数
      success: function(res) {
         console.log(res.result)
      },
      fail: console.error
    })
  },



  getOpenid() {
    var that = this
    wx.cloud.callFunction({
      // 云函数名称
      name: 'getOpenid',
      // 传给云函数的参数
      success: function(res) {
        console.log(res.result) // 3
      },
      fail: console.error
    })
  },


  onReachBottom(){
    var cp = this.data.currentPage+1
    console.log("reach bottom")
    if(this.data.currentPage>=this.data.totItems){
      console.log("nope")
    }
    else{
      this.setData({
        currentPage:cp
      })
      console.log("yes")
      this.getData(this.data.currentPage)
    }
  }
  
})