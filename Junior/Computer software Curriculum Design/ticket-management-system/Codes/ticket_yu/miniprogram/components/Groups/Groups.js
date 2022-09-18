// components/Groups/Groups.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    groups:{
      type:Array,
      value:[]

    }
  },

  /**
   * 组件的初始数据
   */
  data: {

  },

  /**
   * 组件的方法列表
   */
  methods: {
    handleItemTap(e){
      var id = e.currentTarget.dataset.id;
      console.log(123);
      wx.setStorage({
        key:'id',
        data:id
      })

    }
  }
})
