# Room Night Tokenization 间夜数字化
间夜数字化是借助以太坊ERC721协议实现的酒店间夜上链并数字化为可交易的Token的系统。商家可以借助该系统完成酒店RP(RatePlan)的上链并在链上完成库存和价格的管理，用户可以购买商家的间夜产生数字化的间夜Token，该Token在交易完成后产生并流转入用户账户。生成的Token可以在用户之间任意流转。持有间夜Token的用户可以在对应的酒店处完成Token的消费（入住），也可以与酒店协商之后销毁Token并退回购买资金。

# Ropsten Release

* TRIO: [0xF142f1c7BaDc95FB438302D7Cf0a5Db426f8f779](https://ropsten.etherscan.io/address/0xf142f1c7badc95fb438302d7cf0a5db426f8f779)
* LinkedListLib:  [0x20733AB0E0E100D3047Bd9C983f520d3Ee7dD2BF](https://ropsten.etherscan.io/address/0x20733ab0e0e100d3047bd9c983f520d3ee7dd2bf)
* TripioRoomNightData:[0x829bCf8c990bD4c0de2A32A3A21068E0D154705D](https://ropsten.etherscan.io/address/0x829bCf8c990bD4c0de2A32A3A21068E0D154705D)
* TripioRoomNightAdmin: [0x4062a6E1281eB26C56E21E3e73CB55a325397b29](https://ropsten.etherscan.io/address/0x4062a6E1281eB26C56E21E3e73CB55a325397b29)
* TripioRoomNightCustomer: [0xcBf788b40d94CBa28052e870298334dCA837143a](https://ropsten.etherscan.io/address/0xcBf788b40d94CBa28052e870298334dCA837143a)
* TripioRoomNightVendor: [0x6A9C0fDAa9361b44eeE09ad0d0304ec941173361](https://ropsten.etherscan.io/address/0x6A9C0fDAa9361b44eeE09ad0d0304ec941173361)

# Main Release

* TRIO:[0x8B40761142B9aa6dc8964e61D0585995425C3D94](https://etherscan.io/address/0x8B40761142B9aa6dc8964e61D0585995425C3D94)
* LinkedListLib:[0x4080aFDc3e484Da33Ee4E98429ED973A252a6d80](https://etherscan.io/address/0x4080aFDc3e484Da33Ee4E98429ED973A252a6d80)
* TripioRoomNightData:[0x52ef5080612920a0365BE1d382765089b596c708](https://etherscan.io/address/0x52ef5080612920a0365BE1d382765089b596c708)
* TripioRoomNightAdmin:[0x09FD12C95F8b4738609cF38D58DDaD0Abb792cd3](https://etherscan.io/address/0x09FD12C95F8b4738609cF38D58DDaD0Abb792cd3)
* TripioRoomNightCustomer:[0xd8114e9c66035b9CeE9BB7374f39AD6751811761](https://etherscan.io/address/0xd8114e9c66035b9CeE9BB7374f39AD6751811761)
* TripioRoomNightVendor:[0xe79c61B12279D65413Ff6C670D5d7aaC689158f6](https://etherscan.io/address/0xe79c61B12279D65413Ff6C670D5d7aaC689158f6)

# 间夜Token化流程概览
![间夜Token化流程概览](https://github.com/thetripio/roomnight/blob/master/design/%E9%97%B4%E5%A4%9CToken%E5%8C%96%E6%B5%81%E7%A8%8B.png)

# 间夜Token化合约结构
![间夜Token化合约结构](https://github.com/thetripio/roomnight/blob/master/design/%E9%97%B4%E5%A4%9CToken%E5%8C%96%E5%90%88%E7%BA%A6%E7%BB%93%E6%9E%84.png)

# 间夜签名&验证流程
间夜在使用的时候可以通过两种方式完成：
* 1、可以把间夜Token直接转给商户，但是这会消耗一定数量的Gas费用；
* 2、由于间夜本身具备自然失效的特性，因此我们可以通过简单的验证的方式来完成间夜的使用，只要验证间夜持有人拥有该间夜的对应地址的私钥就可以，流程参加下图
![间夜签名&验证流程](https://github.com/thetripio/roomnight/blob/master/design/%E9%97%B4%E5%A4%9CToken%E7%AD%BE%E5%90%8D%26%E9%AA%8C%E7%AD%BE.png)

# 联系方式
* Website：http://trip.io/
* Telegram：https://t.me/thetripio
* Twitter：https://twitter.com/thetripio
* Whitepaper：http://trip.io/wp/Tripio_Whitepaper_CN.pdf
* Wechat：扫码添加微信小助手，进入Tripio官方微信群，消息早知道
* Kakao:  https://open.kakao.com/o/gLHXN9Y
* Facebook: https://www.facebook.com/profile.php?id=100028583748545
