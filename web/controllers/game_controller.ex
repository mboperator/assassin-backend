defmodule AssassinBackend.GameController do
  use AssassinBackend.Web, :controller

  alias AssassinBackend.Game

  # plug :scrub_params, "game" when action in [:create, :update]

  def index(conn, _params) do
    game = Repo.all(Game)
    render(conn, "index.json", game: game)
  end

  def create(conn, %{"organizer_id" => organizer_id}) do
    changeset = Game.changeset(%Game{}, %{"organizer_id" => organizer_id})
    IO.puts organizer_id

    case Repo.insert(changeset) do
      {:ok, organizer_id} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", game_path(conn, :show, organizer_id))
        |> render("show.json", organizer_id: organizer_id)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AssassinBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Repo.get!(Game, id)
    render(conn, "show.json", game: game)
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = Repo.get!(Game, id)
    changeset = Game.changeset(game, game_params)

    case Repo.update(changeset) do
      {:ok, game} ->
        render(conn, "show.json", game: game)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AssassinBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = Repo.get!(Game, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(game)

    send_resp(conn, :no_content, "")
  end
end

