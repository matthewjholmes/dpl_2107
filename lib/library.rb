class Library

  attr_reader :name,
              :books,
              :authors,
              :checked_out_books

  def initialize(name)
    @name    = name
    @books   = []
    @authors = []
    @checked_out_books = []
    @book_checkout_count = {}
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
    hash[:start] = start_year.to_s
    hash[:end] = last_year.to_s
    hash
  end

  def checkout(book)
    if @books.include?(book) && !@checked_out_books.include?(book)
      @checked_out_books << book
      @book_checkout_count[book] ||= 1
        @book_checkout_count[book] +=1
      true
    else
      false
    end
  end

  def return(book)
    @checked_out_books.delete(book)
  end

  def most_popular_book
    @book_checkout_count.max_by { |book, count| count}[0]
  end
end
