defmodule SuperBowl.Team do
  use GenServer

  # Client
  def start_link(team_name, initial_state) do
    GenServer.start_link(__MODULE__, {team_name, initial_state}, name: team_name)
  end

  def touchdown(name),      do: GenServer.cast(name, :touchdown)
  def free_kick(name),      do: GenServer.cast(name, :free_kick)
  def two_point_conv(name), do: GenServer.cast(name, :two_point_conv)
  def field_goal(name),     do: GenServer.cast(name, :field_goal)
  def get_score(name),      do: {name, GenServer.call(name, :get_score)}

  # Server
  def init({team_name, state}) do
    {:ok, Map.put(state, :score, 0)}
  end

  def handle_call(:get_score, _from, state) do
    {:reply, state.score, state}
  end

  def handle_cast(:touchdown, state),       do: {:noreply, update_score(state, 6)}
  def handle_cast(:free_kick, state),       do: {:noreply, update_score(state, 1)}
  def handle_cast(:two_point_conv, state),  do: {:noreply, update_score(state, 2)}
  def handle_cast(:field_goal, state),      do: {:noreply, update_score(state, 3)}

  defp update_score(state, inc_by) do
    # [g] - prettier way to write this?
    {_, state} = Map.get_and_update state, :score, fn(score) ->
      {score, score + inc_by}
    end
    state
  end

end
