<template>
  <view class="container">
    <view class="form-item">
      <label class="label">收货姓名</label>
      <input class="input" type="text" v-model="name" placeholder="请输入收货姓名" />
      <text class="error-message" v-if="errors.name">收货姓名不能为空</text>
    </view>
    <view class="form-item">
      <label class="label">电话号码</label>
      <input class="input" type="number" v-model="phone" placeholder="请输入电话号码" />
      <text class="error-message" v-if="errors.phone">电话号码不能为空</text>
      <text class="error-message" v-if="errors.phoneFormat">手机格式不正确</text>
    </view>
    <view class="form-item">
      <label class="label">选择省市</label>
      <input class="input" type="text" v-model="city" placeholder="请选择省市" @click="openCityPicker" readonly />
      <text class="error-message" v-if="errors.city">请选择省市</text>
    </view>
    <view class="form-item">
      <label class="label">详细地址</label>
      <input class="input" type="text" v-model="address" placeholder="请输入详细地址" />
      <text class="error-message" v-if="errors.address">详细地址不能为空</text>
    </view>
    <view class="buttno-box">
      <button class="submit-button" @click="submit">提交</button>
    </view>

    <!-- 省市选择弹窗 -->
    <uni-popup ref="cityPicker" type="bottom">
      <picker mode="region" @change="onCityChange">
        <view>
          <button>请选择省市</button>
        </view>
      </picker>
    </uni-popup>

    <!-- 提交成功提示弹窗 -->
    <uni-popup ref="successPopup" type="center" :mask-click="false">
      <view class="success-popup-content">
        <text class="success-message">收货信息已添加成功！</text>
      </view>
    </uni-popup>
  </view>
</template>

<script>
export default {
  data() {
    return {
      name: '',
      phone: '',
      city: '',
      address: '',
      submitted: false,
      submittedData: {},
      errors: {}
    };
  },
  methods: {
    openCityPicker() {
      this.$refs.cityPicker.open();
    },
    onCityChange(event) {
      const { value } = event.target;
      this.city = value.join(' ');
      this.$refs.cityPicker.close();
    },
    validate() {
      this.errors = {};
      if (!this.name) this.errors.name = true;
      if (!this.phone) {
        this.errors.phone = true;
      } else if (!/^1\d{10}$/.test(this.phone)) {
        this.errors.phoneFormat = true;
      }
      if (!this.city) this.errors.city = true;
      if (!this.address) this.errors.address = true;
      return Object.keys(this.errors).length === 0;
    },
    generateUUID() {
      return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (Math.random() * 16) | 0,
          v = c == 'x' ? r : (r & 0x3) | 0x8;
        return v.toString(16);
      });
    },
    submit() {
      if (this.validate()) {
        const address_id = this.generateUUID(); // 使用自定义的 UUID 生成函数
        const submittedData = {
          address_id, // 添加 address_id
          name: this.name,
          phone: this.phone,
          city: this.city,
          address: this.address
        };
        this.$store.commit('address/addAddress', submittedData); // Use the namespaced path
        this.submitted = true;
        this.$refs.successPopup.open();
        setTimeout(() => {
          this.$refs.successPopup.close();
          uni.navigateTo({
            url: '/subpackages/address/address'
          });
        }, 1000); // 显示成功提示1秒后跳转
      }
    },
    closeSuccessPopup() {
      this.$refs.successPopup.close();
      this.resetForm();
      uni.navigateTo({
        url: '/subpackages/address/address'
      });
    },
    resetForm() {
      this.name = '';
      this.phone = '';
      this.city = '';
      this.address = '';
      this.errors = {};
    }
  }
};
</script>

<style>
.container {
  padding: 20px;
}
.form-item {
  margin-bottom: 15px;
}
.label {
  display: block;
  margin-bottom: 5px;
  font-size: 16px;
  color: #333;
}
.input {
  width: 100%;
  height: 40px;
  box-sizing: border-box;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 5px;
}
.input::placeholder {
  color: #999;
  font-size: 14px;
}
.error-message {
  color: red;
  font-size: 14px;
  margin-top: 5px;
}
.buttno-box {
  display: flex;
  align-items: center; /* 垂直方向居中 */
  justify-content: center; /* 水平方向居中 */
}
.submit-button {
  width: 200px;
  height: 50px;
  border-radius: 30px;
  background-color: #92E2C7;
  font-size: 20px;
  color: aliceblue;
}
.success-popup-content {
  padding: 20px;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.success-message {
  font-size: 18px;
  margin-bottom: 20px;
}
.success-popup-content button {
  padding: 10px 20px;
  font-size: 16px;
  color: #fff;
  background-color: #92E2C7;
  border: none;
  border-radius: 20px;
  width: 100px;
}
</style>
