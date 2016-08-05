defmodule AssassinBackend.PlayerController do
  use AssassinBackend.Web, :controller

  alias AssassinBackend.Player

  plug :scrub_params, "player" when action in [:create, :update]

  def index(conn, _params) do
    player = Repo.all(Player)
    render(conn, "index.json", player: player)
  end

  def create(conn, %{"player" => player_params}) do
    nouns = ["Pizza", "Book", "Flamingo"]
    adjectives = ["Smelly", "Ridonculous", "Interesting"]
    player_alias = Enum.random(nouns) <> Enum.random(adjectives)
    
    changeset = Player.changeset(
      %Player{:alias => player_alias, :points => 0, :alive => true}, 
      player_params
    )

    case Repo.insert(changeset) do
      {:ok, player} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", player_path(conn, :show, player))
        |> render("show.json", player: player)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AssassinBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    player = Repo.get!(Player, id)
    render(conn, "show.json", player: player)
  end

  def update(conn, %{"id" => id, "player" => player_params}) do
    player = Repo.get!(Player, id)
    changeset = Player.changeset(player, player_params)

    case Repo.update(changeset) do
      {:ok, player} ->
        render(conn, "show.json", player: player)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AssassinBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    player = Repo.get!(Player, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(player)

    send_resp(conn, :no_content, "")
  end
end
