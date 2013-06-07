task :default => [:compile]

task :compile do

  require "coffee-script"
  require "uglifier"

  script = CoffeeScript.compile File.read("gem/vendor/assets/javascripts/angular-table.js.coffee")

  File.open("angular-table.js", "w") { |file| file.write(prepend_author_notice(script)) }
  File.open("angular-table.min.js", "w") { |file| file.write(prepend_author_notice(Uglifier.new.compile(script))) }

end

def prepend_author_notice script
  script.prepend "// homepage: http://github.com/ssmm/angular-table \n"
  script.prepend "// author: Samuel Mueller \n"
  script
end