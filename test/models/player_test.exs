defmodule AssassinBackend.PlayerTest do
  use AssassinBackend.ModelCase

  alias AssassinBackend.Player

  @valid_attrs %{alias: true, name: "some content", points: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Player.changeset(%Player{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Player.changeset(%Player{}, @invalid_attrs)
    refute changeset.valid?
  end
end
