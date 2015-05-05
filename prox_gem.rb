def prox_gem(gem_name, options={})
  opts = _options(gem_name, options)
  gem gem_name, opts
end

def _options(gem_name, options={})
  mode = _prox_gem_mode
  if mode == "path"
    return { :path => _file_system_path(gem_name) }
  elsif mode == "git"
    return { :git => _git_path(gem_name, options) }.merge(options)
  elsif mode == 'off'
    return options
  else
    _print_mode_error && raise
  end
end

def _prox_gem_mode
  mode = ENV['PROX_GEM_MODE']
  return mode if _set? mode
  "off"
end

def _print_prox_gem_mode
  puts "PROX_GEM_MODE: #{_prox_gem_mode}"
end

def _prox_gem_dir
  gem_dir = ENV['PROX_GEM_DIR']

  return gem_dir if _set? gem_dir

  _print_gem_dir_error
  raise
end

def _print_prox_gem_dir
  puts "PROX_GEM_DIR: #{ENV['PROX_GEM_DIR']}"
end

def _prox_gem_git_uri
  git_uri = ENV['PROX_GEM_GIT_URI']

  return git_uri if _set? git_uri

  _print_git_repo_uri_error
  raise
end

def _print_prox_gem_git_uri
  puts "PROX_GEM_GIT_URI: #{ENV['PROX_GEM_GIT_URI']}"
end

def _set?(val)
  !val.nil? && !val.strip.empty?
end

def _file_system_path(gem_name)
  gem_name = _canonical_gem_name(gem_name)
  File.join(_prox_gem_dir, gem_name)
end

def _git_path(gem_name, options)
  prefix = options.delete :prefix

  repo_name = _canonical_gem_name(gem_name)

  path = "#{_prox_gem_git_uri}/"
  path << "#{prefix}/" if prefix
  path << "#{repo_name}.git"
end

def _canonical_gem_name(gem_name)
  gem_name.gsub '_', '-'
end

def _print_mode_error(mode)
  puts "The PROX_GEM_MODE \"#{mode}\" environment variable is wrong. It must be one of \"path\", \"git\", or \"off\"."
end

def _print_gem_dir_error
  puts 'The PROX_GEM_DIR environment variable must be set to the path that contains gem project directories'
end

def _print_git_repo_uri_error
  puts 'The PROX_GEM_GIT_URI environment variable must be set to the URI of the Git repository where the gem project is housed'
end

_print_prox_gem_mode
_print_prox_gem_dir
_print_prox_gem_git_uri
