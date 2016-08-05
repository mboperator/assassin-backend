defmodule AssassinBackend.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:player) do
      add :name, :string
      add :alias, :string, default: false
      add :points, :integer
      add :target, references(:player, on_delete: :nothing)

      timestamps
    end
    create index(:player, [:target])

  end
end
