#
#  Be sure to run `pod spec lint RKOTextView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "RKOTextView"
  s.version      = "1.0.1"
  s.summary      = "A UITextView package"
  s.description  = <<-DESC
            A UITextView package
                   DESC

  s.homepage     = "https://github.com/rakuyoMo/RKOControls/tree/master/RKOTextViewManager"

  s.license      = "MIT"

  s.author       = { "Rakuyo" => "rakuyo.mo@gmail.com" }

  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/rakuyoMo/RKOControls.git", :tag => "1.0.1" } # #{s.version}

  s.requires_arc = true

  s.source_files = "RKOTextViewManager/RKOTextView/RKOTextView/RKOTextView/*.{h,m}"
  s.resources    = "RKOTextViewManager/RKOTextView/RKOTextView/RKOTextView/*.{png,xib,nib,bundle}"

end