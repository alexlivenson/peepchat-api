defmodule Peepchat.Router do
  use Peepchat.Web, :router

  # Unauthorized Requests
  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  # Authorized Requests
  pipeline :api_auth do
    plug :accepts, ["json", "json-api"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/api", Peepchat do
    pipe_through :api

    # resources is basically a way of setting up multiple routes
    # Registration
    post "/register", RegistrationController, :create
    # Login, NOTE: Alex L - 'as: :login' has this route refer to 'login_path'
    post "/token", SessionController, :create, as: :login
  end

  scope "/api", Peepchat do
    pipe_through :api_auth
    get "/user/current", UserController, :current
  end
end
