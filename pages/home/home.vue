<template>
  <view>
    <!-- 搜索组件 -->
    <view class="search-box">
      <mysearch @click="gotosearch()"></mysearch>
    </view>

    <!-- 轮播图 -->
    <swiper :indicator-dots="true" :autoplay="true" :interval="3000" :duration="1000" :circular="true">
      <swiper-item v-for="(item, i) in swiperList" :key="i">
        <view class="swiper-item">
          <image :src="item.src" class="swiper-img" mode="aspectFill"></image>
        </view>
      </swiper-item>
    </swiper>

    <!-- 分类导航 -->
    <view class="nav-box">
      <view class="nav-list">
        <view class="nav-item" v-for="(item, i) in navList" :key="i" @click="navClickHandler(item)">
          <image :src="item.src" class="nav-img"></image>
          <text class="nav-text">{{ item.type }}</text>
        </view>
      </view>
    </view>

    <!-- 楼层 -->
    <view class="floor-list">
      <view class="floor-item" v-for="(item, i) in floorList" :key="i" :id="'floor-' + i">
        <!-- 楼层标题 -->
        <view class="floor-title-box">
          <text class="floor-title">{{ item.floor_title }}</text>
        </view>

        <!-- 楼层图片 -->
        <view class="floor-img-box">
          <!-- 楼层右侧 -->
          <view class="right-img-box">
            <navigator class="right-img-item" v-for="(item2, i2) in item.product_list" :key="i2" :url="'/subpackages/goods_list/goods_list?goods_type=' + item2.type">
              <image :src="item2.src" class="right-img" mode="aspectFill"></image>
            </navigator>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import badgeMix from '@/mixins/tabbar-badge.js';

export default {
  mixins: [badgeMix],
  data() {
    return {
      // 轮播图数据列表
      swiperList: [],
      // 分类导航数据列表
      navList: [
        { src: '/static/肉.png', type: '家禽' },
        { src: '/static/鱼.png', type: '水产品' },
        { src: '/static/水稻.png', type: '农作物' },
        { src: '/static/水果苹果.png', type: '水果' }
      ],
      // 楼层数据列表
      floorList: []
    };
  },
  onLoad() {
    // 调用方法获取数据
    this.getSwiperList();
    this.getNavList();
    this.getFloorList();
  },
  methods: {
    // 获取轮播图数据
    async getSwiperList() {
      uni.request({
        url: 'http://8.138.16.110:8800/api/products',
        method: 'GET',
        success: (res) => {
          // 检查返回的数据是否有效且为数组
          if (res.data && Array.isArray(res.data)) {
            const products = res.data;
            let allImages = []; // 存储所有图片的数组
            // 遍历所有产品，将每个产品的图片合并到 allImages 数组中
            products.forEach(product => {
              if (product.images) {
                const images = JSON.parse(product.images); // 解析 images 字符串
                allImages = allImages.concat(images);
              }
            });
            // 随机挑选 3 张图片作为轮播图
            this.swiperList = this.shuffleArray(allImages).slice(0, 3).map(src => ({ src }));
          } else {
            console.error('无效的数据格式', res.data);
          }
        },
        fail: (err) => {
          console.error('数据加载失败', err);
        }
      });
    },
    // 打乱数组顺序的函数
    shuffleArray(array) {
      for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
      }
      return array;
    },
    async getNavList() {
      //const {data:res}=await uni.$http.get('')
      //if(res.meta.status!==200) return uni.$showMsg()
      //this.navList=res.massage
    },
    navClickHandler(item) {
      const index = this.navList.findIndex(navItem => navItem.type === item.type);
      if (index !== -1) {
        const query = uni.createSelectorQuery().in(this);
        query.select('#floor-' + index).boundingClientRect();
        query.selectViewport().scrollOffset();
        query.exec(res => {
          if (res[0] && res[1]) {
            // 加上偏移量确保楼层标题可见
            const offset = res[0].top + res[1].scrollTop - 100;
            uni.pageScrollTo({
              scrollTop: offset > 0 ? offset : 0,
              duration: 300
            });
          }
        });
      }
    },
    async getFloorList() {
      uni.request({
        url: 'http://8.138.16.110:8800/api/products',
        method: 'GET',
        success: (res) => {
          if (res.data && Array.isArray(res.data)) {
            const products = res.data;
            const floorData = {};

            // 整理数据
            products.forEach(product => {
              const { type, name, images } = product;
              if (!floorData[type]) {
                floorData[type] = {
                  floor_title: type,
                  product_list: []
                };
              }
              const imageList = JSON.parse(images); // 解析 images 字符串
              imageList.forEach(image => {
                floorData[type].product_list.push({
                  src: image,
                  name,
                  type
                });
              });
            });

            // 对每个类型的图片进行随机挑选
            Object.values(floorData).forEach(floor => {
              floor.product_list = this.shuffleArray(floor.product_list).slice(0, 6);
            });

            // 转换为数组并赋值
            this.floorList = Object.values(floorData);
          } else {
            console.error('无效的数据格式', res.data);
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
    }
  }
};
</script>

<style lang="scss">
swiper {
  height: 430rpx;
  .swiper-item,
  .swiper-img {
    width: 100%;
    height: 100%;
  }
}
.nav-box {
  background-color: #efefef;
}
.nav-list {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  margin: 15px 10rpx;
  border: 1px solid #efefef;
  border-radius: 30rpx;
  text-shadow: 0rpx 0rpx 5rpx #fff;
  box-shadow: 1rpx 1rpx 6rpx #aaaaaa;
  background: linear-gradient(to bottom right, #92E2C7, #ffffff);
  .nav-item {
    display: flex;
    flex-direction: column;
    padding: 10rpx; /* 适当增加内边距，使其在布局中有适当的间距 */
  }
  .nav-img {
    width: 60rpx;
    height: 60rpx;
    margin-bottom: 5rpx; /* 调整图标与文字的距离 */
  }
  .nav-text {
    text-align: center;
    font-size: 14px; /* 根据需要调整字体大小 */
    margin-top: 0; /* 确保文字与图标的间距不受其他因素影响 */
    color: gray;
  }
}
.floor-title-box {
  height: 50rpx;
  width: 700rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 1rpx 1rpx 6rpx #aaaaaa;
  background: linear-gradient(to bottom right, #92E2C7, #ffffff);
  border-radius: 30rpx;
  margin: 10px auto; /* 使盒子水平居中 */
  
  .floor-title {
    font-weight: bold;
    font-size: 26rpx;
    color: #777777;
    text-align: center; /* 确保文本水平居中 */
  }
}
.right-img-box {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  width: 100%;
  .right-img-item {
    margin: 10rpx;
    .right-img {
      width: 330rpx;
      height: 340rpx;
      box-shadow: 1rpx 1rpx 6rpx #aaaaaa;
      border-radius: 30rpx;
    }
  }
}
</style>
