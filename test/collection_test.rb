require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/collection"

class CollectionTest < MiniTest::Test

  def setup
    @collection = Collection.new
    @location = './data/game_teams.csv'
  end

  def test_it_exists
    assert_instance_of Collection, @collection
    assert_equal [], @collection.collection
  end

  def test_it_returns_a_collection_of_statistics
    assert_equal [], Collection.from_csv(@location)
  end

  def test_it_can_load_statistics
    csv_headers_mock = mock

    @collection.load_statistics(csv_headers_mock)

    assert_equal [], @collection.collection
  end

  def test_it_can_load_csv
    mock_stats_1 = mock
    mock_stats_2 = mock

    @collection.stubs(:load_csv).returns([mock_stats_1, mock_stats_2])

    assert_equal [mock_stats_1, mock_stats_2], @collection.load_csv(@location)
  end

end
