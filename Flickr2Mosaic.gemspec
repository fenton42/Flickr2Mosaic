# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flickr2mosaic/version'

Gem::Specification.new do |spec|
  spec.name          = "flickr2mosaic"
  spec.version       = Flickr2Mosaic::VERSION
  spec.authors       = ["Tobias Overkamp"]
  spec.email         = ["fenton42@tov.io"]

  spec.summary       = %q{This is a GEM that eases fetching of multiple images from Flickr}
  spec.homepage      = "http://github.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.1"
  
  
  spec.add_runtime_dependency "mini_magick" , "~> 4.5.1"
  spec.add_runtime_dependency "flickraw", "~> 0.9.9"
end
