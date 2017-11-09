# frozen_string_literal: true

require "./lib/botkit/version"

Gem::Specification.new do |spec|
  spec.name          = "botkit"
  spec.version       = Botkit::VERSION
  spec.authors       = ["Nando Vieira"]
  spec.email         = ["fnando.vieira@gmail.com"]

  spec.summary       = "A simple chatbot framework"
  spec.description   = spec.summary
  spec.homepage      = "https://rubygems.org/gems/botkit"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake"
end
