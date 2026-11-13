# RRJClosedSDK

人人讲（wangju）闭源 SDK 的私有 CocoaPods 仓库。

> 当前最新版本：**1.0.3**（用法见下方「使用方式」）。

包含以下已「中和平台标记」的静态 framework（**arm64 单架构**，可在真机与
Apple Silicon 模拟器上链接；**Intel Mac（x86_64）模拟器不支持**）：

- GPUImage（自定义 fork，比上游多 11 个自研滤镜）
- ImSDK / QALSDK / TLSSDK / TLSUI / IMFriendshipExt / IMGroupExt / IMMessageExt
  （腾讯 IM 旧版 SDK，基于 TIMManager / IM*Ext，不能替换为 ImSDK_Plus）

> 注意：SuperPlayer 不在此仓库。它已由主工程 Podfile 中的官方
> `SuperPlayer/Professional 13.3.20845.1` pod 管理，避免同名符号冲突。

## 环境要求

- iOS 15.0+
- Apple Silicon Mac（M 系列）可正常跑模拟器；Intel Mac 无法链接（仅 arm64 切片）

## 使用方式

主工程 `Podfile` 中：

```ruby
pod 'RRJClosedSDK', :git => 'https://github.com/SCFighting/RRJClosedSDK.git', :tag => '1.0.3'
```

然后执行 `pod install` 即可。

> 若使用 SSH 方式拉取，把 `:git` 换成 `git@github.com:SCFighting/RRJClosedSDK.git`。

## 维护

- 二进制来自主工程 `Vendor/` 的中和产物（`.orig` 为中和前备份，已丢弃）。
- 升级某个 SDK 时，替换对应 `Frameworks/*.framework`，提交并在远端打新的 tag，
  主工程 Podfile 改 `:tag` 即可。
- 本仓库只存放这些闭源二进制，不依赖主工程的 `Vendor/Scripts/`。
- 架构变更：
  - 自 `1.0.1` 起各 framework 仅保留 arm64 切片（已移除 i386 / armv7 / armv7s /
    x86_64），兼容真机与 Apple Silicon 模拟器（二者均为 arm64）。
  - 自 `1.0.3` 起进一步对 8 个 framework 做等长「中和」：将每个 `.o` 的
    `LC_BUILD_VERSION` 平台标记抹为中性，链接器按目标推定平台，真机与 arm64 模拟器
    可直接链接，无需 `duo_bootstrap` 在两种态之间切换。
