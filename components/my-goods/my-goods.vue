<template>
  <view id="app">
    <view class="container">
      <view class="column" v-for="(column, index) in productColumns" :key="index">
        <view class="product-box" v-for="product in column" :key="product.id">
          <img :src="product.image" class="product-img" :alt="product.name">
          <view class="product-name">{{ product.name }}</view>
          <view class="product-price">¥{{ product.price }}</view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: "my-goods",
  props: {
    product: {
      type: Object,
      default: {}
    }
  },
  data() {
    return {
      
    };
  }
}
</script>

<style scoped lang="scss">
.container {
  display: flex;
  justify-content: space-between;
  padding: 0;
  flex-wrap: wrap;
}

.column {
  flex: 1;
  padding: 5px;
  border: 0px solid #ccc;
  border-radius: 10px;
  margin: 5px; /* 减小间距 */
}

.product-box {
  display: flex;
  flex-direction: column;
  padding: 0; /* 移除内边距 */
  border: 1px solid #ddd;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  margin-bottom: 10px;
  max-width: 100%; /* 调整为百分比，确保不超出屏幕 */
}

.product-box img {
  width: 100%;
  max-height: 150px;
  object-fit: cover;
  border-radius: 10px 10px 0 0; /* 确保图片和盒子边角对齐 */
  margin: 0; /* 移除图片的外边距 */
}

.product-name {
  margin-top: 0; /* 确保没有间距 */
  font-size: 16px;
  font-weight: bold;
  padding: 10px 10px; /* 增加适当的内边距以分隔内容 */
}

.product-price {
  margin-top: 0; /* 确保没有间距 */
  font-size: 14px;
  color: #f00;
  padding: 0px 10px; /* 增加适当的内边距以分隔内容 */
  padding-bottom: 10px ; /* 增加适当的内边距以分隔内容 */
}

.product-img {
  border-radius: 10px 10px 0 0; 
  width: 100%; /* 设定为百分比，确保不超出屏幕 */
  height: 400rpx;
}
</style>
