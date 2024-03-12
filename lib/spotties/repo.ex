defmodule Spotties.Repo do
  use Ecto.Repo,
    otp_app: :spotties,
    adapter: Ecto.Adapters.Postgres
end
