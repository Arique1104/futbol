# Futbol
Contributors are:
- AJ (he/him)
  - [Github: ajtran303](https://github.com/ajtran303)
- Arique (she/they)
  - [Github: arique1104](https://github.com/arique1104)
- Kathy (she/her)
  - [Github: kathybui732](https://github.com/Kathybui732)
- Jonathan (he/him)
  - [Github: jonathan-m-wilson](https://github.com/jonathan-m-wilson)

## Start Your Own Futbol
- [Get familiar with Turing](https://turing.io/)
- [Read Through Project Futbol](https://backend.turing.io/module1/projects/futbol/)
- [Get the Futbol Spec Harness](https://github.com/turingschool-examples/futbol_spec_harness)


## Code Design & Walk-Through

## Two Top Docs

### runner.rb
- Our first interaction pattern on pry


### Stat_Tracker.rb
  - Take the CSV file and assign it to different objects to work on.
  - we used the modules (although incorrectly) to make our stat_tracker smaller
  - It makes the data more readable.

### StatTracker#methods:
  - collect_game_teams  
  - collect_games  
  - collect_teams  
  - game_teams  
  - games  
  - teams

### Refactoring Wish-List
__for for StatTracker__
  - consolidate current stat_tracker methods into one method.

______________________

## Collection Classes
### games_collection.rb
- Collects new game objects from games csv file

`game_path = './data/games.csv'`

### teams_collection.rb
- Collects new team objects from teams csv file

`team_path = './data/teams.csv'`

### game_teams_collection.rb
- Collects new game-team objects from games-teams csv file

`game_teams_path = './data/game_teams.csv'`

### Refactoring Wish-List
__for Collection Classes__
- review code learnings from file.io
  - [Museo Repository](https://github.com/turingschool-examples/museo)

- Opportunity for inheritance model
______________________

## Individual Object Classes
### Games

`games.rb`

- Able to create an object from the games CSV data

```
#CODE SAMPLE
@game_id = games_params[:game_id]
@season = games_params[:season]
@type = games_params[:type]
```

### Teams

`teams.rb`

- Able to create an object from the teams CSV data

```
#CODE SAMPLE
@team_id = teams_params[:team_id]
@franchiseid = teams_params[:franchiseid]
@teamname = teams_params[:teamname]
```

### Game-Teams

`game_teams.rb`
- Able to create an object from the game-teams CSV data

```
#CODE SAMPLE
@game_id = game_teams_param[:game_id]
@team_id = game_teams_param[:team_id]
@result = game_teams_param[:result]
@head_coach = game_teams_param[:head_coach]
@goals = game_teams_param[:goals].to_i
@shots = game_teams_param[:shots].to_i
```

### Refactoring Wish-List
__for Individual Object Classes__
- Combine it to one database instead of three.
______________________
## Modules
We initially wanted four different work spaces that we could test against our StatTracker Test, and Modules made sense because we understood that at the heart of modules is the need to hold behavior and our methods were in fact behavior.

As we continued to progress in our methods testing and development, we received feedback on the nuanced use of a module was to hold "shared" behavior not just behavior.  This meant we had to put a stronger eye towards universal refactoring.  Some initial thoughts of what more accurate modules would become are listed below in the Refactoring Wish-List.

### GameStatistics#methods:

  - all_total_scores
  - get_percentage
  - percentage_ties
  - average_goals_by_season
  - highest_total_score
  - percentage_visitor_wins
  - average_goals_per_game
  - lowest_total_score
  - count_of_games_by_season
  - percentage_home_wins

### LeagueStatistics#methods:
  - average_home_team_scores
  - highest_score
  - lowest_scoring_visitor
  - average_scores
  - highest_scoring_home_team
  - scores
  - average_team_scores
  - highest_scoring_visitor
  - team_scores
  - average_visitor_scores
  - home_team_scores
  - visitor_scores
  - best_offense
  - lowest_score
  - worst_offense
  - count_of_teams
  - lowest_scoring_home_team

### SeasonStatistics#methods:
  - fewest_tackles
  - least_accurate_team
  - results_by_head_coach
  - worst_coach
  - game_ids_in_season
  - most_accurate_team
  - tackles_by_team
  - goals_and_shots_by_team
  - most_tackles
  - winningest_coach

### TeamStatistics#methods:
  - all_games_by_team
  - fewest_goals_scored
  - team_info
  - all_opponents_stats
  - find_team_games_by_id
  - team_name
  - average_win_percentage
  - games_in_season
  - win_percentage
  - best_season
  - most_goals_scored
  - win_percentage_against
  - favorite_opponent
  - rival
  - worst_season

### Refactoring Wish-List
__for Modules__
- We would make our current Modules into classes and continue refactoring.
- AKA: calculatable
