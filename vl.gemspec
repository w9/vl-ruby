Gem::Specification.new do |spec|
  spec.name          = "vl"
  spec.version       = "0.0.1"
  spec.authors       = ["xzhu"]
  spec.email         = ["zhuxun2@gmail.com"]
  spec.summary       = "(V)iew (L)arge table. Format large table in a split of a second"
  spec.description   = "Nicely format columns of a large CSV/TSV file according to their content width, using first few lines as estimation thus extremely fast. Customizable."
  spec.license       = "MIT"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
end
