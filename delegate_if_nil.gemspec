$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "delegate_if_nil/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "delegate_if_nil"
  s.version     = DelegateIfNil::VERSION
  s.authors     = ["Steven Allen"]
  s.email       = ["sallen@amberstyle.ca"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of DelegateIfNil."
  s.description = "TODO: Description of DelegateIfNil."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.2."

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "guard"
end
