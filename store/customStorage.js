// customStorage.js
export default {
  getItem(key) {
    return uni.getStorageSync(key);
  },
  setItem(key, value) {
    return uni.setStorageSync(key, value);
  },
  removeItem(key) {
    return uni.removeStorageSync(key);
  }
};
