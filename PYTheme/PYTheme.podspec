Pod::Spec.new do |s|
  # pod_name       = 'PYTheme'
  name           = 'PYTheme'
  url            = 'https://github.com/BobliiExp/PYTheme'
  git_url        = 'https://github.com/BobliiExp/PYTheme.git'
  version        = '1.0.2'
  source_files   = 'Classes/**/*.{swift}', 'Classes/*.{swift}'

  s.name         = name
  s.version      = version
  s.summary      = 'PYTheme for iOS'
  s.description  = <<-DESC
                  The PYTheme framework is designed to work seamlessly with your existing apps and projects.
                  you can simply add the pod your project.
                    
                    DESC

  s.homepage     = url
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Bob Lee" => "boblii@hotmail.com" }
  s.source       = { :git => 'git@github.com:BobliiExp/PYTheme.git', :tag => s.version.to_s}
  

  s.ios.deployment_target = '11.0'
  s.requires_arc = true
  s.swift_version = '5.0'
  s.frameworks = 'Foundation'

s.subspec 'PYTheme' do |ps|
    ps.source_files = 'AssetsMapping/**/*.{swift}'
end

end
