Gem::Specification.new do |s|
  s.name        = 'context_logger'
  s.version     = '0.0.47'
  s.date        = '2015-11-11'
  s.summary     = 'Writes log by context'
  s.description = 'Writes log to db and log files (configurable destinations) according the context and exposes the log entries via http'
  s.authors     = ['Alexander Libster']
  s.email       = '012alex012@gmail.com'
  s.files         = `git ls-files`.split($/)
  s.homepage    = 'https://github.com/Natural-Intelligence/context_logger'
  s.license       = 'MIT'


  # s.add_development_dependency 'bundler'
  # s.add_development_dependency 'rails'
  # s.add_development_dependency 'rspec', '~> 3.0'
  # s.add_development_dependency 'rspec-rails'
  # s.add_development_dependency 'faker'
end
