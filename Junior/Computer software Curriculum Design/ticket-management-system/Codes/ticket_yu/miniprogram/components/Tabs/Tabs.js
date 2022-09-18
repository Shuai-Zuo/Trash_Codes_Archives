// components/Tabs/Tabs.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    tabs:{
      type:Array,
      value:[]
    }

  },

  /**
   * 组件的初始数据
   */
  data: {
  },


  methods: {
    handleItemTap(e){
      const {index}=e.currentTarget.dataset;
      this.triggerEvent("itemChange",{index});
    }
  }
})
