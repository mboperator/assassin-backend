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
      organizer_id: game.organizer_id}
  end
end
