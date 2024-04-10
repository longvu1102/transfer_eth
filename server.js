// Nhập thư viện express
const express = require('express');

// Khởi tạo app
const app = express();

// Cài đặt port
const port = 3000;

app.get('/', (req, res) => {
  res.send('Xin chào từ server Node.js!');
});

app.listen(port, () => {
  console.log(`App đang chạy tại http://localhost:${port}`);
});