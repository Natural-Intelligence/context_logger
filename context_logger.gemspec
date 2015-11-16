Gem::Specification.new do |s|
  s.name        = 'context_logger'
  s.version     = '0.0.40'
  s.date        = '2015-11-11'
  s.summary     = 'writes log to db and log file and exposes it via http'
  s.description = 'writes log to db and log file and exposes it via http'
  s.authors     = ['Alexander Libster']
  s.email       = '012alex012@gmail.com'
  # s.files         = `git ls-files`.split($/)
  s.files       = %w(lib/context_logger.rb lib/context_logger/engine.rb db/migrate/20151112164817_create_context_logs.rb
app/models/context_log.rb app/controllers/api/v1/resources/context_logger_controller.rb config/routes.rb)
  s.homepage    = ''
  s.license       = 'MIT'


  # s.add_development_dependency 'bundler'
  # s.add_development_dependency 'rails'
  # s.add_development_dependency 'rspec', '~> 3.0'
  # s.add_development_dependency 'rspec-rails'
  # s.add_development_dependency 'faker'
end
