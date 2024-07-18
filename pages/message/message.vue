<template>
  <view class="container">
    <view v-for="item in newsList" :key="item.id" class="news-box" @click="gotoNews(item)">
      <view class="news-text">
        <view class="news-title">{{ item.title }}</view>
        <view class="news-content">{{ item.content }}</view>
        <view class="news-author">发布人：管理员</view>
      </view>
      <image v-if="item.imageUrls && item.imageUrls.length > 0" :src="item.imageUrls[0]" class="news-image"></image>
    </view>
  </view>
</template>

<script>
import badgeMix from '@/mixins/tabbar-badge.js';

export default {
  mixins: [badgeMix],
  data() {
    return {
      newsList: []
    };
  },
  methods: {
    getNewsList() {
      uni.request({
        url: 'http://8.138.16.110:8800/api/news',
        method: 'GET',
        success: (res) => {
          console.log('服务器返回数据:', res.data);
          if (res.data && Array.isArray(res.data)) {
            this.newsList = res.data;
          } else {
            console.error('无效的数据格式', res.data);
          }
        },
        fail: (err) => {
          console.error('数据加载失败', err);
        }
      });
    },
    gotoNews(item) {
      uni.navigateTo({
        url: '/subpackages/news_list/news_list?id=' + item.id
      });
    }
  },
  mounted() {
    this.getNewsList();
  }
};
</script>

<style lang="scss" scoped>
.container {
  padding-bottom: 50px;
}

.news-box {
  border-bottom: 1px solid #efefef;
  padding: 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.news-text {
  flex: 1;
  margin-right: 10px;
}

.news-title {
  font-weight: bold;
  margin-bottom: 5px;
}

.news-content {
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  overflow: hidden;
  text-overflow: ellipsis;
  margin-bottom: 5px;
}

.news-image {
  width: 100px;
  height: 100px;
}

.news-author {
  font-size: 12px;
  color: #666;
  margin-top: 20px;
}
</style>
