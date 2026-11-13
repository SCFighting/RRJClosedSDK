# RRJClosedSDK

人人讲（wangju）闭源 SDK 的私有 CocoaPods 仓库。

包含以下已「中和平台标记」的静态 framework（arm64 真机 + x86_64 模拟器混合切片，
可在 Apple Silicon 模拟器链接）：

- GPUImage（自定义 fork，比上游多 11 个自研滤镜）
- ImSDK / QALSDK / TLSSDK / TLSUI / IMFriendshipExt / IMGroupExt / IMMessageExt
  （腾讯 IM 旧版 SDK，基于 TIMManager / IM*Ext，不能替换为 ImSDK_Plus）

> 注意：SuperPlayer 不在此仓库。它已由主工程 Podfile 中的官方
> `SuperPlayer/Professional 13.3.20845.1` pod 管理，避免同名符号冲突。

## 使用方式

主工程 `Podfile` 中：

```ruby
pod 'RRJClosedSDK', :git => 'https://<你的远程仓库地址>/RRJClosedSDK.git', :tag => '1.0.0'
```

然后 `pod install`。

## 维护

- 二进制来自主工程 `Vendor/` 的中和产物（`.orig` 为中和前备份，已丢弃）。
- 升级某个 SDK 时，替换对应 `Frameworks/*.framework`，提交并在远端打新的 tag，
  主工程 Podfile 改 `:tag` 即可。
- 本仓库只存放这些闭源二进制，不依赖主工程的 `Vendor/Scripts/`。
