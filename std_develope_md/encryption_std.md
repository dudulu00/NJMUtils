# 加密通信规则

## 说明

　app与服务器间通信的加密规则

## 


* **加密范围**
       重要的请求https加密通信: 登录，支付，银行卡数据

* **加密算法**
  
  MD5,AES,RSA


*  **请求参数**

**键值** | **类型** | **是否必需** | **备注**
---------|----------|--------------|---------
mobile   |int |是 | 电话号码



* **请求内容示例:**

        {
            "":""
        }


*  **备注**



* **对称加解密**

url签名有两个缺点，这两个缺点，如果使用对称加密方法的话，则完全可以避免这两个缺点。在本文中，会介绍对称加密的具体原理，和详细的方案，使app通讯更加安全。


    1.对称加密的原理


　　采用单钥密码系统的加密方法，同一个密钥可以同时用作信息的加密和解密，这种加密方法称为对称加密，也称为单密钥加密。


　　其实很简单，假设有原始数据"1000", 把1000加５就得到密文"1005",得到密文"1005"后减５就得到原始数据"1000"。把原始数据加５就是加密算法，把密文减５就是解密算法，密钥就是5。


　　本文所用的是AES这种通用的对称加密算法。


    2. api请求中AES算法的应用


　　(1)curl简介


　　在下面的例子中，会使用curl工具，先简单介绍一下。


　　curl是利用URL语法在命令行方式下工作的开源文件传输工具。


　　用到的参数：


　　-X: 指定什么命令，例如post,get等。

　　-H: 指定http header。

　　-d: 制定http body的内容


　　(2)怎么保证token在初次返回时的安全


　　用下面的api返回加密的token


[plain] 
curl -X POST \  
-H "Token-Param:<时间戳>,<sdkversion>"\  
-d  ‘Base64Encode(AES(token, secretKey))’  
https://test.com/api/login  

注意：Token-Param是自己定义的http header，这里是因为个人习惯才命名为Token-Param


　　secretKey就是密钥，使用http header中的Token-Param中的16位长度。


　　服务端返回时加密token的方法是用AES加密，密钥是secretKey。


　　客户端解密token的方法是用AES解密，密钥是secretKey。


　　(3) api请求中的加密


　　假设更新用户数据的api调用如下

[plain] 
curl -X POST \  
-H "Token-Param:<时间戳>,<sdkversion>"\  
-H  ‘Token:Base64Encode(AES(token, secretKey))’  
-d  ‘Base64Encode(AES(date, token))’  
https://test.com/api/user/update  

　　secretKey使用http header中的Token-Param中的16位长度。


　　在上面的例子中,data是实际要post的数据。

　　在这个过程中,token和post的数据都得到了加密保护。


　　客户端发送时加密的过程

　　(1) 取http header中的Token-Param中的16位长度作为密钥，用AES加密token。

　　(2) 用token作为密钥，用AES加密data。


　　服务端接收到这个api请求的解密过程：


　　(1)取http header中的Token-Param中的16位长度作为密钥，用AES解密, 得到token。

　　(2)用token作为密钥，用AES解密http body的内容，得到原文。

3.对称加密方法的总结

　　  把token返回的时候，可以做个约定，在返回的时候截取某个字符串的一部分作为密钥，这个秘钥只用一次，就是用来解密token的，以后就只是用token来做秘钥了。


        整个过程如下：

    1、用户名密码 + https + url签名（url+时间戳+随机字串）链接+请求时间+保唯一的字串
    2、服务器返回token：aes(约定算法)=》（token+随机secret(就取上面那个签名中的16位)）
    3、app保存token后，以后每次机通信都通过  aes (token + 内容)  传输

