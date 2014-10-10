require 'nokogiri'
require 'pry'

doc_file = ARGV.first
file_name = ARGV.first

doc = Nokogiri::HTML(ARGF.read)
puts "CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT);"
puts "CREATE UNIQUE INDEX anchor ON searchIndex (name, type, path);"

# write_html(doc, file_name)

sections = doc.css("h3")[1..-1].each do |s|
  a = s.css('a').first
  name = s.content.strip
  type = name.start_with?('I') ? "Protocol" : "Function"
  path = "om-documentation.html#{a.attr(:href)}"
  puts "INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES ('#{name}', '#{type}', '#{path}');"
end

