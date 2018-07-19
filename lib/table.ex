defmodule Table do
  @url "https://encoding.spec.whatwg.org/index-gb18030.txt"
  @path "./index-gb18030.txt"
  {:ok, file} = File.open(@path, [:read])
  all = Enum.map(IO.stream(file, :line), fn(line)->
    line = String.trim line
    cond do
      line |> String.starts_with?("#") ->
        {:error, 0}
      line == "" ->
        {:error, 0}
      line ->
        case String.split(line, ~r{\s}, trim: true) do
          [g, <<"0x", u::binary>>|_] ->
            {String.to_integer(g),String.to_integer(u, 16)}
          _remain ->
            {:error, 0}
        end
    end
  end)

  @all Enum.into(all, %{}) |> Map.delete(:error)
  def gbk_to_unicode(idx) do
    Map.get(@all,idx, 0)
  end
end
