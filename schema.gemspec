# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'schema'
  s.summary = "Primitives for schema and structure"
  s.version = '0.0.1.3'
  s.description = ' '

  s.authors = ['Obsidian Software, Inc']
  s.email = 'opensource@obsidianexchange.com'
  s.homepage = 'https://github.com/obsidian-btc/schema'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'set_attributes'
  s.add_runtime_dependency 'virtual'

  s.add_runtime_dependency 'virtus', '~> 1.0'

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-spec-context'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'runner'
end
