defmodule AssassinBackend.Repo.Migrations.OrganizerName do
  use Ecto.Migration

  def change do
    rename table(:game), :organizer_id, to: :organizer_name
  end
end
