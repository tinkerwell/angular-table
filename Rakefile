task :default => [:compile]

task :compile do

  require "coffee-script"
  require "uglifier"

  script = CoffeeScript.compile File.read("coffee/angular-table.js.coffee")

  File.open("dist/angular-table.js", "w") { |file| file.write(add_author_notice(script)) }
  File.open("dist/angular-table.min.js", "w") { |file| file.write(add_author_notice(Uglifier.new.compile(script))) }

end

def add_author_notice script
  script.prepend "// homepage: http://github.com/ssmm/angular-table \n"
  script.prepend "// author: Samuel Mueller \n"
  script
end