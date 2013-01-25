require 'nokogiri'
require 'open-uri'
require 'sqlite3'
require 'FileUtils'

FileUtils.rm("books.db") if File.exists?("books.db")

db = SQLite3::Database.new "books.db"

db.execute <<-SQL
  CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    title TEXT,
    link TEXT,
    author TEXT,
    description TEXT,
    img TEXT
  );
SQL

# Scrape only first page

# books_url = "http://bookpickings.brainpickings.org/"
# doc = Nokogiri::HTML(open(books_url))
# books = doc.css(".photo")

# books.each do |book|
#   title = book.at_css(".post_title h1").text
#   author = book.at_css(".post_title h2").text
#   link = book.at_css("a.post_title").attr('href')
#   description = book.at_css("a.post_title p").text
#   img = book.at_css(".post_thumbnail a img").attr('src')

#   db.execute("INSERT INTO books (title, author, link, description, img) 
#                 VALUES (?, ?, ?, ?, ?)", title, author, link, description, img)
# end

#Scraping all pages

1.upto(3) do |page_number|
  books_url = "http://bookpickings.brainpickings.org/"
  books_url << 'page/' + page_number.to_s
  doc = Nokogiri::HTML(open(books_url))

  books = doc.css(".photo")

  books.each do |book|
    # puts "=================="
    title = book.at_css(".post_title h1").text  
      if book.at_css(".post_title h2").nil?
        author = 'unknown'
      else
        author = book.at_css(".post_title h2").text
      end
    link = book.at_css("a.post_title").attr('href')
    description = book.at_css("a.post_title p").text
    img = book.at_css(".post_thumbnail a img").attr('src')
    db.execute("INSERT INTO books (title, author, link, description, img) 
                VALUES (?, ?, ?, ?, ?)", title, author, link, description, img)
  end
end
