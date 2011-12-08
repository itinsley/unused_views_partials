#!/usr/bin/env ruby

# A rather blunt instrument approach to finding unused partials. Checks the rails logs for instances of
# rendering or rendered to create a list of used views and partials then checks all partials against that list

p "*"*80
p "Assumes you started with a clean log (to avoid specs creating render log entries)"
p "and then raked all features successfully"
p "*"*80

erbs =  Dir.glob('app/views/**/*.erb').collect{|erb| erb.gsub(".html.erb","").gsub("app/views/","")}
p "ERBS"
y erbs
raw = `cat log/test.log | grep -i render`
lines = raw.split("\n")

used_assets = lines.collect{|line| line.split[5]}.group_by{|item| item}.keys

p "UNUSED ASSETS"
p "============="
erbs.each do |erb|
  p erb unless used_assets.include?(erb)
end
