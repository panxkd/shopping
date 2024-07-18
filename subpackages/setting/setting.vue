<template>
  <view class="top-box">
    <view class="item">
      <text>设置头像</text>
      <view class="right" @click="showAvatarModal">
        <image :src="avatarSrc" class="image-box"></image>
        <uni-icons type="arrowright" size="16"></uni-icons>
      </view>
    </view>
    <view class="separator"></view>
    <view class="item">
      <text>设置昵称</text>
      <view class="right" @click="showNicknameModal">
        <text>{{ userinfo.nickName || '设置昵称' }}</text>
        <uni-icons type="arrowright" size="16"></uni-icons>
      </view>
    </view>
  </view>
  <view class="container">
    <button @click="logout" class="logout-button">退出登录</button>
  </view>
  
  <!-- 头像选择弹框 -->
  <view v-if="isAvatarModalVisible" class="modal">
    <view class="modal-content">
      <view class="modal-item" @click="chooseImage('camera')">拍摄</view>
      <view class="modal-item" @click="chooseImage('album')">从相册选择</view>
      <view class="modal-item" @click="hideAvatarModal">取消</view>
    </view>
  </view>

  <!-- 昵称修改弹框 -->
  <view v-if="isNicknameModalVisible" class="modal">
    <view class="modal-content">
      <input v-model="newNickname" placeholder="请输入新昵称" class="nickname-input" />
      <view class="modal-item" @click="updateNickname">确定</view>
      <view class="modal-item" @click="hideNicknameModal">取消</view>
    </view>
  </view>
</template>

<script>
import { mapMutations, mapState } from 'vuex';

export default {
  data() {
    return {
      isAvatarModalVisible: false,
      isNicknameModalVisible: false,
      newNickname: '',
      avatarSrc: this.userinfo && this.userinfo.avatar ? this.userinfo.avatar : '/static/头像.png'
    };
  },
  computed: {
    ...mapState('m_user', ['userinfo'])
  },
  methods: {
    ...mapMutations('m_user', ['clearUserinfo', 'clearToken', 'updateAvatar', 'updateUserinfo']),
    logout() {
      this.clearUserinfo();
      this.clearToken();
      uni.reLaunch({
        url: '/pages/my/my'
      });
    },
    showAvatarModal() {
      this.isAvatarModalVisible = true;
    },
    hideAvatarModal() {
      this.isAvatarModalVisible = false;
    },
    showNicknameModal() {
      this.isNicknameModalVisible = true;
    },
    hideNicknameModal() {
      this.isNicknameModalVisible = false;
    },
    chooseImage(type) {
      const self = this;
      uni.chooseImage({
        count: 1,
        sizeType: ['original', 'compressed'],
        sourceType: [type],
        success(res) {
          const tempFilePaths = res.tempFilePaths;
          self.avatarSrc = tempFilePaths[0];
          self.updateAvatar(tempFilePaths[0]);
          self.hideAvatarModal();
        }
      });
    },
    updateNickname() {
      if (this.newNickname.trim() !== '') {
        const updatedUserinfo = { ...this.userinfo, nickName: this.newNickname };
        this.updateUserinfo(updatedUserinfo);
        this.newNickname = '';
        this.hideNicknameModal();
      }
    }
  },
  watch: {
    userinfo: {
      handler(newUserinfo) {
        this.avatarSrc = newUserinfo && newUserinfo.avatar ? newUserinfo.avatar : '/static/头像.png';
      },
      deep: true,
      immediate: true
    }
  }
};
</script>

<style lang="scss">
.top-box {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  background-color: #fff;
  border-radius: 10rpx;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.1);
  margin: 10rpx 15rpx;
  .item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15rpx 10rpx;
    padding-left: 25rpx;
    color: #c1c1c1;
    font-size: 35rpx;
    line-height: 80rpx;
    .right {
      display: flex;
      align-items: center;
      .image-box {
        width: 60rpx;
        height: 60rpx;
        margin-right: 10rpx;
      }
    }
  }
}

.separator {
  height: 1rpx;
  background-color: #ddd;
  margin: 0 20rpx;
}

.container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 80vh;
}

.logout-button {
  width: 400rpx;
  height: 100rpx;
  background-color: #92E2C7;
  color: #fff;
  text-align: center;
  line-height: 90rpx;
  border-radius: 60rpx;
  font-size: 32rpx;
}

.modal {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: #fff;
  box-shadow: 0 -2rpx 10rpx rgba(0, 0, 0, 0.1);
  border-top-left-radius: 20rpx;
  border-top-right-radius: 20rpx;
  padding: 20rpx;
}

.modal-content {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.modal-item {
  padding: 20rpx;
  font-size: 32rpx;
  color: #333;
  width: 100%;
  text-align: center;
  border-bottom: 1rpx solid #ddd;
}

.modal-item:last-child {
  border-bottom: none;
}

.nickname-input {
  width: 80%;
  padding: 10rpx;
  border: 1rpx solid #ddd;
  border-radius: 5rpx;
  margin-bottom: 20rpx;
  font-size: 32rpx;
}
</style>
