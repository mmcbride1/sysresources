# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sysresources/version'

Gem::Specification.new do |spec|
  spec.name          = "sysresources"
  spec.version       = Sysresources::VERSION
  spec.authors       = ["mmcbride1"]
  spec.email         = ["mrmcbride@smcm.edu"]

  spec.summary       = %q{command line tool to print basic system hardware resources (disk, cpu, ram, proc).}
  spec.homepage      = "https://github.com/mmcbride1/sysresources"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = ["sysresources"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "vmstat", "~> 2.3.0"
  spec.add_runtime_dependency "colorize", "~> 0.8.1"
  spec.add_runtime_dependency "sys-cpu", "~> 0.7.2"
  spec.add_runtime_dependency "sys-filesystem", "~> 1.1.7"
end
