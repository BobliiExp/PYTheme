Pod::Spec.new do |s|
  pod_name       = "PYTheme"
  name           = "#{pod_name}"
  url            = "https://github.com/BobliiExp/#{name}"
  git_url        = "#{url}.git"
  version        = "1.0"
  source_files   = "#{pod_name}/**/*.{h,m}"

  s.name         = name
  s.version      = version
  s.summary      = "PYPageScrollView for iOS"
  s.description  = <<-DESC
                  The PYTheme framework is designed to work seamlessly with your existing apps and projects.
                  you can simply add the pod your project.
                    
                    DESC

  s.homepage     = url
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Bob Lee" => "boblii@hotmail.com" }
  s.source       = { :git => git_url, :tag => s.version.to_s}
  

  s.ios.deployment_target = '11.0'
  s.requires_arc = true
  s.frameworks = 'Foundation'

s.subspec 'PYTheme' do |ps|
    ps.source_files = 'Classes/*.{swift}'

end

end
