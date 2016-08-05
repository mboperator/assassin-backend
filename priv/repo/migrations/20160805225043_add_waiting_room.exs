defmodule AssassinBackend.Repo.Migrations.AddWaitingRoom do
  use Ecto.Migration

  def change do
    alter table(:game) do
      add :in_waiting_room, :boolean
    end
  end
end
