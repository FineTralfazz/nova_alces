def build_superstar
  Dir.chdir 'superstar'
  `make clean`
  `make`
  Dir.chdir '..'
end
