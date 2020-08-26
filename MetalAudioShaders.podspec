#
# Be sure to run `pod lib lint MetalAudioShaders.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MetalAudioShaders'
  s.version          = '0.1.0'
  s.summary          = 'MPS like kernels for audio processing.'

  s.description      = 'MPS like kernels for audio processing. Spectrogram vector -> matrix. Conv1D  matrix -> matrix'

  s.homepage         = 'https://github.com/techpro-studio/MetalAudioShaders'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Oleksii Moiseenko' => 'alex@techpro.studio' }
  s.source           = { :git => 'https://github.com/techpro-studio/MetalAudioShaders.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/techprostudio'

  s.ios.deployment_target = '11.0'
	
  s.source_files = 'MetalAudioShaders/**/*'
  s.exclude_files = "MetalAudioShaders/*.plist"
 
  s.frameworks = 'Metal', 'MetalPerformanceShaders'
end
