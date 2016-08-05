defmodule AssassinBackend.GameChannel do
  use AssassinBackend.Web, :channel

  def join("games:" <> game_id, payload, socket) do
    if authorized?(payload) do
      {
        :ok,
        socket
        |> assign(:game_id, String.to_integer(game_id)
        |> assign(:player_id, payload["player_id"])
      }
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in(event, params, socket) do
    player = Repo.get(AssassinBackend.Player, socket.assigns.player_id)
    target = Repo.get_by(
      AssassinBackend.Player,
      %{ id: payload["agent_id"], alias: payload["alias"] }
    )

    handle_in(event, params, player, target, socket)
  end

  def handle_in("ping", payload, player, target, socket) do
    count = socket.assigns[:count] || 1
    push socket, "ping", %{player: player, target: target}
    {:noreply, assign(socket, :count, count+1)}
  end

  def handle_in("kill", payload, player, target, socket) do
    if (player.points < 100) do
      push socket, "kill_fail", %{player: player, target: target}
      {:reply, :ok, socket}
    end

    if (player.target_id == target.id) do
      changeset = AssassinBackend.changeset(target, { alive: false })
      Repo.update(changeset)
      {:ok, friend} -> handle_in("state", payload, socket)
    else
      {:reply, :ok, socket}
    end
  end

  def handle_in("record", payload, player, socket) do
    if target do
      changeset = AssassinBackend.changeset(
        target,
        { points: target.points + 200 }
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
  defp authorized?(_payload) do
    true
  end
end
