task :default => [:compile]

task :compile do

  require File.expand_path("gem/lib/angular-table/version")

  require "coffee-script"
  require "uglifier"

  script = CoffeeScript.compile File.read("gem/vendor/assets/javascripts/angular-table.js.coffee")

  File.open("angular-table.js", "w") { |file| file.write(prepend_author_notice(script)) }
  File.open("angular-table.min.js", "w") { |file| file.write(prepend_author_notice(Uglifier.new.compile(script))) }

end

def prepend_author_notice script
  comments = ""
  comments << "// author: Samuel Mueller \n"
  comments << "// homepage: http://github.com/ssmm/angular-table \n"
  comments << "// version: #{AngularTable::VERSION} \n"

  script.prepend comments
  script
end