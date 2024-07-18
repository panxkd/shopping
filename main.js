// #ifndef VUE3
import Vue from 'vue';
import App from './App';
import store from '@/store/store.js';

// 导入网络请求的包
import { $http } from '@escook/request-miniprogram';

// 请求拦截器
uni.$http = $http;
$http.baseUrl = 'http://www.uniav.com';

$http.beforeRequest = function (options) {
  uni.showLoading({
    title: '加载中...'
  });
};

// 响应拦截器
$http.afterRequest = function () {
  uni.hideLoading();
};

// 封装弹框方法
uni.$showMsg = function (title = '数据请求失败！', duration = 1500) {
  uni.showToast({
    title,
    duration,
    icon: 'none'
  });
};

Vue.config.productionTip = false;

App.mpType = 'app';

const app = new Vue({
  ...App,
  store
});
app.$mount();
// #endif

// #ifdef VUE3
import { createSSRApp } from 'vue';
import store from '@/store/store.js';


export function createApp() {
  const app = createSSRApp(App);
  app.use(store);
  return {
    app
  };
}
// #endif
