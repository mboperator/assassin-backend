defmodule AssassinBackend.Game do
  use AssassinBackend.Web, :model

  schema "game" do
    field :organizer_name, :string
    field :in_waiting_room, :boolean

    timestamps
  end

  @required_fields ~w(organizer_name)
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
