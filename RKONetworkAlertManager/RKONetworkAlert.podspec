#
#  Be sure to run `pod spec lint RKONetworkAlert.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "RKONetworkAlert"
  s.version      = "1.0.0"
  s.summary      = "A network prompt control"
  s.description  = <<-DESC
  					A network prompt control
                   DESC

  s.homepage     = "https://github.com/rakuyoMo/RKOControls/tree/master/RKONetworkAlertManager"

  s.license      = "MIT"

  s.author             = { "Rakuyo" => "rakuyo.mo@gmail.com" }

  s.ios.deployment_target = "7.0"

  s.source       = { :git => "git@github.com:rakuyoMo/RKOControls.git", :tag => "1.0.0" } # #{s.version}

  s.requires_arc = true

  s.source_files = "RKONetworkAlert/RKONetworkAlert/RKONetworkAlert/.{h,m}"

end
