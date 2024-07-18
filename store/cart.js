export default {
  namespaced: true,
  state: () => ({
    cart: JSON.parse(uni.getStorageSync('cart') || '[]')
  }),
  mutations: {
    addToCart(state, goods1) {
      const findResult = state.cart.find(x => x.goods1_id == goods1.goods1_id);
      if (!findResult) {
        state.cart.push(goods1);
      } else {
        findResult.goods1_count++;
      }
      this.commit('m_cart/saveToStorage');
    },
    saveToStorage(state) {
      uni.setStorageSync('cart', JSON.stringify(state.cart));
    },
    updateCartQuantity(state, { goods1_id, quantity }) {
      const item = state.cart.find(x => x.goods1_id == goods1_id);
      if (item) {
        item.goods1_count = quantity;
        this.commit('m_cart/saveToStorage');
        this.commit('m_cart/updateTotal');
      }
    }
  },
  getters: {
    total(state) {
      return state.cart.reduce((acc, item) => acc + item.goods1_count, 0);
    }
  }
}
