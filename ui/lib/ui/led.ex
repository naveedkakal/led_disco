defmodule Ui.Led do
  def led_count do
    100
  end

  def turn_all_off do
    off_data = 1..led_count |> Enum.map(fn _ -> {0, 0, 0} end)
    Nerves.Neopixel.render(0, {0, off_data})
  end

  def rainbow do
    ct = led_count()
    b1 = div(ct, 3)
    b2 = div(ct, 3) * 2

    data = (0..(ct - 1)) |> Enum.map(fn x ->
      cond do
        x < 0 -> {x,0,0,0}
        x >= ct -> {x,0,0,0}
        x >= 0 && x < b1 ->
          mul = 255 / (b1 - 1)
          r = x * (mul)
          g = 255 - x * mul
          b = 0
          {trunc(r), trunc(g), trunc(b)}

        x >= b1 && x < b2 ->
          y = x - b1

          mul = 255 / (b2 - b1 - 1)
          r = 255 - y * mul
          g = 0
          b = y * mul
          {trunc(r), trunc(g), trunc(b)}
        x >= b2 && x <= ct ->
          y = x - b2
          mul = 255 / (ct - b2 - 1)
          r = 0
          g = y * mul
          b = 255 - y * mul
          {trunc(r), trunc(g), trunc(b)}
      end
    end)

    (0..1000) |> Enum.each(fn x ->
      intensity = [x, 127] |> Enum.min
      Nerves.Neopixel.render(0, {intensity, lrotate(data, x)})
      # :timer.sleep(40)
    end)
  end

  def lrotate(list, 0), do: list
  def lrotate([head|list], number), do: lrotate(list ++ [head], number - 1)
end
