defmodule UiWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end
  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("clicked", %{"body" => body}, socket) do
    channel = 0
    intensity = 127

    for i <- 0..25, i > 0 do
      data = 1..30 |> Enum.map(fn (x) -> {255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1)} end)
      Nerves.Neopixel.render(channel, {intensity, data})
      :timer.sleep(40)
    end
    {:noreply, socket}
  end

  def handle_in("marquee", %{"body" => body}, socket) do
    channel = 0
    intensity = 127
    off = {0,0,0}
    # color = :rand.uniform(3) - 1
    # lit = case color do
    #   0 -> {255, 0, 0}
    #   1 -> {0, 255, 0}
    #   2 -> {0, 0, 255}
    #   _ -> {0,0,0}
    # end

    lit = {:rand.uniform(256) - 1, :rand.uniform(256) - 1, :rand.uniform(256) - 1}

    for i <- 0..29, i > 0 do
      data = 0..29 |> Enum.map(fn (x) -> if i >= x, do: lit, else: off end)
      Nerves.Neopixel.render(channel, {intensity, data})
      :timer.sleep(80)
    end

    for i <- 0..29, i > 0 do
      data = 0..29 |> Enum.map(fn (x) -> if i < x, do: lit, else: off end)
      Nerves.Neopixel.render(channel, {intensity, data})
      :timer.sleep(40)
    end
    {:noreply, socket}
  end

  def handle_in("turn_off", %{"body" => body}, socket) do
    channel = 0
    intensity = 127
    data = 1..30 |> Enum.map(fn (x) -> {0, 0, 0} end)
    Nerves.Neopixel.render(channel, {intensity, data})
    {:noreply, socket}
  end
end
