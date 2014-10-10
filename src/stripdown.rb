require 'nokogiri'
require 'pry'

doc_file = ARGV.first
file_name = ARGV.first

def write_html doc, file
  builder = Nokogiri::HTML::Builder.new do |b|
    b.html do
      b.head do b << '<link href="gollum.css" media="screen" rel="stylesheet" type="text/css" />' end
      doc.css("#wiki-body h3").each do |h3|
        h3.set_attribute :id, h3.css("a").first.attr(:href)[1..-1]
      end
      b.body do b << doc.css("#wiki-body").first end
    end
  end
  File.open("_output/om.docset/Contents/Resources/Documents/#{File.basename(file)}", 'w') {|f| f.write(builder.to_html) }
end

doc = Nokogiri::HTML(ARGF.read)
write_html(doc, file_name)
