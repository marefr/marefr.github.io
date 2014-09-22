require "rubygems"
require 'rake'
require 'yaml'
require 'time'
require 'open-uri'
require 'RMagick'
require "digest/md5"

desc "Launch preview environment"
task :preview do
  system "jekyll serve --watch --drafts"
end # task :preview

desc "Generate icons based on your gravatar"
task :icons, [:email] do |t, args|
  author_email = args[:email]
  gravatar_id = Digest::MD5.hexdigest(author_email)
  base_url = "http://www.gravatar.com/avatar/#{gravatar_id}?s=150"

  origin = "origin.png"
  File.delete origin if File.exist? origin

  puts "Downloading base image file from gravatar..."
  open(origin, 'wb') do |file|
    file << open(base_url).read
  end

  name_pre = "apple-touch-icon-%dx%d-precomposed.png"

  FileList["*apple-touch-ico*.png"].each do |img|
    File.delete img
  end

  [180, 152, 120, 76, 57].each do |size|
    puts "Creating #{name_pre} icon..." % [size, size]
    Magick::Image::read(origin).first.resize(size, size).
      write(name_pre % [size, size])
  end

  system("cp " + name_pre % [180,180] + " apple-touch-icon-precomposed.png")
  system("cp " + name_pre % [180,180] + " apple-touch-icon.png")

  name_pre = "touch-icon-%dx%d.png"

  FileList["touch-ico*.png"].each do |img|
    File.delete img
  end

  [192].each do |size|
    puts "Creating #{name_pre} icon..." % [size, size]
    Magick::Image::read(origin).first.resize(size, size).
      write(name_pre % [size, size])
  end

  FileList["*favicon.ico"].each do |img|
    File.delete img
  end

  puts "Creating favicon.ico..."
  Magick::Image::read(origin).first.resize(32, 32).write("favicon.ico")

  puts "Cleaning up..."
  File.delete origin
end
