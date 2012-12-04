require 'rubygems'
require 'nokogiri'
require 'open-uri'
# require 'sqlite3'
# require 'FileUtils'

# FileUtils.rm("books.db") if File.exists?("books.db")

# db = SQLite3::Database.new "books.db"

# db.execute <<-SQL
#   CREATE TABLE books (
#     id INTEGER PRIMARY KEY,
#     title TEXT,
#     author TEXT,
#     description TEXT,
#     image TEXT,
#     published DATE,
#     link TEXT,
#   );
# SQL


books_url = 'http://www.npr.org/2011/12/14/143293240/year-end-fiction-wrap-up-the-10-best-novels-of-2011'
doc = Nokogiri::HTML(open(books_url))
books = doc.at_css("#res143293434").text
doc.css("#res143293434").each do |book|
  title = book.at_css("#div.bucketblock h3 a")
  puts title
end


# books.each do |book|
#   puts book.at_css("#supplementarycontent h3 a").text
# end
  # next if !programmer_link.first_element_child
  # next if !programmer_link.first_element_child.key?("href")
  # wiki_url = "http://en.wikipedia.org" + programmer_link.first_element_child['href']
  # tag_line = programmer_link.inner_text.split(' - ')[1]

  # doc = Nokogiri::HTML(open(wiki_url))
  # name = (doc/"#firstHeading span").inner_text
  # sidebox_info = (doc/".vcard").inner_text
  # # image_url = (doc/"img[src*=upload] a")
#   db.execute("INSERT INTO programmers (name, tag_line, sidebox_info, wiki_url) 
#             VALUES (?, ?, ?, ?)", name, tag_line, sidebox_info, wiki_url)
# end