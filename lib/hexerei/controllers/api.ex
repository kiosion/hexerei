defmodule Api.Plug do
  import Plug.Conn
  @behaviour Plug

  def init(opts), do: opts

  def call(conn = %{path_info: ["api"]}, _opts) do
    IO.inspect(conn)
    conn
    |> send_resp(200, "API Route OK")
    |> halt()
  end

  # pass down chain
  def call(conn, _opts), do: conn
end
