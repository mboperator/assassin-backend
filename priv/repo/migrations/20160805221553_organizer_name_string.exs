defmodule AssassinBackend.Repo.Migrations.OrganizerNameString do
  use Ecto.Migration

  def change do
    alter table(:game) do
      modify :organizer_name, :string
    end
  end
end
