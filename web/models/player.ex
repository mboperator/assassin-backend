defmodule AssassinBackend.Player do
  use AssassinBackend.Web, :model

  schema "player" do
    field :name, :string
    field :alias, :string
    field :points, :integer
    belongs_to :target_player, AssassinBackend.Player, foreign_key: :target, references: :name
    belongs_to :current_game, AssassinBackend.Game, foreign_key: :game
    field :alive, :boolean

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
