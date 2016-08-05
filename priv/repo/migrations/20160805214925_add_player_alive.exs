defmodule AssassinBackend.Repo.Migrations.AddPlayerAlive do
  use Ecto.Migration

  def change do
    alter table(:player) do
      add :alive, :boolean
    end
  end
end
