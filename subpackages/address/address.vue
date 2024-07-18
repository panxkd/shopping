<template>
  <view>
    <view class="top-box">
      <view class="complete-button">
        <button size="mini" @click="completeSelection()">确定</button>
      </view>
      <view class="add-address">
        <view class="manage-button" @click="toggleManageMode()">
          <text class="text-box">{{ manageMode ? '完成' : '管理' }}</text>
        </view>
        <view class="add-address-button" @click="add_address()">
          <image src="/static/添加.png" class="image-box"></image>
          <text class="text-box">添加收货信息</text>
        </view>
      </view>
    </view>

    <view v-if="addresses.length === 0" class="no-address">
      <text>收货信息为空</text>
    </view>
    <view v-else>
      <view class="container" v-for="address in addresses" :key="address.address_id">
        <view class="address-info" @click="selectAddress(address)" :class="{ selected: selectedAddressId === address.address_id }">
          <view v-if="manageMode">
            <!-- 显示删除按钮 -->
            <view class="manage-delete" @click.stop="showDeleteConfirmation(address)">
              <text class="text-box">删除</text>
            </view>
          </view>
          <view v-else>
            <!-- 显示单选按钮 -->
            <radio :value="address.address_id" :checked="selectedAddressId === address.address_id" color="#C00000"></radio>
          </view>
          <view class="info-box">
            <view class="info-item">
              <label class="label"></label>
              <text class="text">收货姓名：{{ address.name }}</text>
            </view>
            <view class="info-item">
              <label class="label"></label>
              <text class="text">电话号码：{{ address.phone }}</text>
            </view>
            <view class="info-item">
              <label class="label"></label>
              <text class="text">地址：{{ address.city }}{{ address.address }}</text>
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      selectedAddressId: '', // Track the selected address ID
      manageMode: false // Track if in manage mode
    };
  },
  computed: {
    addresses() {
      return this.$store.state.address.addresses; // 访问命名空间状态
    }
  },
  methods: {
    add_address() {
      uni.navigateTo({
        url: '/subpackages/add_address/add_address'
      });
    },
    selectAddress(address) {
      if (!this.manageMode) {
        this.selectedAddressId = this.selectedAddressId === address.address_id ? '' : address.address_id; // 切换选中状态
        this.$store.commit('address/selectAddress', address); // 将选中的地址存储到 Vuex
      }
    },
    deleteAddress(address) {
      uni.showModal({
        title: '确认删除',
        content: '确定要删除这条收货信息吗？',
        success: (res) => {
          if (res.confirm) {
            // 用户点击确定删除
            this.$store.commit('address/deleteAddress', address);
          }
        }
      });
    },
    completeSelection() {
      // 在这里可以添加完成选择后的逻辑
      uni.switchTab({
        url: '/pages/cart/cart'
      });
    },
    toggleManageMode() {
      this.manageMode = !this.manageMode;
      // 退出管理模式时清除选中的地址
      if (!this.manageMode) {
        this.selectedAddressId = '';
      }
    },
    showDeleteConfirmation(address) {
      this.deleteAddress(address);
    }
  }
};
</script>

<style lang="scss">
.container {
  padding: 10px;
}
.address-info {
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  display: flex;
  align-items: center;
}
.address-info.selected {
  border-color: #C00000;
}
.info-item {
  margin-left: 10px;
  flex-grow: 1;
}
.label {
  display: block;
  font-size: 16px;
  color: #333;
  margin-bottom: 5px;
}
.text {
  font-size: 16px;
  color: #555;
}
.add-address {
  display: flex;
  justify-content: space-between; /* Ensures buttons are spaced */
  align-items: center; /* Center vertically */
  margin-right: 10px;
  margin-top: 10px;
}
.add-address-button {
  display: flex;
  align-items: center;
}
.manage-delete {
  width: 47px;
  height: 30px;
  background-color: #C00000;
  color: white;
  border: 1px solid #efefef;
  border-radius: 15px;
  display: flex;
  justify-content: center;
  align-items: center;
}
.manage-button {
  margin-right: 10px; /* Space between manage and add buttons */
  cursor: pointer;
}
.image-box {
  width: 30px;
  height: 30px;
  display: flex;
  justify-content: center;
  align-items: center;
}
.text-box {
  display: flex;
  justify-content: center;
  align-items: center;
}
.no-address {
  padding: 20px;
  text-align: center;
  font-size: 16px;
  color: #999;
}
.top-box {
  display: flex;
  justify-content: space-between;
}
.complete-button {
  display: flex;
  justify-content: center;
  margin-top: 10px;
  margin-left: 10px;
}
.complete-button button {
  color: gray;
  border: none;
  border-radius: 15px;
  cursor: pointer;
  width: 70px;
  height: 30px;
}
.info-box {
  display: flex;
  flex-direction: column; /* 竖直方向分布 */
  justify-content: center; /* 垂直方向居中 */
  //align-items: center; /* 水平方向居中 */
}
</style>
