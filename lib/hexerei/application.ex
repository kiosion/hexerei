defmodule Hexerei.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {
        Plug.Cowboy,
        scheme: :http,
        plug: Hexerei.Router,
        options: [
          port: Application.get_env(:hexerei, :port)
        ]
      }
    ]

    opts = [strategy: :one_for_one, name: Hexerei.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
