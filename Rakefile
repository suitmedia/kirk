require 'ant'

directory 'build'
directory 'build/kirk'
directory 'build/kirk/classes'

FILES = Dir['src/**/*.java']

def class_path
  Dir['lib/kirk/jetty/*.jar'].join(':')
end

desc 'Compile the library'
task :compile => ['build/kirk/classes'] + FILES do |t|
  ant.javac :srcdir => "src", :destdir => t.prerequisites.first,
    :classpath => "#{class_path}:${java.class.path}:${sun.boot.class.path}"
end

desc 'Build the Jar'
task :jar => :compile do
  ant.jar :basedir => "build/kirk/classes", :destfile => "build/kirk/native.jar",
    :includes => "**/*.class"
end

desc 'Clean up build artifacts'
task :clean do
  rm_rf 'build'
end

task :default => :jar
