source 'https://rubygems.org'

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in brew_outdated_formatter.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create('2.1.0')
  gem 'rubocop', '< 0.51.0'
end
