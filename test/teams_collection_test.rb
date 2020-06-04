require "minitest/autorun"
require "minitest/pride"
require "./lib/teams_collection"
require "./lib/teams"

class TeamsCollectionTest < MiniTest::Test

	def setup
    @teams_csv_location = "./data/teams.csv"
    @teams_collection = TeamsCollection.new
	end

	def test_it_exists_with_attributes
		assert_instance_of TeamsCollection, @teams_collection
		assert_equal Teams, @teams_collection.statistics
		assert_equal [], @teams_collection.collection
	end

  def test_it_can_load_csv

    @teams_collection.load_csv(@teams_csv_location)

    assert_equal 32, @teams_collection.collection.count
    assert_equal true, @teams_collection.collection.all? { |object| object.is_a?(Teams) }

    teams_collection = TeamsCollection.from_csv(@teams_csv_location)

    assert_equal 32, teams_collection.count
    assert_equal true, teams_collection.all? { |object| object.is_a?(Teams) }
  end

	def test_it_can_load_statistics
    mock_teams_params = {
		      :team_id => "1",
		      :franchiseid => "23",
		      :teamname => "Atlanta United",
		      :abbreviation => "ATL",
		      :stadium => "Mercedes-Benz Stadium",
		      :link => "/api/v1/teams/1"
    }

    @teams_collection.load_statistics(mock_teams_params)

    assert_equal 1, @teams_collection.collection.count
    assert_equal true,  @teams_collection.collection.all? { |object| object.is_a?(Teams) }
  end

end
