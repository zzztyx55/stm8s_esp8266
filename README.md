# stm8s_esp8266
 esp8266 work with stm8s103f3p6
## 环境：
+ windows平台, 
+ stvd工程
+ COSMIC 编译器,

## 硬件：
+ esp8266是用的安信可的模块，接口是串口
+ stm8s103f3p6串口连接esp8266, PA1 连接led,

## 目前实现的功能：
+ 将esp8266 设为AP mode，ssid为 "免费WIFI", 不加密
+ 将esp8266 设为server, 端口 8080, 可连接5个 client
+  有客户端连接上后，周期发送心跳包，数据为"heartbeat", 用于监测client是否断开
+  如果收到客户端的数据中包含"led_on" 则点亮led，如果数据中包含"led_off" 则关闭led,

##测试应用：
+ android应用：apk/wifi_test.apk
+ android应用源码: apk/wifi_test/



