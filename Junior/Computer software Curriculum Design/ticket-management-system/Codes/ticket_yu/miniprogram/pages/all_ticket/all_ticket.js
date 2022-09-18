// pages/all_ticket/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    totItems:0,
    currentPage:1,
    currentTabs:0,
    performList:[],
    cidJump:[-1,1,2,7,3,4],
    tabs:[
      {
        id:0,
        name:"全部",
        isActive:true
      },
      {
        id:1,
        name:"演唱会",
        isActive:false
      },
      {
        id:2,
        name:"音乐会",
        isActive:false
      },
      {
        id:3,
        name:"展览休闲",
        isActive:false
      },
      {
        id:4,
        name:"话剧歌剧",
        isActive:false
      },
      {
        id:5,
        name:"舞蹈",
        isActive:false
      },
    ],
    get_tabs_index_from_home_page : 0,
    all:[
      {
        id:0,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",
      }
    ],
    live:[
      {
        id:0,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203261001.jpg?sign=dc70f20a549694ea1a074b9b5edf36dc&t=1625498623",
      }
    ],
    concert:[
      {
        id:0,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",
      }
    ],
    exhibition:[
      {
        id:0,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",
      }
    ],
    drama:[
      {
        id:0,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",
      }
    ],
    dance:[
      {
        id:0,
        show_name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        show_price:"￥1000",
        image_src:"https://636c-cloud1-6gdvlf7927fbc9d5-1305608734.tcb.qcloud.la/1_1_203259001.jpg?sign=6c04875ba3c7dacd6a4c647b2620a122&t=1625496516",
      }
    ],

  },
  /**
   * 页面上拉触底事件的处理函数
   */
  async getDataByCategories(pages,cid) {
    var that = this
    wx.cloud.callFunction({
      // 云函数名称
      name: 'getDataByCategories',
      // 传给云函数的参数
      data: {
        currPage : pages,
        categoryid : cid
      },
      success: function(res) {
        var pages = Math.ceil(res.result.message.total/20)
        console.log(res.result)
        that.setData({
          performList:[...that.data.performList,...res.result.data],
          totItems:pages
        })
        //console.log(res.result) // 3
      },
      fail: console.error
    })
  },


  handleItemChange(e){
    const {index}=e.detail
    let {tabs}=this.data
    tabs.forEach((v,i)=>i===index?v.isActive=true:v.isActive=false)
    this.setData({
      tabs
    })
    if(this.data.currentTabs!=index){
      this.setData({
        currentPage:1,
        currentTabs:index,
        performList:[]
      })
      console.log("not same page")
      this.getDataByCategories(this.data.currentPage,this.data.cidJump[this.data.currentTabs])
    }



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
    var that = this
    wx.getStorage({
      key: 'id',
      
      success: (res)=>{
        
        var id = res.data;  // 这里获取到的id值即为A页面传递id值
        console.log(id+"id")
        that.setData({
          get_tabs_index_from_home_page:res.data 
        }); 
        console.log(that.data.get_tabs_index_from_home_page+"iget_tabs_index_from_home_page")
        //console.log(get_tabs_index_from_home_page+"ddd")
        let tab=that.data.tabs;
        tab.forEach((v,i)=>i===that.data.get_tabs_index_from_home_page?v.isActive=true:v.isActive=false)
        that.setData({
          tabs:tab,
          currentTabs:that.data.get_tabs_index_from_home_page,
          performList:[],
          currentPage:1
        });
        that.getDataByCategories(that.data.currentPage,that.data.cidJump[that.data.currentTabs])

      },
      fail: ()=>{
        console.log("fail");
      },  
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
      this.getDataByCategories(this.data.currentPage,this.data.cidJump[this.data.currentTabs])
    }
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})