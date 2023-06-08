defmodule ExTwitter.API.Timelines do
  @moduledoc """
  Provides timeline API interfaces.
  """

  import ExTwitter.API.Base

  def mentions_timeline(options \\ []) do
    params = ExTwitter.Parser.parse_request_params(options)

    request(:get, "1.1/statuses/mentions_timeline.json", params)
    |> Enum.map(&ExTwitter.Parser.parse_tweet/1)
  end

  def user_timeline(options \\ []) do
    params = ExTwitter.Parser.parse_request_params(options)

    user_id = options |> Keyword.get(:user_id)

    request(
      :get,
      "2/users/#{user_id}/tweets",
      params
      |> Keyword.filter(fn {key, _val} ->
        key in [
          "id",
          "since_id",
          "until_id",
          "max_results",
          "pagination_token",
          "exclude",
          "start_time",
          "end_time",
          "expansions",
          "tweet.fields",
          "media.fields",
          "poll.fields",
          "place.fields",
          "user.fields"
        ]
      end)
    )
  end

  def home_timeline(options \\ []) do
    params = ExTwitter.Parser.parse_request_params(options)

    request(:get, "1.1/statuses/home_timeline.json", params)
    |> Enum.map(&ExTwitter.Parser.parse_tweet/1)
  end

  def retweets_of_me(options \\ []) do
    params = ExTwitter.Parser.parse_request_params(options)

    request(:get, "1.1/statuses/retweets_of_me.json", params)
    |> Enum.map(&ExTwitter.Parser.parse_tweet/1)
  end
end
