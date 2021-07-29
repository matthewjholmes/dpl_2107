class Library

  attr_reader :name, :books, :authors

  def initialize(name)
    @name    = name
    @books   = []
    @authors = []
  end

  def add_author(author)
    @authors << author
    @books << author.books
    @books.flatten!
  end

  def publication_time_frame_for(author)
    hash = {start: "", end: ""}
    start_year = 3000
    last_year = 1
    author.books.each do |book|
      if start_year > book.publication_year.to_i
        start_year = book.publication_year.to_i
      end
    end
    author.books.each do |book|
      if last_year < book.publication_year.to_i
        last_year = book.publication_year.to_i
      end
    end
    hash[:start] = start_year
    hash[:end] = last_year
    hash
  end

end
