inhibit_all_warnings!
source 'git@github.com:bbc/map-ios-podspecs.git'

target 'MiniSoundsChallenge' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MiniSoundsChallenge
  pod 'smp-ios'

  target 'MiniSoundsChallengeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MiniSoundsChallengeUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
