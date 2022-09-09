defmodule Hexerei.Plug.VerifyRequest do
  defmodule IncompleteRequestError do
    @moduledoc """
    Error raised if a required field is missing.
    """

    defexception message: "Incomplete request"
  end

  defmodule UnauthorizedError do
    @moduledoc """
    Error raised if the request is unauthorized (missing or invalid token).
    """

    defexception message: "Unauthorized request"
  end

  # def init(options), do: options

  # def call(%Plug.Conn{request_path: path} = conn, opts) do
  #   if path in opts[:paths], do: verify_request!(conn.params, opts[:fields])
  #   conn
  # end

  defp verify_request!(params, fields) do
    verified =
      params
      |> Map.keys()
      |> contains_fields?(fields)

    unless verified, do: raise(IncompleteRequestError)
  end

  defp contains_fields?(keys, fields), do: Enum.all?(fields, &(&1 in keys))
end