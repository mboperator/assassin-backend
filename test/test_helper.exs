ExUnit.start

Mix.Task.run "ecto.create", ~w(-r AssassinBackend.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r AssassinBackend.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(AssassinBackend.Repo)

