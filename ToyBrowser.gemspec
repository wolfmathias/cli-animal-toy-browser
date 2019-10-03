lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ToyBrowser/version"
require "ToyBrowser/lib/environment"

Gem::Specification.new do |spec|
  spec.name          = "ToyBrowser"
  spec.version       = ToyBrowser::VERSION
  spec.authors       = ["mplichta"]
  spec.email         = ["bigcatplichta@gmail.com"]

  spec.summary       = %q{TODO: This is the first portfolio project for Flatiron school.}
  spec.description   = %q{TODO: This project concept will eventually be used to create a new working website for the WildHeart Foundation, a nonprofit whose mission is to improve the lives of wild animals in captivity.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
