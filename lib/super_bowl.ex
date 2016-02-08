defmodule SuperBowl do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      worker(SuperBowl.Team, [:team_one, %{}], id: 1),
      worker(SuperBowl.Team, [:team_two, %{}], id: 2),
      worker(SuperBowl.Leaderboard, [[]]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SuperBowl.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
