Gem::Specification.new do |s|
  s.name        = 'context_logger'
  s.version     = '0.0.53'
  s.date        = '2017-08-10'
  s.summary     = 'Writes log by context'
  s.description = 'Writes log to db and log files (configurable destinations) according the context and exposes the log entries via http'
  s.authors     = ['Alexander Libster','Simon Levin','David Ron']
  s.email       = 'simon@naturalint.com'
  s.files         = `git ls-files`.split($/)
  s.homepage    = 'https://github.com/Natural-Intelligence/context_logger'
  s.license       = 'MIT'


  # s.add_development_dependency 'bundler'
  # s.add_development_dependency 'rails'
  # s.add_development_dependency 'rspec', '~> 3.0'
  # s.add_development_dependency 'rspec-rails'
  # s.add_development_dependency 'faker'
end
