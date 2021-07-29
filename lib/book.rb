class Book

  attr_reader :title,
              :author,
              :publication_year

  def initialize(params)
    @title            = params[:title]
    @author           = params[:author_first_name] + " " + params[:author_last_name]
    #Yes, this is ridiculous but I couldn't get other methods to work.
    @publication_year = params[:publication_date][-4] +params[:publication_date][-3] +params[:publication_date][-2] +params[:publication_date][-1]
  end
end
