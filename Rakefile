$:.unshift("/Library/RubyMotion/lib")
$:.unshift("~/.rubymotion/rubymotion-templates")

require 'motion/project/template/osx'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'fusemotion'
  app.deployment_target = '10.13'
  app.info_plist['CFBundleIconName'] = 'AppIcon'
  app.info_plist['LSUIElement'] = true
  app.embedded_frameworks << '/Library/Frameworks/OSXFUSE.framework'
end
