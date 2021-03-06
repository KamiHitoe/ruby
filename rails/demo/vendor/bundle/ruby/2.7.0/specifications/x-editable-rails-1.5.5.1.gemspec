# -*- encoding: utf-8 -*-
# stub: x-editable-rails 1.5.5.1 ruby lib vendor

Gem::Specification.new do |s|
  s.name = "x-editable-rails".freeze
  s.version = "1.5.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze, "vendor".freeze]
  s.authors = ["We're in".freeze]
  s.date = "2017-12-07"
  s.description = "X-editable for Rails".freeze
  s.email = ["info@wereinhq.com".freeze]
  s.homepage = "https://github.com/werein/x-editable-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "X-editable for Rails".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<railties>.freeze, [">= 0"])
    s.add_development_dependency(%q<rails>.freeze, ["~> 4.0"])
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
  else
    s.add_dependency(%q<railties>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, ["~> 4.0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
  end
end
