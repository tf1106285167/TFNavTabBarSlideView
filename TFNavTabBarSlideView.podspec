#
#  Be sure to run `pod spec lint TFNavTabBarSlideView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#
#  s.name是我们库的名称，
#  s.version是库原代码版本号，
#  s.summary是对我们库的一个简单的介绍，
#  s.homepage声明库的主页，
#  s.license是所采用的授权版本，
#  s.author是库的作者。
#  s.platform是我们库所支持的软件平台，这在我们最后提交进行编译 时有用。
#  s.source声明原代码的地址。我这里是托管在github上,所以这里将地址copy过来就行了


Pod::Spec.new do |s|
s.name         = 'TFNavTabBarSlideView'
s.version      = '1.0.1'
s.summary      = '分页切换视图控件'
s.homepage     = 'https://github.com/tf1106285167/TFNavTabBarSlideView'
s.license      = 'MIT'
s.authors      = {'TuFa' => '1106285167@qq.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/tf1106285167/TFNavTabBarSlideView.git', :tag => s.version}
s.source_files  = 'TFSlideView/*.{h,m}'
s.requires_arc = true
end

