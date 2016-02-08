defmodule SuperBowl.Leaderboard do
  use GenServer

  alias SuperBowl.Team
  @teams [:team_one, :team_two]

  # Client
  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def print_score(name), do: Team.get_score(name)
  def print_score do
    Enum.map @teams, fn (team_name) ->
      Team.get_score(team_name)
    end
  end

  # Server
  def init(_) do
    :timer.send_after(30_000, :half_time)
    :timer.send_after(60_000, :full_time)
    {:ok, []}
  end

  def handle_info(:half_time, state) do
    IO.puts ~s"""
      \n
      ==================================================================
      HALF TIME!
      ==================================================================
      \n
      #{format_team_scores}
      \n
    """
    {:noreply, state}
  end

  def handle_info(:full_time, state) do
    IO.puts ~s"""
      \n
      ==================================================================
      GAME OVER!
      ==================================================================
      \n

      #{format_team_scores}
      \n

      $$$$$$$$$$$********$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$"         .d**$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$         z$"    ^"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$F      .d*"         ^*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$F    z$"$cd"           "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$F .d*" zb*beP            "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$b$"      d*$.e"            *$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$         ze*c.d            "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$r          dP$.e"           ^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$           .d$c.d           ^$$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$F            e$b.zr          ^$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$$.            .K$c.e          3$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$$$           ^  e$b z=         $$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$$$$            " .$$L.e        4$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$$$$$.            " .*$ .r      z$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$$$$$$c            " .$$L.z  .d*"$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$$$$$$$$c            " J$E z$"   $$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$$$$$$$$$$c           "".$P"     $$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$$$$$$$$$$$$e.        z$"       .$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$$$$$$$$$$$$$$$c.  .dP"         $$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$$$$$$$$$$$$$$$$$$$E.         z$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ee$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
      $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    """
    {:noreply, state}
  end

  defp format_team_scores do
    print_score
    |> Stream.map(fn({k, v}) ->  "#{k} - #{v}" end)
    |> Enum.join("\n")
  end
end
