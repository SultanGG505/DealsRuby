Gem::Specification.new do |s|
  s.name        = 'sultangg505_gem_deals'
  s.version     = '0.1.0'
  s.licenses    = ['MIT']
  s.summary     = "Models and controllers for deals app"
  s.description = "This gem contains models and controllers for deals app. You need to make your own realization."
  s.authors     = ["sultangg505"]
  s.email       = 'sultangordovg@gmail.com'
  s.files       = Dir['lib/*']
  s.add_dependency('mysql2')
  s.add_dependency('glimmer-dsl-libui', '~> 0.7.4')
  s.add_dependency('win32api')
  s.homepage    = 'https://rubygems.org/gems/sultangg505_gem_deals'
  s.metadata    = { "source_code_uri" => "https://github.com/SultanGG505/DealsRuby" }
  s.required_ruby_version = '>= 3.0'
end
