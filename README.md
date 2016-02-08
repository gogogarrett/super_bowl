# SuperBowl

A simple application to demonstrate how to use the [GenServer](http://elixir-lang.org/getting-started/mix-otp/genserver.html) in an elixir project.

![](https://cloud.githubusercontent.com/assets/873687/12885271/b4bce954-ceb8-11e5-9ab5-3fede15b72dc.png)

# Usage

There are currently two team names, `:team_one` and `:team_two`.

You can simulate the team scoring points with the following API.

```elixir
iex(1)> SuperBowl.Team.touchdown(:team_one)
:ok
iex(2)> SuperBowl.Team.free_kick(:team_two)
:ok
iex(3)> SuperBowl.Team.two_point_conv(:team_one)
:ok
iex(4)> SuperBowl.Team.field_goal(:team_two)
:ok
```

To see the current score of the game, you can easily print the results for each team with

```elixir
iex(1)> SuperBowl.Leaderboard.print_score(:team_one)
{:team_one, 7}
iex(2)> SuperBowl.Leaderboard.print_score(:team_two)
{:team_two, 10}
iex(3)> SuperBowl.Leaderboard.print_score
[team_one: 7, team_two: 10]
```

After halftime, and fulltime you will get the leaderboards reported to you!
