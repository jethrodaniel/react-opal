Bundler.require
Bundler::GemHelper.install_tasks

require 'opal/rspec/rake_task'
require 'react/source'

Opal::RSpec::RakeTask.new(:default) do |s|
  s.append_path File.dirname(::React::Source.bundled_path_for('react-with-addons'))
end
