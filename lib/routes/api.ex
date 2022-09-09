defmodule Router.Api do
  use Plug.Router
  use Plug.ErrorHandler

  plug(Plug.Logger)

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  defp json_res(conn, status, res) do
    conn
    |> put_resp_content_type("application/json")
    |> put_resp_header("cache-control", "no-cache")
    |> send_resp(status, Poison.encode!(res))
  end

  get "/" do
    json_res(conn, 400, %{code: 400, message: "No version specified"})
  end

  get "/#{Application.get_env(:hexerei, :api_version)}/:path" do
    json_res(conn, 200, %{code: 200, message: "API is up!"})
  end

  # Fallback route
  match _ do
    json_res(conn, 404, %{code: 404, message: "Not found"})
  end
end