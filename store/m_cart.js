const state = () => ({
  cart: JSON.parse(uni.getStorageSync('cart') || '[]'),
  total: 0,
  selectAll: false,
  totalAmount: 0,

});

const getters = {
  total(state) {
    return state.cart.reduce((acc, item) => acc + item.goods1_count, 0);
  }
};

const mutations = {
  addToCart(state, goods1) {
    const findResult = state.cart.find(x => x.goods1_id == goods1.goods1_id);
    if (!findResult) {
      state.cart.push({ ...goods1, goods1_state: false });
    } else {
      findResult.goods1_count++;
    }
    this.commit('m_cart/updateTotal');
    this.commit('m_cart/saveToStorage');
    this.commit('m_cart/updateBadge');  // 更新徽标
  },
  saveToStorage(state) {
    uni.setStorageSync('cart', JSON.stringify(state.cart));
  },
  updateCartQuantity(state, { goods1_id, quantity }) {
    const item = state.cart.find(x => x.goods1_id == goods1_id);
    if (item) {
      item.goods1_count = quantity;
      this.commit('m_cart/updateTotal');
      this.commit('m_cart/calculateTotal');
      this.commit('m_cart/saveToStorage');
      this.commit('m_cart/updateBadge');  // 更新徽标
    }
  },
  updateTotal(state) {
    state.total = state.cart.reduce((acc, item) => acc + item.goods1_count, 0);
  },
  toggleGoodsState(state, goods1_id) {
    const item = state.cart.find(x => x.goods1_id == goods1_id);
    if (item) {
      item.goods1_state = !item.goods1_state;
      this.commit('m_cart/calculateTotal');
      this.commit('m_cart/saveToStorage');
      this.commit('m_cart/updateBadge');  // 更新徽标
    }
  },
  calculateTotal(state) {
    state.totalAmount = state.cart.reduce((acc, item) => {
      return item.goods1_state ? acc + item.goods1_count * item.goods1_price : acc;
    }, 0);
  },
  removeFromCart(state, goods1_id) {
    const index = state.cart.findIndex(x => x.goods1_id == goods1_id);
    if (index !== -1) {
      state.cart.splice(index, 1);
      this.commit('m_cart/calculateTotal');
      this.commit('m_cart/updateTotal');
      this.commit('m_cart/saveToStorage');
      this.commit('m_cart/updateBadge');  // 更新徽标
    }
  },
  updateBadge(state) {
    uni.setTabBarBadge({
      index: 3, // 购物车在tabBar中的索引
      text: state.total + ''  // 从Vuex中获取总数
    });
  },
  toggleSelectAll(state) {
    state.selectAll = !state.selectAll;
    state.cart.forEach(item => {
      item.goods1_state = state.selectAll;
    });
    this.commit('m_cart/calculateTotal');
    this.commit('m_cart/saveToStorage');
    this.commit('m_cart/updateBadge');
  }
};

const actions = {};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
};