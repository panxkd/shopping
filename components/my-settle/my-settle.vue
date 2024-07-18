<template>
  <view class="settle-box">
    <!-- 全选 -->
    <label class="radio">
      <radio color="#C00000" :checked="selectAll" @click="toggleSelectAll"></radio><text>全选</text>
    </label>
    <!-- 合计 -->
    <view class="amount-box">
      合计：<text class="amount">￥{{ totalAmount }}</text>
    </view>
    <!-- 结算 -->
    <view class="btn-settle" @click="settlement">
      结算（{{ selectedCount }}）
    </view>
  </view>
</template>

<script>
import { mapState, mapMutations, mapActions } from 'vuex';
import dayjs from 'dayjs';

export default {
  name: "my-settle",
  computed: {
    ...mapState('m_cart', ['totalAmount', 'selectAll', 'cart']),
    ...mapState('m_user', ['token', 'userinfo']),
    ...mapState('address', ['addresses', 'selectedAddress']),
    selectedCount() {
      return this.cart.filter(item => item.goods1_state).length;
    }
  },
  methods: {
    ...mapMutations('m_cart', ['toggleSelectAll']),
    ...mapActions('m_orders', ['submitOrder']),
    async settlement() {
      try {
        if (!this.token) {
          this.showToast('请先登录');
          setTimeout(() => {
            uni.switchTab({
              url: '/pages/my/my'
            });
          }, 1500);
          return;
        }

        if (this.selectedCount === 0) {
          this.showToast('请选择商品！');
          return;
        }

        if (!this.selectedAddress) {
          this.showToast('请选择收货地址！');
          return;
        }

        const currentTimestamp = dayjs().format('YYYY-MM-DD HH:mm:ss');

        const orderData = {
          userId: this.token,
          orderDate: currentTimestamp,
          totalAmount: this.totalAmount,
          userName: this.selectedAddress.name,
          address: `${this.selectedAddress.city} ${this.selectedAddress.address}`,
          phone: this.selectedAddress.phone,
          orderItems: this.cart.filter(item => item.goods1_state).map(item => ({
            productName: item.goods1_name,
            productPrice: item.goods1_price,
            productQuantity: item.goods1_count,
            itemTotal: item.goods1_price * item.goods1_count
          }))
        };

        const res = await uni.request({
          url: 'http://8.138.16.110:8800/api/orders',
          method: 'POST',
          data: orderData,
          header: {
            Authorization: `Bearer ${this.token}`
          }
        });

        if (res.statusCode === 200) {
          this.showToast('订单提交成功');
          // 将订单数据保存到Vuex
		  const orders={
			  orderItems: this.cart.filter(item => item.goods1_state).map(item => ({
				image:item.goods1_image,
			    productName: item.goods1_name,
			    productPrice: item.goods1_price,
			    productQuantity: item.goods1_count,
				itemTotal: item.goods1_price * item.goods1_count
			  }))
		  }
          this.submitOrder(orders);
          // 订单提交成功后的处理逻辑，比如跳转到订单详情页
          uni.navigateTo({
            url: '/subpackages/orders/orders'
          });
        } else {
          this.showToast('订单提交失败');
        }
      } catch (error) {
        console.error("Error in settlement process:", error);
        this.showToast('请求失败，请重试');
      }
    },
    showToast(message) {
      uni.showToast({
        title: message,
        duration: 1500,
        icon: 'none'
      });
    }
  }
};
</script>

<style lang="scss">
.settle-box {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 50px;
  border: 1px solid #efefef;
  z-index: 999;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 14px;
  padding-left: 10px;
}
.radio {
  display: flex;
  align-items: center;
}
.amount-box {
  .amount {
    color: #C00000;
    font-weight: bold;
  }
}
.btn-settle {
  background-color: #92E2C7;
  height: 50px;
  color: black;
  line-height: 50px;
  padding: 0 10px;
  min-width: 100px;
  text-align: center;
}
</style>
