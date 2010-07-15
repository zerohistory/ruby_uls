# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby-uls}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pat Nakajima and Steve Martocci"]
  s.date = %q{2010-07-14}
  s.files = ["LICENSE", "README.md", "lib/ruby-uls.rb", "lib/uls/.gitignore", "lib/uls/client.rb", "lib/uls/request.rb", "ruby-uls.gemspec", "spec/spec_helper.rb", "spec/uls/client_spec.rb", "spec/uls/request_spec.rb"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby wrapping for Location Labs Universal Location Service}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby-hmac>, [">= 0"])
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<ruby-hmac>, [">= 0"])
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<ruby-hmac>, [">= 0"])
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end
