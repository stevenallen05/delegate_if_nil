# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "delegate_if_nil/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "delegate_if_nil"
  s.version     = DelegateIfNil::VERSION
  s.authors     = ["Steven Allen"]
  s.email       = ["sallen@amberstyle.ca"]
  s.homepage    = "https://github.com/stevenallen05/delegate_if_nil"
  s.summary     = "Simple delegation of nil attributes to an association"
  s.description = "Add to a model to simply delegate attributes to an associated record"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.2"
end
