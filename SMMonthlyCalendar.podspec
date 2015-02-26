Pod::Spec.new do |s|
  s.name         = 'SMMonthlyCalendar'
  s.version      = '0.1.0'
  s.license      = 'MIT'
  s.platform     = :ios, '7.0'

  s.summary      = 'UICollectionView based infinitely scrolling, paging monthly calendar.'
  s.homepage     = 'https://github.com/mundstein/SMMonthlyCalendar'
  s.author       = { 'Sascha Mundstein' => 'mundstein@gmail.com' }
  s.source       = { :git => 'https://github.com/mundstein/SMMonthlyCalendar.git', :tag => s.version.to_s }
  
  s.source_files = 'SMCalendar/SMCalendar/*.{h,m}'
  
  s.requires_arc = true
end
