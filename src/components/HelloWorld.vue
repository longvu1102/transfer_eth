<template>
  <div class="container py-5" :class="{ 'dark-mode': darkMode }">
    <div id="toggle-dark-mode">
      <label for="dark-mode-switch">Chế độ dark mode:</label>
      <input type="checkbox" id="dark-mode-switch" v-model="darkMode">
    </div>
    <div id="metamaskLogo"></div>
    <h2 class="mb-4">Chuyển Ether</h2>
    <div class="mb-4" id="accountDetails">
      <strong>Ví:</strong> <span>{{ address }}</span><br>
      <strong>Số dư:</strong> <span>{{ balance }}</span> ETH
    </div>
    <form @submit.prevent="transferEther" novalidate>
      <div class="mb-3">
        <label for="recipientAddress" class="form-label">Đến địa chỉ:</label>
        <input v-model="recipient" id="recipientAddress" type="text" class="form-control" placeholder="Địa chỉ nhận" required />
        <div class="invalid-feedback">Vui lòng nhập địa chỉ người nhận.</div>
      </div>
      <div class="mb-3">
        <label for="amount" class="form-label">Số lượng Ether để gửi:</label>
        <input v-model="amount" id="amount" type="number" class="form-control" placeholder="Số lượng Ether" step="0.001" required />
        <div class="invalid-feedback">Vui lòng nhập số lượng Ether.</div>
      </div>
      <button type="submit" class="btn btn-primary">Chuyển Ether</button>
    </form>
  </div>
</template>

<script>
/* global ethers */
export default {
  name:'HelloWord',
  data() {
    return {
      address: "",
      balance: "",
      recipient: "",
      amount: 0,
      darkMode: false,
    };
  },
  async created() {
    if (window.ethereum) {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      
      const accounts = await window.ethereum.request({ method: 'eth_accounts' });
      this.address = accounts[0];

      const balanceWei = await provider.getBalance(this.address);
      this.balance = ethers.utils.formatEther(balanceWei);
    } else {
      alert('Ứng dụng này yêu cầu Metamask!');
    }
  },
  methods: {
    async transferEther() {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await window.ethereum.enable();

      const accounts = await provider.listAccounts();
      const signer = provider.getSigner(accounts[0]);
      
      const amount = ethers.utils.parseEther(this.amount.toString());
      
      const tx = {
        to: this.recipient,
        value: amount
      };
      
      const transactionResponse = await signer.sendTransaction(tx);
      const transactionResult = await transactionResponse.wait();
      
      alert('Giao dịch thành công! Hash của giao dịch: ' + transactionResult.transactionHash);
    },
  },
};
</script>

<style scoped>
template{
   background-color: #1E2028;
}
.container {
  margin-top:70px;
  color: #fff;
  text-align: center;
  max-width: 400px;
  border: 1px solid #404040;
  border-radius: 10px;
  padding: 20px;
  background-color: #404040;
}
.container.dark-mode {
  background-color: #1E2028;
  color: #fff;
}
#toggle-dark-mode {
  position: fixed;
  top: 0;
  right: 0;
  margin: 20px;
}
#metamaskLogo {
  width: 100px;
  height: 100px;
  background-position: center;
  background-repeat: no-repeat;
  background-size: contain;
  background-image: url('https://th.bing.com/th/id/R.624f4bb88588544dca326a64ea5cf3d2?rik=%2bBgTIHIz2SffKg&riu=http%3a%2f%2fwww.etherlambos.io%2fimg%2fmetamask.png&ehk=ObpzVx5gQr6xwCMvOkmo2%2bQBw9iQuX%2bcFMmRbuOYScM%3d&risl=&pid=ImgRaw&r=0');
  margin: auto;
}
</style>