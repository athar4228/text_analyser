
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "text_analyser/version"

Gem::Specification.new do |spec|
  spec.name          = "text_analyser"
  spec.version       = TextAnalyser::VERSION
  spec.authors       = ["AtharNoor"]
  spec.email         = ["atharnoor2@gmail.com"]

  spec.summary       = %q{TextAnalyser is a redis based stats generator for sentences}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.description = <<description
  Text Analyser is redis based command line library,
  allowing multiple users to enters sentences and
  checking stats for all users using same configured redis.
  It is comprised of three parts:

    * A Ruby library for analysing sentences
    * A Ruby library for generating stats
    * A TCP server to shows stats.
description
end
