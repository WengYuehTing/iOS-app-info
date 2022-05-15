# iOS-app-info

iOS APP的Bundle ID, App Store App ID和URL Scheme信息汇总，**将持續更新!**，也欢迎大家一起来维护！🙏
- Bundle ID：iOS应用程序的唯一标识符，格式通常为com.company.appName，由开发人员命名。即使修改应用程序的功能、名称和图标，只要Bundle ID没变，就是代表同一个应用程序。
- App Store App ID (App Store ID)：App Store的应用程序标识符，由商店自行分配。一个应用的App Store ID会暴露在其下载页的url链接里。以微信为例，微信的App Store链接为https://apps.apple.com/cn/app/wechat/id414478124 ，可以看到其App Store ID为414478124。 
- URL Scheme：系统提供的一种应用间交互和跳转机制，可以从外部直接访问一个应用的特定业务。URL Scheme本质上是一个字符串，如weixin://scanqrcode，用来打开微信的扫一扫页面。本文只收集用于启动应用的URL Scheme。

## Use Cases
可以通过Bundle ID和App Store ID获取到该应用的详细信息(如：应用名称、图标、发布日期、版本等)：
```
https://itunes.apple.com/cn/lookup?bundleId=[bundle id]
https://itunes.apple.com/cn/lookup?id=[app id]
```

Bundle ID和App Store ID互相转换的swift脚本，获取版本号、图标等其他信息也是通过这个方法。

