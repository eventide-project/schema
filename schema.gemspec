# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-schema'
  s.summary = "Primitives for schema and data structure"
  s.version = '2.5.0.0'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/schema'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.3'

  s.add_runtime_dependency 'evt-attribute'
  s.add_runtime_dependency 'evt-set_attributes'
  s.add_runtime_dependency 'evt-initializer'
  s.add_runtime_dependency 'evt-validate'
  s.add_runtime_dependency 'evt-template_method'
  s.add_runtime_dependency 'evt-reflect'

  s.add_development_dependency 'test_bench'
end
