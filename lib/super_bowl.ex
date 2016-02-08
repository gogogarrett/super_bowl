defmodule SuperBowl do
  use Application

  @teams Application.get_env(:super_bowl, :teams)

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    team_workers = Enum.map @teams, fn (team_name) ->
      worker(SuperBowl.Team, [team_name, %{}], id: team_name)
    end

    children = team_workers ++ [
      worker(SuperBowl.Leaderboard, [[]]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SuperBowl.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
