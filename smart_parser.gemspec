# frozen_string_literal: true

require_relative 'lib/smart_parser/version'

Gem::Specification.new do |spec|
  spec.name          = 'smart_parser'
  spec.version       = SmartParser::VERSION
  spec.authors       = ['Joffily Ferreira']
  spec.email         = ['joffilyferreira@gmail.com']

  spec.summary       = 'Inspect yours webserver logs'
  spec.description   = 'This powerfull webserver log parser will help you count access through your routes'
  spec.homepage      = 'https://github.com/joffilyfe/smart_parser'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.2')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
