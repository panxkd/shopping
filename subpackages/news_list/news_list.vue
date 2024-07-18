<template>
  <view class="container">
    <view class="news-list">
      <view class="author">发布人：管理员</view>
      <view class="divider"></view>
      <view class="title">{{ newsDetail.title }}</view>
      <view class="content">{{ newsDetail.content }}</view>
      <view class="images" v-if="newsDetail.imageUrls && newsDetail.imageUrls.length > 0">
        <image
          v-for="(img, index) in newsDetail.imageUrls"
          :key="index"
          :src="img"
          @click="previewImage(index)"
        ></image>
      </view>
    </view>
  
    <!-- 评论部分 -->
    <view class="comments-container">
      <view class="comments-input">
        <input type="text" v-model="newComment" placeholder="写评论..." />
        <button @click="sendComment(newsDetail.id)">发送</button>
      </view>
    </view>
  
    <!-- 评论展示 -->
    <view class="comments">
      <view class="comment" v-for="(comment, index) in comments" :key="index">
        <image src="/static/头像.png" class="avatar" />
        <view class="comment-content">
          <view class="comment-author">{{ comment.author }}</view>
          <view class="comment-text">{{ comment.content }}</view>
        </view>
      </view>
      <view v-if="comments.length === 0" class="no-comments">暂时没有评论</view>
    </view>
  </view>
</template>

<script>
import { mapState } from 'vuex';

export default {
  computed: {
    ...mapState('m_user', ['token', 'userinfo']),
    avatarSrc() {
      return this.userinfo.avatar || '/static/头像.png';
    }
  },
  data() {
    return {
      newsDetail: {
        title: '',
        content: '',
        imageUrls: [],
        id: null
      },
      comments: [],
      newComment: ''
    };
  },
  methods: {
    getNewsDetail(id) {
      uni.request({
        url: `http://8.138.16.110:8800/api/news/${id}`,
        method: 'GET',
        success: (res) => {
          if (res.data) {
            // 如果 imageUrls 是字符串，则将其转换为数组
            if (typeof res.data.imageUrls === 'string') {
              try {
                res.data.imageUrls = JSON.parse(res.data.imageUrls);
              } catch (e) {
                res.data.imageUrls = [];
              }
            }
            this.newsDetail = res.data;
          } else {
            console.error('无效的数据格式', res.data);
          }
        },
        fail: (err) => {
          console.error('数据加载失败', err);
        }
      });
    },
    previewImage(index) {
      uni.previewImage({
        current: this.newsDetail.imageUrls[index],
        urls: this.newsDetail.imageUrls
      });
    },
    fetchComments(newsId) {
		// console.log(newsId);
      uni.request({
        url: `http://8.138.16.110:8800/comments/news/${newsId}`,
        method: 'GET',
        // data: { news_id: newsId },
        success: (res) => {
          if (res.data) {
            this.comments = res.data;
          } else {
            console.error('无效的评论数据格式', res.data);
          }
        },
        fail: (err) => {
          console.error('评论加载失败', err);
        }
      });
    },
	  async sendComment(news_id) {
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
		  if (!this.newComment.trim()) {
			uni.showToast({
			  title: '评论内容不能为空',
			  icon: 'none'
			});
			return;
		  }

		  const newCommentData = {
			newsId: news_id,
			content: this.newComment,
			author: this.userinfo.nickName
		  };

		  console.log('发送的评论数据:', newCommentData); // 打印发送的数据
		  
		  const [error, res] = await new Promise((resolve) => {
			uni.request({
			  url: `http://8.138.16.110:8800/comments`,
			  method: 'POST',
			  data: newCommentData,
			  header: {
				'Content-Type': 'application/json',
				'Authorization': `Bearer ${this.token}`
			  },
			  success: (res) => resolve([null, res]),
			  fail: (err) => resolve([err, null])
			});
		  });

		  if (error) {
			console.error('评论失败', error);
			this.showToast('评论失败');
			return;
		  }

		  if (res.statusCode === 200) {
			this.comments.push(newCommentData);
			this.newComment = '';
		  } else {
			this.showToast('评论失败');
		  }
		} catch (error) {
		  console.error('Error in sending comment:', error);
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
  },
  onLoad(options) {
    if (options.id) {
      this.getNewsDetail(options.id);
      this.fetchComments(options.id);
    }
  }
};
</script>

<style lang="scss" scoped>
.container {
  padding-bottom: 70px;
}
.news-list {
  border-bottom: 4px solid #efefef;
  padding: 20px;
}
.author {
  font-size: 14px;
  color: #666;
  margin-bottom: 10px;
}
.divider {
  border-bottom: 1px solid #ddd;
  margin-bottom: 10px;
}
.title {
  font-weight: bold;
  font-size: 18px;
  margin-bottom: 10px;
}
.content {
  font-size: 16px;
  margin-bottom: 20px;
}
.images {
  display: flex;
  flex-direction: column;
}
.news-image {
  width: 100%;
  height: auto;
  margin-bottom: 10px;
}
.comments-container {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 40px;
  border-top: 1px solid #d0d0d0;
  z-index: 999;
  background-color: #efefef;
  padding: 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.comments-input {
  display: flex;
  flex: 1;
  justify-content: space-between;
}
.comments-input input {
  flex: 1;
  height: 30px;
  padding: 0 10px;
  border: 1px solid #d0d0d0;
  border-radius: 4px;
  margin-right: 10px;
}
.comments-input button {
  height: 30px;
  margin-left: 10px;
  margin-right: 15px;
  border: 1px solid #d0d0d0;
  color: #7a7a7a;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}
.comments {
  margin-top: 20px;
}
.comment {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}
.avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  margin-right: 10px;
}
.comment-content {
  flex: 1;
}
.comment-author {
  font-weight: bold;
}
.comment-text {
  font-size: 14px;
}
.no-comments {
  color: #999;
}
</style>
