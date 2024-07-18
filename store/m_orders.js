// store/modules/m_orders.js

const state = () => ({
  orders: JSON.parse(uni.getStorageSync('orders') || '[]')
});

const mutations = {
  saveOrder(state, orders) {
    state.orders.push(orders);
    this.commit('m_orders/saveToStorage');
  },
  saveToStorage(state) {
    uni.setStorageSync('orders', JSON.stringify(state.orders));
  }
};

const actions = {
  submitOrder({ commit }, orders) {
    commit('saveOrder', orders);
  }
};

export default {
  namespaced: true,
  state,
  mutations,
  actions
};
