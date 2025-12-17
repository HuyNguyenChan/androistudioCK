// Script để lấy IP address của máy tính
const os = require('os');

function getLocalIPAddress() {
  const interfaces = os.networkInterfaces();
  const ips = [];
  
  for (const name of Object.keys(interfaces)) {
    for (const iface of interfaces[name]) {
      // Bỏ qua internal (localhost) và non-IPv4 addresses
      if (iface.family === 'IPv4' && !iface.internal) {
        ips.push({
          interface: name,
          address: iface.address,
          netmask: iface.netmask
        });
      }
    }
  }
  
  return ips;
}

const ips = getLocalIPAddress();

console.log('📡 Địa chỉ IP của máy tính:\n');
if (ips.length === 0) {
  console.log('❌ Không tìm thấy IP address!');
} else {
  ips.forEach((ip, index) => {
    console.log(`${index + 1}. Interface: ${ip.interface}`);
    console.log(`   IP: ${ip.address}`);
    console.log(`   URL cho Android: http://${ip.address}:3000/api\n`);
  });
  
  // IP đầu tiên thường là IP chính
  console.log(`✅ Sử dụng IP: ${ips[0].address}`);
  console.log(`📱 Base URL cho Android: http://${ips[0].address}:3000/api`);
}

