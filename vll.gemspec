Gem::Specification.new do |spec|
  spec.name          = "vll"
  spec.version       = "0.1.15"
  spec.authors       = ["xzhu"]
  spec.email         = ["zhuxun2@gmail.com"]
  spec.homepage      = 'https://github.com/w9/vll'
  spec.summary       = "(V)iew (L)arge table. Format large table in a split of a second"
  spec.description   = "Nicely format columns of a large CSV/TSV file according to their content width, using first few lines as estimation thus extremely fast. Customizable."
  spec.license       = "MIT"
  spec.executables   = ["vl", "vll"]

  spec.add_runtime_dependency "colorize", '>= 0.7.7'
end
