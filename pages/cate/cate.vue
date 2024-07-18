<template>
  <view>
    <mysearch @click="gotosearch"></mysearch>
    <!-- 主盒子 -->
    <view class="container">
      <!-- 左侧栏 -->
      <view class="nav_left">
        <view
          v-for="(item, index) in uniqueTypes"
          :key="index"
          :class="['nav_left_items', curNav === item ? 'active' : '']"
          @click="switchRightTab(item)"
        >
          {{ item }}
        </view>
      </view>
      <!-- 右侧栏 -->
      <view class="nav_right">
        <!-- 如果有数据，才遍历项 -->
        <view v-if="filteredItems.length">
          <view v-for="child in filteredItems" :key="child.id" class="nav_right_items">
            <!-- 界面跳转 -->
            <navigator :url="'/subpackages/goods_detail/goods_detail?goods_id=' + child.id">
              <image :src="child.images[0]"></image>
              <text>{{ child.name }}</text>
            </navigator>
          </view>
        </view>
        <!-- 如果无数据，则显示无数据 -->
        <view class="nodata_text" v-else>该分类暂无数据</view>
      </view>
    </view>
  </view>
</template>

<script>
import badgeMix from '@/mixins/tabbar-badge.js'

export default {
  mixins: [badgeMix],
  data() {
    return {
      cateItems: [],
      curNav: '',
      curIndex: 0
    };
  },
  computed: {
    uniqueTypes() {
      const types = this.cateItems.map(item => item.type);
      return [...new Set(types)];
    },
    filteredItems() {
      return this.cateItems.filter(item => item.type === this.curNav);
    }
  },
  onLoad() {
    this.getCateItems();
  },
  methods: {
    async getCateItems() {
      uni.request({
        url: 'http://8.138.16.110:8800/api/products',
        method: 'GET',
        success: (res) => {
          if (res.data) {
            const cateItems = res.data.map(item => {
              item.images = JSON.parse(item.images);
              return item;
            });
            this.cateItems = cateItems;
            if (this.uniqueTypes.length > 0) {
              this.curNav = this.uniqueTypes[0];
            }
          }
        },
        fail: (err) => {
          console.error('数据加载失败', err);
        }
      });
    },
    gotosearch() {
      uni.navigateTo({
        url: '/subpackages/search/search'
      });
    },
    switchRightTab(type) {
      this.curNav = type;
    }
  }
};
</script>

<style scoped>
.page {
  background: #f5f5f5;
}
/* 总体主盒子 */
.container {
  position: relative;
  width: 100%;
  height: 100%;
  background-color: #fff;
  color: #939393;
}
/* 左侧栏主盒子 */
.nav_left {
  /* 设置行内块级元素（没使用定位） */
  display: inline-block;
  width: 25%;
  height: 100%;
  /* 主盒子设置背景色为灰色 */
  background: #f5f5f5;
  text-align: center;
}
/* 左侧栏list的item */
.nav_left .nav_left_items {
  /* 每个高30px */
  height: 40px;
  /* 垂直居中 */
  line-height: 40px;
  /* 再设上下padding增加高度，总高42px */
  padding: 6px 0;
  /* 只设下边线 */
  border-bottom: 1px solid #dedede;
  /* 文字14px */
  font-size: 14px;
}
/* 左侧栏list的item被选中时 */
.nav_left .nav_left_items.active {
  /* 背景色变成白色 */
  background: #fff;
  color: #92E2C7;
}
/* 右侧栏主盒子 */
.nav_right {
  /* 右侧盒子使用了绝对定位 */
  position: absolute;
  top: 0;
  right: 0;
  flex: 1;
  /* 宽度75%，高度占满，并使用百分比布局 */
  width: 75%;
  height: 1000px;
  padding: 10px;
  box-sizing: border-box;
  background: #fff;
}
/* 右侧栏list的item */
.nav_right .nav_right_items {
  /* 浮动向左 */
  float: left;
  /* 每个item设置宽度是33.33% */
  width: 33.33%;
  height: 120px;
  text-align: center;
}
.nav_right .nav_right_items image {
  /* 被图片设置宽高 */
  width: 60px;
  height: 60px;
  margin-top: 15px;
}
.nav_right .nav_right_items text {
  /* 给text设成块级元素 */
  display: block;
  margin-top: 15px;
  font-size: 14px;
  color: black;
  /* 设置文字溢出部分为... */
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
.nodata_text {
  color: black;
  font-size: 14px;
  text-align: center;
}
/** index.wxss **/
.search-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10rpx 20rpx;
  box-sizing: border-box;
  background-color: #ddd;
}
.search-left {
  background-color: #eee;
  flex: 2;
}
.search-left image {
  width: 48rpx;
  height: 48rpx;
  padding: 10rpx 20rpx 10rpx 10rpx;
  vertical-align: middle;
}
.search-left input {
  display: inline-block;
  vertical-align: middle;
  width: calc(100% - 88rpx);
}
.search-right {
  padding-left: 20rpx;
}
.search-right image {
  width: 80rpx;
  height: 80rpx;
  vertical-align: middle;
}
</style>
