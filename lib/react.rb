if RUBY_ENGINE == 'opal'
  require 'react/top_level'
  require 'react/component'
  require 'react/element'
  require 'react/event'
  require 'react/version'
  require 'react/api'
  require 'react/validator'
else
  require 'tilt'
  require 'opal'
  require 'react/version'
  require 'react/ext/jsx_support'

  Opal.append_path File.expand_path('../', __FILE__).untaint
end