* [bundle2app.swift](https://github.com/WengYuehTing/iOS-app-info/blob/main/bundle2app.swift)：根据Bundle ID获取App Store ID
```
swift bundle2app.swift com.tencent.xin com.tencent.ww
```

* [app2bundle.swift](https://github.com/WengYuehTing/iOS-app-info/blob/main/app2bundle.swift)：根据App Store ID获取Bundle ID
```
swift app2bundle.swift 414478124 1087897068 952059546
```

URL Scheme的使用案例

* 判断iOS设备是否安装某应用 
```xml
<!--需要先在info.plist里将需要使用的URL Scheme的前缀添加到LSApplicationQueriesSchemes键(白名单)，否则UIApplication.shared.canOpenURL(_:)总是会返回false。-->
<plist version="1.0">
<dict>
<key>LSApplicationQueriesSchemes</key>
  <array>
    <string>weixin</string>
  </array>
</dict>
</plist>
```  

```swift
func canPerform(urlScheme: String) -> Bool {
    if let url = URL(string: urlScheme) {
        return UIApplication.shared.canOpenURL(url)
    }
    
    return false
}

if canPerform(urlScheme: "weixin://") {
    // 该设备已下载微信
}
```

* 使用URL Scheme进行跳转
```swift
func perform(urlScheme: String) {
    guard let url = URL(string: urlScheme) else {
        return
    }

    if #available(iOS 10, *) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil) // modify completion callback here if need
    } else {
        UIApplication.shared.openURL(url)
    }
}

```

## 查询结果
| 应用          | Bundle ID                         | App Store ID  | URL Scheme                      |
| ------------- | --------------------------------- | ---------- | ------------------------------- |
| 微信          | com.tencent.xin                   | 414478124  | weixin://                       |
| 企业微信      | com.tencent.ww                    | 1087897068 | wxwork://                       |
| 微信读书      | com.tencent.weread                | 952059546  | weread://                       |
| 微信听书      | com.tencent.wehear                | 1522424583 | wehear://                       |
| QQ            | com.tencent.mqq                   | 444934666  | mqq://                          |
| QQ音乐        | com.tencent.QQMusic               | 414603431  | qqmusic://                      |
| QQ阅读        | com.tencent.qqreaderiphone        | 487608658  | qqreader://                     |
| QQ邮箱        | com.tencent.qqmail                | 473225145  | qqmail://                       |
| QQ浏览器      | com.tencent.mttlite               | 370139302  | mqqbrowser://                   |
| TIM           | com.tencent.tim                   | 1175213887 | timapi://                       |
| 微视          | com.tencent.microvision           | 691828408  | weishi://                       |
| 腾讯新闻      | com.tencent.info                  | 399363156  | qqnews://                       |
| 腾讯视频      | com.tencent.live4iphone           | 458318329  | tenvideo://                     |
| 腾讯动漫      | com.tencent.ied.app.comic         | 569387346  | comicreader://                  |
| 腾讯微云      | com.tencent.weiyun                | 522700349  | weiyun://                       |
| 腾讯体育      | com.tencent.sportskbs             | 570608623  | wwauthab249edd27d57738000551:// |
| 腾讯文档      | com.tencent.txdocs                | 1370780836 | tencentdocs://                  |
| 腾讯翻译君    | com.tencent.qqtranslator          | 1101000245 | qqtranslator://                 |
| 腾讯课堂      | com.tencent.edu                   | 931720936  | tencentedu://                   |
| 腾讯地图      | com.tencent.sosomap               | 481623196  | qqmap://                        |
| 小鹅拼拼      | com.tencent.dwdcoco               | 1561898403 | dwdcoco://                      |
| 支付宝        | com.alipay.iphoneclient           | 333206289  | alipay://                       |
| 钉钉          | com.laiwang.DingTalk              | 930368978  | dingtalk://                     |
| 闲鱼          | com.taobao.fleamarket             | 510909506  | fleamarket://                   |
| 淘宝          | com.taobao.taobao4iphone          | 387682726  | taobao://                       |
| 斗鱼          | tv.douyu.live                     | 863882795  | douyutv://                      |
| 天猫          | com.taobao.tmall                  | 518966501  | tmall://                        |
| 口碑          | com.taobao.kbmeishi               | 390860325  | koubei://                       |
| 饿了么        | me.ele.ios.eleme                  | 507161324  | eleme://                        |
| 高德地图      | com.autonavi.amap                 | 461703208  | iosamap://                      |
| UC浏览器      | com.ucweb.iphone.lowversion       | 586871187  | ucbrowser://                    |
| 一淘          | com.taobao.etaocoupon             | 451400917  | etao://                         |
| 飞猪          | com.taobao.travel                 | 453691481  | taobaotravel://                 |
| 虾米音乐      | com.xiami.spark                   | 1558998400 | xiami://                        |
| 淘票票        | com.taobao.movie.MoviePhoneClient | 566813949  | laiwang21798646://              |
| 优酷          | com.youku.YouKu                   | 336141475  | youku://                        |
| 菜鸟裹裹      | com.cainiao.cnwireless            | 951610982  | cainiao://                      |
| 土豆视频      | com.tudou.tudouiphone             | 395898626  | tudou://                        |
| 抖音          | com.ss.iphone.ugc.Aweme           | 1142110895 | snssdk1128://                   |
| 抖音极速版    | com.ss.iphone.ugc.aweme.lite      | 1477031443 | snssdk2329://                   |
| 抖音火山版    | com.ss.iphone.ugc.Live            | 1086047750 | snssdk1112://                   |
| Tiktok        | com.zhiliaoapp.musically          | 835599320  | tiktok://                       |
| 今日头条      | com.ss.iphone.article.News        | 529092160  | snssdk141://                    |
| 西瓜视频      | com.ss.iphone.article.Video       | 1134496215 | snssdk32://                     |
| 皮皮虾        | com.bd.iphone.super               | 1393912676 | bds://                          |
| 美团          | com.meituan.imeituan              | 423084029  | imeituan://                     |
| 美团外卖      | com.meituan.itakeaway             | 737310995  | meituanwaimai://                |
| 大众点评      | com.dianping.dpscope              | 351091731  | dianping://                     |
| 美团优选      | com.meituan.iyouxuan              | 1541102709 | iyouxuan://                     |
| 美团优选团长  | com.meituan.igrocery.gh           | 1541299584 | igrocery://                     |
| 美团骑手      | com.meituan.banma.homebrew        | 1499806327 | homebrew://                     |
| 美团开店宝    | com.meituan.imerchantbiz          | 592673661  | merchant://                     |
| 美团拍店      | com.meituan.pai                   | 1062216675 | paidian://                      |
| 美团众包      | com.meituan.banma.crowdsource     | 1067251466 | crowdsource://                  |
| 美团买菜      | com.baobaoaichi.imaicai           | 1444411068 | imaicai://                      |
| 京东          | com.360buy.jdmobile               | 414245413  | openapp.jdmoble://              |
| 京东读书      | com.jd.reader                     | 1330602531 | openapp.jdreader://             |
| 网易新闻      | com.netease.news                  | 425349261  | newsapp://                      |
| 网易云音乐    | com.netease.cloudmusic            | 590338362  | orpheus://                      |
| 网易邮箱大师  | com.netease.macmail               | 897003024  | neteasemail://                  |
| 网易严选      | com.netease.yanxuan               | 1065178761 | yanxuan://                      |
| 网易公开课    | com.netease.videoHD               | 415424368  | ntesopen://                     |
| 网易有道词典  | youdaoPro                         | 353115739  | yddict://                       |
| 百度          | com.baidu.BaiduMobile             | 382201985  | baiduboxapp://                  |
| 百度网盘      | com.baidu.netdisk                 | 547166701  | baiduyun://                     |
| 百度贴吧      | com.baidu.tieba                   | 477927812  | com.baidu.tieba://              |
| 百度地图      | com.baidu.map                     | 452186370  | baidumap://                     |
| 百度阅读      | com.baidu.yuedu                   | 714802729  | bdbook://                       |
| 百度翻译      | com.baidu.translate               | 605670941  | baidutranslate://               |
| 百度文库      | com.baidu.Wenku                   | 426340811  | bdwenku://                      |
| 百度视频      | com.baidu.videoiphone             | 588287777  | bdviphapp://                    |
| 百度输入法    | com.baidu.inputMethod             | 916139408  | BaiduIMShop://                  |
| 快手          | com.jiangjia.gif                  | 440948110  | kwai://                         |
| 快手极速版    | com.kuaishou.nebula               | 1472502819 | ksnebula://                     |
| 哔哩哔哩      | tv.danmaku.bilianime              | 736536022  | bilibili://                     |
| 芒果TV        | com.hunantv.imgotv                | 629774477  | imgotv://                       |
| 苏宁易购      | SuningEMall                       | 424598114  | suning://                       |
| 有道云笔记    | com.youdao.note.YoudaoNoteMac     | 450748070  | youdaonote://                   |
| 微博          | com.sina.weibo                    | 350962117  | sinaweibo://                    |
| 微博极速版    | com.sina.weibolite                | 1335931132 | weibolite://                    |
| 微博国际      | com.weibo.international           | 1215210046 | weibointernational://           |
| 墨客          | com.moke.moke.iphone              | 966113886  | moke://                         |
| 豆瓣          | com.douban.frodo                  | 907002334  | douban://                       |
| 知乎          | com.zhihu.ios                     | 432274380  | zhihu://                        |
| 小红书        | com.xingin.discover               | 741292507  | xhsdiscover://                  |
| 喜马拉雅      | com.gemd.iting                    | 876336838  | iting://                        |
| 得到          | com.luojilab.LuoJiFM-IOS          | 1016323413 | dedaoapp://                     |
| 得物          | com.siwuai.duapp                  | 1012871328 | dewuapp://                      |
| 起点读书      | m.qidian.QDReaderAppStore         | 534174796  | QDReader://                     |
| 番茄小说      | com.dragon.read                   | 1468454200 | dragon1967://                   |
| 书旗小说      | com.shuqicenter.reader            | 733689509  | shuqireaderap://                |
| 拼多多        | com.xunmeng.pinduoduo             | 1044283059 | pinduoduo://                    |
| 多点          | com.dmall.dmall                   | 1002314698 | dmall://                        |
| 便利蜂        | com.bianlifeng.customer.ios       | 1191468822 | blibee://                       |
| 亿通行        | com.ruubypay.yitongxing           | 1247890676 | yitongxing://                   |
| 云闪付        | com.unionpay.chsp                 | 600273928  | upwallet://                     |
| 大都会Metro   | com.DDH.SHSubway                  | 1202750238 | metro://                        |
| 爱奇艺视频    | com.qiyi.iphone                   | 1461999674 | iqiyi://                        |
| 搜狐视频      | com.sohu.iPhoneVideo              | 458587755  | sohuvideo://                    |
| 搜狐新闻      | com.sohu.newspaper                | 436957087  | sohunews://                     |
| 搜狗浏览器    | com.sogou.SogouExplorerMobile     | 548608066  | SogouMSE://                     |
| 虎牙          | com.yy.kiwi                       | 871095743  | yykiwi://                       |
| 比心          | com.yitan.bixin                   | 1286964732 | bixin://                        |
| 转转          | com.wuba.zhuanzhuan               | 1002355194 | zhuanzhuan://                   |
| YY            | yyvoice                           | 427941017  | yymobile://                     |
| 绿洲          | com.sina.oasis                    | 1459204896 | oasis://                        |
| 陌陌          | com.wemomo.momoappdemo1           | 448165862  | momochat://                     |
| 什么值得买    | com.smzdm.client.ios              | 518213356  | smzdm://                        |
| 美团秀秀      | com.meitu.mtxx                    | 416048305  | mtxx://                         |
| 唯品会        | com.vipshop.iphone                | 417200582  | vipshop://                      |
| 唱吧          | com.changba.ktv                   | 509885060  | changba://                      |
| 全民k歌       | com.tencent.QQKSong               | 910513149  | qmkege://                       |
| 酷狗音乐      | com.kugou.kugou1002               | 472208016  | kugouURL://                     |
| CSDN          | net.csdn.CsdnPlus                 | 1437086352 | csdnplus://                     |
| 多抓鱼        | com.duozhuayu.dejavu              | 1442757335 | duozhuayu://                    |
| 自如          | com.ziroom.ZiroomProject          | 685872176  | ziroom://                       |
| 携程          | ctrip.com                         | 379395415  | ctrip://                        |
| 去哪儿旅行    | com.qunar.iphoneclient8           | 395096736  | qunarphone://                   |
| Xmind         | net.xmind.brownieapp              | 1286983622 | xmind-zen://                    |
| 印象笔记      | com.yinxiang.iPhone               | 1356054761 | evernote://                     |
| 欧陆词典      | eusoft.eudic.pro                  | 393670998  | eudic://                        |
| 115           | com.115.personal                  | 1446829613 | oof.disk://                     |
| 名片全能王    | com.intsig.camcard.lite           | 349447615  | camcard://                      |
| 中国银行      | com.boc.BOCMBCI                   | 399608199  | bocmbciphone://                 |
| Google Chrome | com.google.chrome.ios             | 535886823  | googlechrome://                 |
| Gmail         | com.google.Gmail                  | 422689480  | googlegmail://                  |
| Facebook      | com.facebook.Facebook             | 284882215  | fb://                           |
| Firefox       | org.mozilla.ios.Firefox           | 989804926  | firefox://                      |
| Messenger     | com.facebook.Messenger            | 454638411  | fb-messenger://                 |
| Instagram     | com.burbn.instagram               | 389801252  | instagram://                    |
| Starbucks     | com.starbucks.mystarbucks         | 331177714  | sbuxcn://                       |
| Luckin Coffee | com.bjlc.luckycoffee              | 1296749505 | luckycoffee://                  |
| Line          | jp.naver.line                     | 443904275  | line://                         |
| Linkedin      | com.linkedin.LinkedIn             | 288429040  | linkedin://                     |
| Dcard         | com.dcard.app.Dcard               | 951353454  | dcard://                        |
| Youtube       | com.google.ios.youtube            | 544007664  | youtube://                      |
| Spotify       | com.spotify.client                | 324684580  | spotify://                      |
| Netflix       | com.netflix.Netflix               | 363590051  | nflx://                         |
| Twitter       | com.atebits.Tweetie2              | 333903271  | twitter://                      |
| WhatsApp      | net.whatsapp.WhatsApp             | 310633997  | whatsapp://                     |
| Safari        | com.apple.mobilesafari            | 1146562112 | x-web-search://                 |
