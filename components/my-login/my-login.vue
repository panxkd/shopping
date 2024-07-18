<template>
	<view class="login-container">
		<uni-icons type="contact-filled" size="100" color="#efefef"></uni-icons>
		<button type="primary" class="btn-login" open-type="getUserInfo" @getuserinfo="getUserInfo">一键登录</button>
	</view>
</template>

<script>
import { mapMutations } from 'vuex';

export default {
	name: "my-login",
	data() {
		return {};
	},
	methods: {
		...mapMutations('m_user', ['updateUserinfo', 'updateToken']),
		async getUserInfo(e) {
			console.log(e);
			if (e.detail.userInfo) {
				this.updateUserinfo(e.detail.userInfo);
			} else {
				uni.showToast({ title: '授权失败', icon: 'none' });
				return;
			}
			await this.getToken(e.detail);
		},
		async getToken(info) {
			try {
				const res = await uni.login();
				if (res.errMsg !== 'login:ok') {
					this.showToast('登录失败！');
					return;
				}
				const query = {
					code: res.code,
					encryptedData: info.encryptedData,
					iv: info.iv,
					rawData: info.rawData,
					signature: info.signature
				};
				console.log(query.code);

				const response = await uni.request({
					url: 'http://8.138.16.110:8800/api/user/login',
					method: 'POST',
					header: {
						'Content-Type': 'application/json'
					},
					data: query,
					dataType: 'json'
				});

				if (response.statusCode === 200 && response.data.token) {
					this.updateToken(response.data.token);
				} else {
					this.showToast('登录失败！');
					console.error('登录失败：', response.data);
				}
			} catch (error) {
				this.showToast('登录失败！');
				console.error('请求错误：', error);
			}
		},
		showToast(message) {
			uni.showToast({
				title: message,
				duration: 1500,
				icon: 'none'
			});
		}
	}
}
</script>

<style lang="scss">
.login-container {
	height: 80vh;
	background-color: #f8f8f8;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	position: relative;
	overflow: hidden;
	&::after {
		content: '';
		display: block;
		width: 100%;
		height: 40px;
		position: absolute;
		bottom: 0;
		left: 0;
		border-radius: 100%;
		transform: translateY(50%);
		background-color: white;
	}
	.btn-login {
		width: 90%;
		border-radius: 100px;
		margin: 15px 0;
		background-color: #92E2C7;
		color: white;
	}
}
</style>
