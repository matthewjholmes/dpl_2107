class Author

  attr_reader :name, :books

  def initialize(params)
    @name = params[:first_name] + " " + params[:last_name]
    @books = []
  end

  def write(title, date)
    book = Book.new({author_first_name: @name.split(" ")[0], author_last_name: @name.split(" ")[1], title: title, publication_date: date})
    @books << book
    book
  end
end
