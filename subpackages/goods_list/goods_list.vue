<template>
  <view class="search-box">
    <mysearch @click="gotosearch()"></mysearch>
  </view>
  <view id="app">
    <view class="container">
      <view class="column" v-for="(column, index) in productColumns" :key="index">
        <view class="product-box" v-for="product in column" :key="product.id" @click="gotoDetail(product)">
          <image :src="product.images[0]" class="product-img" :alt="product.name"></image>
          <view class="product-name">{{ product.name }}</view>
          <view class="product-price">¥{{ product.price }}</view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      queryObj: {
        query: '',
        goods_id: '',
        goods_type: ''
      },
      products: [],
      total: 0
    };
  },
  onLoad(options) {
    this.queryObj.query = options.goods_name || ''; // 接收传递的 goods_name 参数
    this.queryObj.goods_id = options.goods_id || '';
    this.queryObj.goods_type = options.goods_type || ''; // 接收传递的 goods_type 参数
    this.getProducts();
  },
  methods: {
    async getProducts(cb) {
      try {
        const res = await uni.request({
          url: 'http://8.138.16.110:8800/api/products',
          method: 'GET'
        });

        if (res.statusCode === 200) {
          // 过滤商品列表，显示符合条件的商品
          this.products = res.data.filter(product => 
            (this.queryObj.query ? product.name.includes(this.queryObj.query):true)&&
			(this.queryObj.goods_type ? product.type===this.queryObj.goods_type:true)
          ).map(product => {
            return {
              ...product,
              images: JSON.parse(product.images) // 解析image字段
            };
          });
          if (cb) cb();
        } else {
          uni.showToast({
            title: '数据加载失败',
            icon: 'none'
          });
          console.error('服务器错误:', res);
        }
      } catch (error) {
        uni.showToast({
          title: '数据加载失败',
          icon: 'none'
        });
        console.error('请求异常:', error);
      }
    },
    gotoDetail(product) {
      uni.navigateTo({
        url: '/subpackages/goods_detail/goods_detail?goods_id=' + product.id
      });
    },
    gotosearch() {
      uni.navigateTo({
        url: '/subpackages/search/search'
      });
    }
  },
  computed: {
    productColumns() {
      const columns = [[], []];
      this.products.forEach((product, index) => {
        columns[index % 2].push(product);
      });
      return columns;
    }
  }
};
</script>

<style scoped>
.search-box {
  position: sticky;
  top: 0;
  z-index: 999;
}
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
  margin: 5px;
}

.product-box {
  display: flex;
  flex-direction: column;
  padding: 0;
  border: 1px solid #ddd;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  margin-bottom: 10px;
  max-width: 100%;
}

.product-box img {
  width: 100%;
  max-height: 150px;
  object-fit: cover;
  border-radius: 10px 10px 0 0;
  margin: 0;
}

.product-name {
  margin-top: 0;
  font-size: 16px;
  font-weight: bold;
  padding: 10px 10px;
}

.product-price {
  margin-top: 0;
  font-size: 18px;
  font-weight: bold;
  color: #f00;
  padding: 0px 10px;
  padding-bottom: 10px;
}

.product-img {
  border-radius: 10px 10px 0 0;
  width: 100%;
  height: 400rpx;
}
</style>
