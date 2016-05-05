require_relative 'test_init'

TestBench::Runner.(
  'bench/**/*.rb',
  exclude_pattern: %r{/skip\.|(?:_init\.rb|\.sketch\.rb|_sketch\.rb|\.skip\.rb)\z}
) or exit 1
