defmodule AssassinBackend.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:game) do
      add :organizer_id, :integer

      timestamps
    end

  end
end
