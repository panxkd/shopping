<template>
  <view class="order-page">
    <view v-if="orders.length > 0">
      <view class="order" v-for="(order, index) in orders" :key="index">
        <view class="order-info">
          <view class="order-header">
            <text class="order-date">{{ order.orderDate }}</text>
          </view>
          <view class="order-items">
            <view class="order-item" v-for="(item, idx) in order.orderItems" :key="idx">
              <image :src="item.image" class="item-image" />
              <view class="item-details">
                <text class="item-name">{{ item.productName }}</text>
                <view class="item-info-right">
                  <text class="item-price">￥{{ item.productPrice }}</text>
                  <text class="item-quantity">数量：{{ item.productQuantity }}</text>
                  <text class="order-total">合计：￥{{ item.productPrice * item.productQuantity }}</text>
                </view>
              </view>
            </view>
          </view>
        </view>
      </view>
    </view>
    <view v-else>
      <text>暂无订单</text>
    </view>
  </view>
</template>

<script>
import { mapState } from 'vuex';

export default {
  name: "OrdersPage",
  computed: {
    ...mapState('m_orders', ['orders'])
  }
};
</script>

<style lang="scss">
.order-page {
  padding: 20px;
}
.order {
  margin-bottom: 20px;
  border: 1px solid #efefef;
  padding: 10px;
}
.order-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
}
.order-items {
  display: flex;
  flex-direction: column;
}
.order-item {
  display: flex;
  margin-bottom: 10px;
}
.item-image {
  width: 80px;
  height: 80px;
  margin-right: 10px;
}
.item-details {
  display: flex;
  flex: 1;
  justify-content: space-between;
  align-items: center;
}
.item-name {
  font-weight: bold;
}
.item-info-right {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  margin-left: auto;
}
.item-price {
  color: #C00000;
}
</style>
