defmodule AssassinBackend.PlayerView do
  use AssassinBackend.Web, :view

  def render("index.json", %{player: player}) do
    %{data: render_many(player, AssassinBackend.PlayerView, "player.json")}
  end

  def render("show.json", %{player: player}) do
    %{data: render_one(player, AssassinBackend.PlayerView, "player.json")}
  end

  def render("player.json", %{player: player}) do
    %{id: player.id,
      name: player.name,
      alias: player.alias,
      points: player.points,
      target: player.target}
  end
end
