# frozen_string_literal: true

require_relative 'lib/joke_api/version'

Gem::Specification.new do |spec|
  spec.name = 'joke_api'
  spec.version = JokeApi::VERSION
  spec.authors = ['1s22s1']
  spec.email = ['1s22s1@users.noreply.github.com']

  spec.summary = 'API Client for Joke Official Joke API.'
  spec.description = 'API Client for Joke Official Joke API.'
  spec.homepage = 'https://github.com/1s22s1/joke_api/README.md'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/1s22s1/joke_api'
  spec.metadata['changelog_uri'] = 'https://github.com/1s22s1/joke_api/CHANGELOG.md'

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'
end
