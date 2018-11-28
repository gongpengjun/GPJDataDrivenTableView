Pod::Spec.new do |s|
  s.name         = "GPJDataDrivenTable"
  s.version      = "0.1"
  s.summary      = "A data-driven way to use UITableView."
  s.description  = "The data-drive way is simple, steady, extendable, It is friendly to evolve with change of requirements."
  s.homepage     = "https://github.com/gongpengjun/GPJDataDrivenTable"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "gongpengjun" => "frank.gongpengjun@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/gongpengjun/GPJDataDrivenTable.git", :tag => "0.1" }
  s.source_files = 'GPJDataDrivenTable/**/*.{h,m}'
  s.framework    = "UIKit"
  s.requires_arc = true
  s.dependency 'Masonry'
end
