var express = require('express')
var app = express()
var bodyParser = require('body-parser')
const server = require('http').createServer(app);

app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

// Serve static files từ thư mục public
// Các file trong public/ sẽ được truy cập qua URL: http://localhost:3000/public/...
const path = require('path');
app.use('/public', express.static(path.join(__dirname, 'public')));

// Hiển thị thông tin HTTP khi yêu cầu
app.use((req, res, next) => {
  console.log("🚀 ~ file: index.js:59 ~ app.use ~ req:", req.method + req.url);
  next();
});

var playListRouter = require('./routers/playlistRoter.js')
var topicRouter = require('./routers/topicRouter.js')
var categoryRouter = require('./routers/categoryRouter.js')
var songAgainRouter = require('./routers/songAgainRouter.js')
var albumRouter = require('./routers/albumRouter.js')
var songRouter = require('./routers/songRouter.js')
var songRankRouter = require('./routers/songRankRouter.js')
var userRouter = require('./routers/userRouter.js')
var musicVideoRouter = require('./routers/musicVideoRouter.js')
var lyricRouter = require('./routers/lyric.router.js')
var searchRouter = require('./routers/search.router.js')
var followRouter = require('./routers/follow_router.js')

// routers
app.use("/api", playListRouter)
app.use("/api", topicRouter)
app.use("/api", categoryRouter)
app.use("/api", songAgainRouter)
app.use("/api", albumRouter)
app.use("/api", songRouter)
app.use("/api", songRankRouter)
app.use("/api", userRouter)
app.use("/api", musicVideoRouter)
app.use("/api", lyricRouter)
app.use("/api", searchRouter)
app.use("/api", followRouter)

app.get('/api/getDeeplink', (req, res) => {
  const deeplink = 'https://6ztfh0rs-3000.asse.devtunnels.ms/live/stream/fb';
  res.json({ deeplink });
});

app.get("/.well-known/assetlinks.json", (req, res) => {
  res.json([{
    "relation": ["delegate_permission/common.handle_all_urls"],
    "target": {
      "namespace": "android_app",
      "package_name": "com.example.musicapp",
      "sha256_cert_fingerprints": [
        "8D:D1:06:52:C0:41:BF:4B:77:7E:C5:4B:F6:5E:34:F2:22:82:37:E4:C8:08:5F:3B:88:29:B7:27:D0:84:6F:77"
      ]
    }
  }]);
});


const port = process.env.PORT || 3000;
const os = require('os');

// Lấy địa chỉ IP của máy
function getLocalIPAddress() {
  const interfaces = os.networkInterfaces();
  for (const name of Object.keys(interfaces)) {
    for (const iface of interfaces[name]) {
      // Bỏ qua internal (localhost) và non-IPv4 addresses
      if (iface.family === 'IPv4' && !iface.internal) {
        return iface.address;
      }
    }
  }
  return 'localhost';
}

const localIP = getLocalIPAddress();

server.listen(port, '0.0.0.0', () => {
});