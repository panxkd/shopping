const state = {
  addresses: [],
  selectedAddress: null
};

const mutations = {
  addAddress(state, address) {
    state.addresses.push(address);
  },
  selectAddress(state, address) {
    state.selectedAddress = address;
  },
  deleteAddress(state, address) {
    state.addresses = state.addresses.filter(item => item.address_id !== address.address_id);
  }
};

export default {
  namespaced: true,
  state,
  mutations
};
