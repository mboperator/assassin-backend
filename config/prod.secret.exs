use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :assassin_backend, AssassinBackend.Endpoint,
  secret_key_base: "bXbrV/0WYwthcaJsByPl7CoMDQ6fMy/Ak2ITt83jrSylbozT8/L5kUu0lfgXEYZt"

# Configure your database
config :assassin_backend, AssassinBackend.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "assassin_backend_prod",
  pool_size: 20
