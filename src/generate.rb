require 'nokogiri'

doc_file = ARGV.first
file_name = ARGV.first

def check_doc_type doc
  sample = doc.css('h3').collect { |x| x.content }
  case sample[0...2]
  when ["MODULE", "MODULE SUMMARY"] then :module
  else :undef
  end
end

def write_html doc, file
  builder = Nokogiri::HTML::Builder.new do |b|
    b.html do
      b.header do b << '<link href="doc.css" media="screen" rel="stylesheet" type="text/css" />' end
      b.body do b << doc.css("#content").first end
    end
  end
  File.open("_output/erlang.docset/Contents/Resources/Documents/#{file}", 'w') {|f| f.write(builder.to_html) }
end

doc = Nokogiri::HTML(ARGF.read)
case check_doc_type(doc)
when :module then
  puts "CREATE TABLE IF NOT EXISTS searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT);"

  #write_html(doc, file_name)

  mod = doc.css("h3").first.next.next.content
  puts "INSERT INTO searchIndex VALUES (NULL, '#{mod}', 'cl', '#{file_name}');"
  doc.css("#content > .innertube > p > a").each do |x|
    fun = x.attr('name').gsub("'", "")
    puts "INSERT INTO searchIndex VALUES (NULL, '#{mod}:#{fun.sub('-', '/')}', 'func', '#{file_name}##{fun}');"
  end
end
