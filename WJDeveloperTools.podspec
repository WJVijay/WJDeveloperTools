Pod::Spec.new do |s|
s.name         = 'WJDeveloperTools'
s.version      = '2.0.7'
s.summary      = '开发常用的一些小东东'
s.homepage     = 'https://github.com/WJVijay/WJDeveloperTools'
s.license      = 'MIT'
s.authors      = {'WJ Vijay' => 'wangjunnige@163.com'}
s.platform     = :ios, '9.0'
s.source       = {:git => 'https://github.com/WJVijay/WJDeveloperTools.git', :tag => s.version}
s.source_files = 'WJDeveloperTools/**/*.{h,m}'
s.requires_arc = true
s.dependency 'SVProgressHUD', '~> 2.2.5'
end
