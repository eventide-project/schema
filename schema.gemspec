# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'schema'
  s.summary = "Primitives for schema and structure"
  s.version = '0.1.1'
  s.authors = ['']
  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.2'

  s.add_runtime_dependency 'set_attributes'
  s.add_runtime_dependency 'virtual'

  s.add_runtime_dependency 'virtus', '~> 1.0'

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-spec-context'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'runner'
end
