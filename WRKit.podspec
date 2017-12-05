Pod::Spec.new do |s|
    s.name         = "WRKit"
    s.version      = "1.3.2"
    s.summary      = "kit & funcation的便利构造方法."
    s.description  = "kit & funcation的便利构造方法，常用视图的便利构造，常用的判断方法."
    s.homepage     = "https://github.com/GodFighter/WRKit-Foundation.git"
    s.license      = "MIT"
    s.author       = { "Leo Xiang" => "xianghui_ios@163.com" }
    s.source       = { :git => "https://github.com/GodFighter/WRKit-Foundation.git", :tag => s.version }
    s.ios.deployment_target = '8.0'
    s.frameworks   = 'UIKit'
    s.social_media_url = "http://weibo.com/huigedang/home?wvr=5&lf=reg"
    s.requires_arc = true
    s.subspec 'WRFoundation' do |ss|
        ss.source_files = 'WRKit-Foundation/WRFoundation/*.{h,m}'
    end
    s.subspec 'WRKit' do |ss|
        ss.source_files = 'WRKit-Foundation/WRKit/*.{h,m}'
        ss.dependency 'WRKit/WRFoundation'
        ss.subspec 'CoreText' do |coreText|
            coreText.source_files = 'WRKit-Foundation/WRKit/CoreText/*.{h,m}'
       end
    end
end

