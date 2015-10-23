Bundler.require
Bundler::GemHelper.install_tasks

require 'opal/rspec/rake_task'
require 'react/source'

Opal::RSpec::RakeTask.new(:default) do |server, task|
  # Need a Phantom polyfill
  server.append_path RailsAssetsEs5Shim.load_paths[0]
  server.append_path File.dirname(React::Source.bundled_path_for('react-with-addons.js'))
  task.pattern = 'spec/opal/**/*_spec.rb'
end
