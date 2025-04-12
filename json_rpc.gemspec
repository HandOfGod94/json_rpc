# frozen_string_literal: true

require_relative 'lib/json_rpc/version'

Gem::Specification.new do |spec|
  spec.name          = 'json_rpc'
  spec.version       = JsonRpc::Version::VERSION
  spec.authors       = ['Gahan Rakholia']
  spec.email         = ['gahan.rakholia@gmail.com']

  spec.summary       = 'A lightweight, transport-agnostic JSON-RPC 1.0 implementation in Ruby'
  spec.description   = 'A simple and clean implementation of JSON-RPC 1.0 specification that works with any transport layer (HTTP, WebSocket, etc.)'
  spec.homepage      = 'https://github.com/gahanrakholia/json_rpc'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Development dependencies
  spec.add_development_dependency 'minitest', '~> 5.25', '>= 5.25.5'
  spec.add_development_dependency 'rake', '~> 13.2', '>= 13.2.1'
end 