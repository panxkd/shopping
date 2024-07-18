<template>
  <my-login v-if="!token"></my-login>
  <view class="container" v-else>
    <!-- 顶部 -->
    <view class="top-box">
      <view class="avatar-box">
        <image :src="avatarSrc" class="image-box"></image>
      </view>
      <view class="username">
        <text>{{ userinfo.nickName }}</text>
      </view>
    </view>

    <!-- 中间 -->
    <view class="middle">
      <view class="order-box">
        <view class="order-item" @click="gotoOrders()">
          <image src="/static/订单.png"></image>
          <text>我的订单</text>
        </view>
        <view class="order-item">
          <image src="/static/待发货.png"></image>
          <text>待发货</text>
        </view>
        <view class="order-item">
          <image src="/static/待收货.png"></image>
          <text>待收货</text>
        </view>
      </view>
    </view>

    <!-- 底部 -->
    <view class="bottom">
      <view class="nav-item">
        <text>关于我们</text>
        <uni-icons type="arrowright" size="16"></uni-icons>
      </view>
      <view class="separator"></view>
      <view class="nav-item">
        <text>联系客服</text>
        <uni-icons type="arrowright" size="16"></uni-icons>
      </view>
      <view class="separator"></view>
      <view class="nav-item" @click="gotoSetting">
        <text>设置</text>
        <uni-icons type="arrowright" size="16"></uni-icons>
      </view>
    </view>
  </view>
</template>


<script>
import { mapState, mapMutations } from 'vuex';
import badgeMix from '@/mixins/tabbar-badge.js';
export default {
	mixins: [badgeMix],
  computed: {
    ...mapState('m_user', ['token', 'userinfo']),
    avatarSrc() {
      return this.userinfo.avatar || '/static/头像.png';
    }
  },
  methods: {
    gotoSetting() {
      uni.navigateTo({
        url: '/subpackages/setting/setting'
      });
    },
	gotoOrders(){
		uni.navigateTo({
			url:'/subpackages/orders/orders'
		})
	}
  }
};
</script>


<style lang="scss">
.container {
  background: linear-gradient(to bottom, #92E2C7, #ffffff);
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 20rpx;
}

.top-box {
  display: flex;
  align-items: center;
  padding: 10rpx;
  margin-bottom: 10rpx;
  border-bottom: 1px solid #ddd;
}

.avatar-box {
  width: 100rpx;
  height: 100rpx;
  border: 2px solid #ccc;
  border-radius: 50%;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
}

.image-box {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.username {
  margin-left: 10rpx;
  color: #999;
}

.middle {
  display: flex;
  justify-content: space-around;
  margin: 30rpx 0;
}

.order-box {
  display: flex;
  background-color: #fff;
  border-radius: 20rpx;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.1);
  padding: 10rpx;
  width: 700rpx;
}

.order-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 10rpx;
  text-align: center;
  
  image {
    width: 50rpx;
    height: 50rpx;
  }

  text {
    margin-top: 10rpx;
    font-size: 20rpx;
  }
}

.bottom {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  background-color: #fff;
  border-radius: 10rpx;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.1);
  margin: 10rpx 0;
}

.nav-item {
  display: flex;
  justify-content: space-between;
  padding: 10rpx;
  padding-left: 25rpx;
  line-height: 70rpx;
}

.separator {
  height: 1rpx;
  background-color: #ddd;
  margin: 0 20rpx;
}
</style>
