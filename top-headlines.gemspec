# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'top-headlines/version'

Gem::Specification.new do |spec|
  spec.name          = "top-headlines"
  spec.version       = TopHeadlines::VERSION
  spec.authors       = ["zachnewburgh"]
  spec.email         = ["zach.newburgh@gmail.com"]

  spec.summary       = %q{This gem allows users to view the top headlines from major news sources. Users can open the headlines directly from the command line for articles from BBC, Bloomberg, CNN, The Daily Beast, FiveThirtyEight, Forbes, Fox News, The Guardian, Huffington Post, MSNBC, New York Times, Politico, Wall Street Journal, Washington Post, and Yahoo.}
  spec.homepage      = "https://github.com/zachnewburgh/top-headlines-cli-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "activesupport"

  spec.add_dependency "nokogiri"
end
