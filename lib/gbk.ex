defmodule GBK do
  @moduledoc """
  Documentation for Gbk.
  """

  def to_utf8(src) do
    to_unicode(src) |> :unicode.characters_to_binary
  end
  def to_unicode(src) do
    to_unicode(src, [])
  end
  defp to_unicode("", des) do
    Enum.reverse(des)
  end
  defp to_unicode(src, des) do
    case next_unicode(src) do
      {:ok, c, remain} ->
        to_unicode(remain, [c|des])
      {:error, :eof} ->
        to_unicode("", des)
      {:error, desc, remain} ->
        {:error, desc, remain}
    end
  end

  defp next_unicode(src) do
    case next(src) do
      {:error, _} ->
        {:error, :eof}
      {:ok, c0, remain} ->
        cond do
          c0 < 0x80 ->
            {:ok, c0, remain}
          c0 == 0x80 ->
            {:ok, ?€, remain}
          c0 < 0xff ->
            case next(remain) do
              {:error, :eof} ->
                {:error, "too short src", remain}
              {:ok, c1, remain} ->
                c1 = cond do
                  0x40 <= c1 && c1 < 0x7f ->
                    c1 = c1 - 0x40
                  0x80 <= c1 && c1 < 0xff ->
                    c1 = c1 - 0x41
                end
                idx = (c0-0x81)*190 + c1
                r = Table.gbk_to_unicode(idx)
                {:ok, r, remain}
            end
        end
    end
  end

  defp next("") do
    {:error, :eof}
  end
  defp next(<<c::size(8), remain::binary>>) do
    {:ok, c, remain}
  end
end
