# stm8s_esp8266
esp8266 work with stm8s103f3p6

1， windows平台, 
2， stvd工程, 
3， COSMIC 编译器,

硬件：
1，esp8266是用的安信可的模块，接口是串口,
2，stm8s103f3p6串口连接esp8266, PA1 连接led,

目前实现的功能：
1，将esp8266 设为AP mode，ssid为 "免费WIFI", 不加密,
2，将esp8266 设为server, 端口 8080, 可连接5个 client,
3, 有客户端连接上后，周期发送心跳包，数据为"heartbeat", 用于监测client是否断开,
4, 如果收到客户端的数据中包含"led_on" 则点亮led，如果数据中包含"led_off" 则关闭led,

