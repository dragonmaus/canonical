# frozen_string_literal: true
Gem::Specification.new do |s|
  s.name      = 'canonical'
  s.version   = '0.0.2'
  s.license   = 'MIT'
  s.summary   = 'URI canonicalization extension for Addressable::URI'
  s.author    = 'DragonMaus'
  s.homepage  = 'https://github.com/dragonmaus/canonical'
  s.files     = ['lib/addressable/uri/canon.rb']

  s.add_runtime_dependency 'fetchable-uri', '~> 0'
  s.add_runtime_dependency 'nokogiri', '~> 1.6'
end
