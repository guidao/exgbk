defmodule GbkTest do
  use ExUnit.Case
  doctest GBK

  test "gbk to utf8" do
    url = "http://www.booktxt.net/5_5871/3631181.html"
    {:ok, resp} = HTTPoison.get url
    e = GBK.to_utf8(resp.body)
    IO.inspect e
  end
end
