defmodule AssassinBackend.Router do
  use AssassinBackend.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AssassinBackend do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", AssassinBackend do
    pipe_through :api
    resources "/players", PlayerController, except: [:new, :edit]
    resources "/games", GameController, only: [:create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", AssassinBackend do
  #   pipe_through :api
  # end
end
