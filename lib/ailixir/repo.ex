defmodule Ailixir.Repo do
  use Ecto.Repo,
    otp_app: :ailixir,
    adapter: Ecto.Adapters.Postgres
end
