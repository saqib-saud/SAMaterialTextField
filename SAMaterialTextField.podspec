Pod::Spec.new do |spec|
  spec.name         = "SAMaterialTextField"
  spec.version      = "0.0.2"
  spec.summary      = "Simple Material design TextField"

  spec.description  = <<-DESC
Simple floating material design based UITextField
                   DESC

  spec.homepage     = "https://github.com/wisesabre/SAMaterialTextField.git"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  spec.license      = "Apache 2.0"
  spec.author             = { "Saqib Saud" => "saqibsaud@gmail.com" }
  spec.social_media_url   = "https://twitter.com/wisesabre"
  spec.platform     = :ios
  spec.source       = { :git => "https://github.com/wisesabre/SAMaterialTextField.git", :tag => "v#{spec.version}" }
  spec.ios.deployment_target = "12.0"
  spec.source_files  = "SAMaterialTextField/Source/*.swift"
  spec.swift_versions = ['4.2', '5.0']
  spec.dependency "Validator"
  spec.dependency "FontAwesome.swift"

end
