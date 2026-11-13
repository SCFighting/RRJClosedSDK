Pod::Spec.new do |s|
  s.name         = 'RRJClosedSDK'
  s.version      = '1.0.3'
  s.summary      = '人人讲闭源 SDK：自定义 GPUImage fork + 腾讯 IM/TLS 旧版静态 framework'
  # TODO: 把下面的 URL 换成你自己的远端仓库地址（创建好远程仓库后填写）
  s.homepage     = 'https://github.com/SCFighting/RRJClosedSDK'
  s.license      = { :type => 'MIT', :text => 'Internal use only' }
  s.author       = { 'renrenjiang' => '' }
  # :git 来源 + tag。Podfile 里用 `pod 'RRJClosedSDK', :git => '...', :tag => '1.0.3'` 引用。
  # TODO: 把下面的 URL 换成你自己的远端仓库地址
  s.source       = { :git => 'https://github.com/SCFighting/RRJClosedSDK.git', :tag => s.version.to_s }
  s.platform     = :ios, '15.0'
  s.ios.deployment_target = '15.0'

  # 这些 framework 都是静态库（ar archive）。1.0.3 起已用等长「中和」改写把每个
  # .o 的 LC_BUILD_VERSION 抹成中性（无平台标记），链接器按目标推定平台，因此
  # 真机与 arm64 模拟器都能直接链接，无需 duo_bootstrap 在两种态之间反复切换。
  # 全部为 arm64-only（已剥离 i386/armv7/x86_64 死架构）。沿用原 RRJVendor 做法：
  # 不显式声明 static_framework，由 CocoaPods 在 use_frameworks! 下自动打进动态壳。
  # 直接 glob 本仓库 Frameworks/ 下所有 .framework。新增/移除库只改目录即可。
  s.vendored_frameworks = Dir['Frameworks/*.framework']

  # 老 podspec 会往应用级 xcconfig 注入 EXCLUDED_ARCHS=arm64 / VALID_ARCHS，
  # 那是 Apple Silicon 跑不起模拟器的根源。这里显式清空，模拟器构建才能正常链接。
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => '',
    'ENABLE_BITCODE' => 'NO',
  }
end
