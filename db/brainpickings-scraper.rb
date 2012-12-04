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

books_url = "http://bookpickings.brainpickings.org/"
doc = Nokogiri::HTML(open(books_url))
books = doc.css(".photo")

books.each do |book|
  title = book.at_css(".post_title h1").text
  author = book.at_css(".post_title h2").text
  link = book.at_css("a.post_title").attr('href')
  description = book.at_css("a.post_title p").text
  img = book.at_css(".post_thumbnail a img").attr('src')

  db.execute("INSERT INTO books (title, author, link, description, img) 
                VALUES (?, ?, ?, ?, ?)", title, author, link, description, img)
end


