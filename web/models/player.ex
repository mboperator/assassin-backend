defmodule AssassinBackend.Player do
  use AssassinBackend.Web, :model

  schema "player" do
    field :name, :string
    field :alias, :boolean, default: false
    field :points, :integer
    field :alias, :boolean, default: false
    belongs_to :target, AssassinBackend.Target

    timestamps
  end

  @required_fields ~w(name alias points alias)
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
