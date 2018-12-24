Pod::Spec.new do |s|
    s.name                = 'YXReusableView'
    s.summary             = 'YXReusableView'
    s.version             = '1.0.2'
    s.homepage            = 'https://github.com/xinghanjie/YXReusableView'
    s.license             = { :type => 'MIT', :file => 'LICENSE' }
  
  
    s.author               = { 'Heikki' => 'xinghanjie@gmail.com' }
    s.platform             = :ios, '7.0'
    s.source               = { :git => 'https://github.com/xinghanjie/YXReusableView.git', :tag => s.version }
    s.source_files         = 'YXReusableView/*.{h,m}'
    s.requires_arc         = true
    s.public_header_files  = 'YXReusableView/*.{h}'
  
  end