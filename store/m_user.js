export default {
  namespaced: true,
  
  state: () => ({
    token: uni.getStorageSync('token') || '',
    userinfo: (() => {
      try {
        return JSON.parse(uni.getStorageSync('userinfo')) || {};
      } catch (error) {
        console.error('无法解析用户', error);
        uni.removeStorageSync('userinfo');
        return {};
      }
    })()
  }),

  mutations: {
    updateUserinfo(state, userinfo) {
      state.userinfo = userinfo;
      this.commit('m_user/saveUserinfoToStorage');
    },
    saveUserinfoToStorage(state) {
      uni.setStorageSync('userinfo', JSON.stringify(state.userinfo));
    },
    updateToken(state, token) {
      state.token = token;
      this.commit('m_user/saveTokenToStorage');
    },
    saveTokenToStorage(state) {
      uni.setStorageSync('token', state.token);
    },
    clearUserinfo(state) {
      state.userinfo = {};
      this.commit('m_user/saveUserinfoToStorage');
    },
    clearToken(state) {
      state.token = '';
      this.commit('m_user/saveTokenToStorage');
    },
    updateAvatar(state, avatar) {
      state.userinfo.avatar = avatar;
      this.commit('m_user/saveUserinfoToStorage');
    }
  }
}
