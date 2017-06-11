defmodule Peepchat.UserTest do
  use Peepchat.ModelCase

  alias Peepchat.User

  @valid_attrs %{email: "jim@test.com", password: "testtest", password_confirmation: "testtest"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "mis-matched password_confirmation doesn't work" do
    changeset = User.changeset(%User{}, %{email: "jim@test.com", password: "testtest", password_confirmation: "test"})
    refute changeset.valid?
  end

  test "missing password confirmation does not work" do
    changeset = User.changeset(%User{}, %{email: "jim@test.com", password: "testtest"})
    refute changeset.valid?
  end

  test "short password doesn't work" do
    changeset = User.changeset(%User{}, %{email: "jim@test.com", password: "test", password_confirmation: "test"})
    refute changeset.valid?
  end
end
