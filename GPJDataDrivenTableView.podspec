Pod::Spec.new do |s|
  s.name         = "GPJDataDrivenTableView"
  s.version      = "1.0.0"
  s.summary      = "A data-driven way to use UITableView."
  s.description  = "The data-drive way is simple, steady, extendable, It is friendly to evolve with change of requirements."
  s.homepage     = "https://github.com/gongpengjun/GPJDataDrivenTableView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "gongpengjun" => "frank.gongpengjun@gmail.com" }
  s.social_media_url = "https://twitter.com/frank_gong"
  s.platform     = :ios, '5.0' #minimum platform with ARC
  s.source       = { :git => "https://github.com/gongpengjun/GPJDataDrivenTableView.git", :tag => "v#{s.version}" }
  s.source_files = 'GPJDataDrivenTableView/**/*.{h,m}'
  s.framework    = "UIKit"
  s.requires_arc = true
end
