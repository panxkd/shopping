import { createStore } from 'vuex';
import createPersistedState from 'vuex-persistedstate';
import address from '@/store/address.js'; // 引入 address 模块
import m_cart from '@/store/m_cart'; // 引入 m_cart 模块
import customStorage from '@/store/customStorage'; // 引入自定义存储插件
import m_user from '@/store/m_user';
import m_orders from '@/store/m_orders';
const store = createStore({
  modules: {
    address,
    m_cart,
	m_user,
	m_orders
  },
  plugins: [
    createPersistedState({
      key: 'my-app',
      paths: ['address'], // 只持久化 address 模块
      storage: customStorage // 使用自定义存储插件
    })
  ]
});

export default store;
