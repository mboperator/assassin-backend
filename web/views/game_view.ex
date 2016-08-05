defmodule AssassinBackend.GameView do
  use AssassinBackend.Web, :view

  def render("index.json", %{game: game}) do
    %{data: render_many(game, AssassinBackend.GameView, "game.json")}
  end

  def render("show.json", %{game: game}) do
    %{data: render_one(game, AssassinBackend.GameView, "game.json")}
  end

  def render("game.json", %{game: game}) do
    %{id: game.id,
      organizer_name: game.organizer_name,
      in_waiting_room: game.in_waiting_room}
  end
end
