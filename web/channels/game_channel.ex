defmodule AssassinBackend.GameChannel do
  use AssassinBackend.Web, :channel

  def join("games:" <> game_id, payload, socket) do
    case authorize(game_id, payload["player_id"]) do
      {player, game} ->
        { :ok, socket |> assign(:game, game) |> assign(:player, player) }
      {nil, game} ->
        {:error, %{reason: "non existent player"}}
      {player, nil} ->
        {:error, %{reason: "non existent game"}}
    end
  end

  def handle_in(event, params, socket) do
    target = Repo.get_by(
      AssassinBackend.Player,
      %{ id: params["agent_id"], alias: params["alias"] }
    )

    handle_in(event, params, target, socket)
  end

  def handle_in("ping", payload, target, socket) do
    count = socket.assigns[:count] || 1
    push socket, "ping", %{player: socket.assigns.player, target: target}
    {:noreply, assign(socket, :count, count+1)}
  end

  def handle_in("kill", payload, target, socket) do
    if (player.points < 100) do
      push socket, "kill_fail", %{player: socket.assigns.player, target: target}
      {:reply, :ok, socket}
    end

    if (player.target_id == target.id) do
      changeset = AssassinBackend.changeset(target, %{ alive: false })
      case Repo.update(changeset) do
        {:ok, friend} ->
          handle_in("state", payload, socket)
      end
    else
      {:reply, :ok, socket}
    end
  end

  def handle_in("record", payload, player, target, socket) do
    if target do
      changeset = AssassinBackend.changeset(
        target,
        %{ points: target.points + 200 }
      )
      Repo.update(changeset)
    end

    {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorize(game_id, player_id) do
    player = Repo.get(AssassinBackend.Player, player_id)
    game = Repo.get(AssassinBackend.Game, game_id)
    { player, game }
  end
end
