# -*- encoding: utf-8 -*-
# stub: tin 1.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "tin".freeze
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Brian A. Guthrie".freeze]
  s.date = "2012-05-22"
  s.description = "An incredibly simple interface to libnotify using Fiddle.".freeze
  s.email = "baguthrie@siu.edu".freeze
  s.homepage = "https://gitorious.org/ruby-tin".freeze
  s.rubyforge_project = "tin".freeze
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Very simple libnotify access".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 0.8.3"])
    else
      s.add_dependency(%q<rspec>.freeze, ["~> 2.0"])
      s.add_dependency(%q<rake>.freeze, ["~> 0.8.3"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 0.8.3"])
  end
end
