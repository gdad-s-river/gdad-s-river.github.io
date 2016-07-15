require "tmpdir"
require "bundler/setup"
require "jekyll"

# Template for the post
post_template = <<END_TEMPLATE
---
layout: post
title: POST_TITLE
---

END_TEMPLATE

# Helper method for user input
def ask(message)
  print message
  STDIN.gets.chomp
end

desc "Update Site"
task :update do
  sh "jekyll --no-auto"
end

desc 'Make a new draft post'
task :new do
  title = ask("Title: ")
  filename = title.downcase.gsub(/[^a-z0-9]/,"-")
  filepath = "_drafts/#{Time.now.strftime('%Y-%m-%d-')}#{filename}.markdown"
  File.open(filepath, 'w+') do |f|
    f << post_template.gsub(/POST_TITLE/, title)
  end
  sh "git add #{filepath}"
end

desc 'Publish draft post'
task :publish_draft do
  files = Dir.glob("_drafts/*.markdown")
  if files.size == 0
    puts "Nothing to publish :("
  else
    files.each do |file|
      post_data = file.match(/(?<date>\d{4}-\d{2}-\d{2})-(?<title>.+).markdown$/)
      if ask("Do you want to publish #{post_data[:title]}? (Y/n)") == 'Y'
        sh "git mv #{file} '_posts'"
      end
    end
  end
end

desc "Generate blog files"
task :generate do
  Jekyll::Site.new(Jekyll.configuration({
    "source"      => ".",
    "destination" => "_site"
  })).process
end

desc "Generate and publish blog to gh-pages"
task :publish => [:generate] do
  Dir.mktmpdir do |tmp|
    cp_r "_site/.", tmp
    Dir.chdir tmp
    system "git init"
    system "git add ."
    message = "Site updated at #{Time.now.utc}"
    system "git commit -m #{message.inspect}"
    system "git remote add origin git@github.com:martinisoft/martinisoft.github.com.git"
    system "git push origin master --force"
  end
end

