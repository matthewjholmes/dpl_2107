require './lib/library'
require './lib/author'
require './lib/book'

RSpec.describe Library do
  before(:each) do
    @dpl = Library.new("Denver Public Library")
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    @professor = @charlotte_bronte.write("The Professor", "1857")
    @villette = @charlotte_bronte.write("Villette", "1853")
    @harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    @mockingbird = @harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
  end

  it 'exists and has attributes' do
    expect(@dpl).to be_instance_of(Library)
    expect(@dpl.name).to eq("Denver Public Library")
    expect(@dpl.books).to eq([])
    expect(@dpl.authors).to eq([])
  end

  it 'can add authors & their books' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    expect(@dpl.authors).to eq([@charlotte_bronte, @harper_lee])
    expect(@dpl.books).to eq([@jane_eyre, @professor, @villette, @mockingbird])
  end

  it 'creates publication time frame hash' do
    expect(@dpl.publication_time_frame_for(@charlotte_bronte)).to eq({:start=>"1847", :end=>"1857"})
    expect(@dpl.publication_time_frame_for(@harper_lee)).to eq({:start=>"1960", :end=>"1960"})
  end

  it 'allows checkout and return of books' do
    expect(@dpl.checkout(@mockingbird)).to eq(false)
    expect(@dpl.checkout(@jane_eyre)).to eq(false)

    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    expect(@dpl.checkout(@jane_eyre)).to eq(true)
    expect(@dpl.checked_out_books).to eq([@jane_eyre])
    expect(@dpl.checkout(@jane_eyre)).to eq(false)

    @dpl.return(@jane_eyre)

    expect(@dpl.checked_out_books).to eq([])

    expect(@dpl.checkout(@jane_eyre)).to eq(true)
    expect(@dpl.checkout(@villette)).to eq(true)
    expect(@dpl.checked_out_books).to eq([@jane_eyre, @villette])
    expect(@dpl.checkout(@mockingbird)).to eq(true)

    @dpl.return(@mockingbird)

    expect(@dpl.checkout(@mockingbird)).to eq(true)

    @dpl.return(@mockingbird)

    expect(@dpl.checkout(@mockingbird)).to eq(true)
  end

  it 'returns most popular book' do
    expect(@dpl.checkout(@mockingbird)).to eq(false)
    expect(@dpl.checkout(@jane_eyre)).to eq(false)

    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    expect(@dpl.checkout(@jane_eyre)).to eq(true)
    expect(@dpl.checked_out_books).to eq([@jane_eyre])
    expect(@dpl.checkout(@jane_eyre)).to eq(false)

    @dpl.return(@jane_eyre)

    expect(@dpl.checked_out_books).to eq([])

    expect(@dpl.checkout(@jane_eyre)).to eq(true)
    expect(@dpl.checkout(@villette)).to eq(true)
    expect(@dpl.checked_out_books).to eq([@jane_eyre, @villette])
    expect(@dpl.checkout(@mockingbird)).to eq(true)

    @dpl.return(@mockingbird)

    expect(@dpl.checkout(@mockingbird)).to eq(true)

    @dpl.return(@mockingbird)

    expect(@dpl.checkout(@mockingbird)).to eq(true)

    expect(@dpl.most_popular_book).to eq(@mockingbird)
  end
end
