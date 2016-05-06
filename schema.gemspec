# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'schema'
  s.summary = "Primitives for schema and structure"
  s.version = '0.2.0.0'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/schema'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'attribute'
  s.add_runtime_dependency 'set_attributes'
  s.add_runtime_dependency 'virtual'

  s.add_development_dependency 'test_bench'
end
