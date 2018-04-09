Pod::Spec.new do |s|
  s.name         = "BRSerialization"
  s.version      = "1.0"
  s.summary      = "iOS library"
  s.author       = { "Elie Melki" => "elie.j.melki@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/ElieMelki/BRSerialization.git" , :tag => s.version }
  s.source_files =  'BRSerialization/BRSerialization/**/*.{h,m}'
  s.ios.deployment_target = '5.0'
  s.frameworks = 'Foundation'
  s.requires_arc = true
  s.dependency 'OrderedDictionary', '~> 1.4'
  s.xcconfig  =  { 'OTHER_LDFLAGS' => '-ObjC' }
  s.license      = {
    :type => 'Copyright',
    :text => <<-LICENSE
      Copyright 2014-2015 Elie Melki. All rights reserved.
      LICENSE
  }
end
