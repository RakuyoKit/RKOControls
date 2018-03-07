#
#  Be sure to run `pod spec lint RKOTopAlert.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "RKOTopAlert"
  s.version      = "1.1.0"
  s.summary      = "Appears at the top of the notification view"
  s.description  = <<-DESC
            Appears at the top of the notification view
                   DESC

  s.homepage     = "https://github.com/rakuyoMo/RKOControls/tree/master/RKOTopAlertManager"

  s.license      = "MIT"

  s.author             = { "Rakuyo" => "rakuyo.mo@gmail.com" }

  s.ios.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/rakuyoMo/RKOControls.git", :tag => "1.3.11" } # #{s.version}

  s.requires_arc = true

  s.source_files = "RKOTopAlertManager/RKOTopAlert/RKOTopAlert/RKOTopAlert/*.{h,m}"

  s.resources    = "RKOTopAlertManager/RKOTopAlert/RKOTopAlert/RKOTopAlert/*.{png,xib,nib,bundle}"

  s.dependency "Masonry"

end