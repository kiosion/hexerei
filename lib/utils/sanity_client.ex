defmodule Hexerei.SanityClient do
  # Set variables from env
  @sanity_project_id Application.get_env(:hexerei, :sanity_project_id)
  @sanity_dataset Application.get_env(:hexerei, :sanity_dataset)
  @sanity_token Application.get_env(:hexerei, :sanity_token)

  # Set headers
  @headers [
    {"Content-Type", "application/json"},
    {"Authorization", "Bearer #{@sanity_token}"},
    {"Accept", "application/json"}
  ]

  # Methods
  def query(query) do
    # Send a query to the Sanity API
    #
    # Arguments:
    #   query: String
    #
    # Returns:
    #   {:ok, body} | {:error, reason}

    # Set URL
    url = "https://#{@sanity_project_id}.api.sanity.io/v1/data/query/#{@sanity_dataset}"

    # Send request
    case HTTPoison.post(url, query, @headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
