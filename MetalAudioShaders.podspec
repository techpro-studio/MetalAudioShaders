Pod::Spec.new do |s|
  s.name             = 'MetalAudioShaders'
  s.version          = '0.1.2'
  s.summary          = 'MAS'
  s.description      = "MPS like shaders for audio processing. Spectrogram. Conv1d"

  s.homepage         = 'https://github.com/techpro-studio/MetalAudioShaders'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Oleksii Moiseenko' => 'oleksiimoiseenko@gmail.com' }
  s.source           = { :git => 'https://github.com/techpro-studio/MetalAudioShaders.git', :tag => s.version }
  s.requires_arc = true

  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.13'

  s.source_files = 'MetalAudioShaders/**/*.{h,m,metal}'
  s.exclude_files = "MetalAudioShaders/*.plist"

  s.ios.pod_target_xcconfig = { 'METAL_LIBRARY_OUTPUT_DIR' => '${TARGET_BUILD_DIR}/MetalAudioShaders.bundle/' }
  s.osx.pod_target_xcconfig = { 'METAL_LIBRARY_OUTPUT_DIR' => '${TARGET_BUILD_DIR}/MetalAudioShaders.bundle/Contents/Resources/' }
  s.resource_bundle = { 'MetalAudioShaders' => ['MetalAudioShaders/CocoaPodsBundledResourcePlaceholder'] }

  s.weak_frameworks = 'MetalPerformanceShaders', 'Metal'
   
end
