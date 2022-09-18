// pages/search/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    show:[],
    isFocus:false,
    inputValue:""
  },
  TimeId:-1,
  handleInput(e){
    const {value}=e.detail;
    
    if(!value.trim()){
      clearTimeout(this.TimeId);
      this.setData({
        show:[],
        isFocus:false
      });
      return;
    }
    this.setData({
      isFocus:true
    });
    clearTimeout(this.TimeId);
    this.TimeId=setTimeout(()=>{
      //请求指令
      this.searchByName(value)
    },1000)
    

  },

  async searchByName(name) {
    var that = this
    wx.cloud.callFunction({
      // 云函数名称
      name: 'searchByName',
      // 传给云函数的参数
      data:{
        name:name
      },
      success: function(res) {
        that.setData({
          show:res.result.data
        });
        console.log(res.result) // 3
      },
      fail: console.error
    })
  },



  handleCancel(){
    this.setData({
      inputValue:"",
      isFocus:false,
      show:[]
    });
  }
  
})