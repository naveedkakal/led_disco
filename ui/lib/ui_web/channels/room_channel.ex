defmodule UiWeb.RoomChannel do
  use Phoenix.Channel
  require Logger
  alias Ui.Led
  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end
  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("clicked", _body, socket) do
    channel = 0
    intensity = 60

    for i <- 0..25, i > 0 do
      data = 1..Led.led_count() |> Enum.map(fn (_x) -> {255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1)} end)
      Logger.info inspect data
      Nerves.Neopixel.render(channel, {intensity, data})
      :timer.sleep(40)
    end
    {:noreply, socket}
  end

  def handle_in("test", _body, socket) do
    channel = 0
    # intensity = 60
    val = {:rand.uniform(256) - 1, :rand.uniform(256) - 1, :rand.uniform(256) - 1}
    data = (1..Led.led_count()) |> Enum.map(fn x -> val end)
    (0..127) |> Enum.each(fn x ->
      Nerves.Neopixel.render(channel, {x, data})
      :timer.sleep(5)
    end)

    (0..127) |> Enum.each(fn x ->
      Nerves.Neopixel.render(channel, {127 - x, data})
      :timer.sleep(5)
    end)
    {:noreply, socket}
  end

  def handle_in("rainbow", _body, socket) do
    Led.rainbow()
    {:noreply, socket}
  end

  def handle_in("marquee", %{"body" => body}, socket) do
    channel = 0
    intensity = 127
    intensity = :rand.uniform(68) - 1 + 60
    off = {0,0,0}
    lec = Led.led_count() - 1

    for j <- 0..10, j > 0 do
      intensity = :rand.uniform(68) - 1 + 60
      lit = {:rand.uniform(256) - 1, :rand.uniform(256) - 1, :rand.uniform(256) - 1}
      for i <- 0..lec, i > 0 do
        data = 0..lec |> Enum.map(fn x -> if (i == x) || (i-1 == x) || (i-2 == x), do: lit, else: off end)
        Nerves.Neopixel.render(channel, {intensity, data})
        :timer.sleep(10)
      end
    end

    Ui.Led.turn_all_off
    {:noreply, socket}
  end

  def handle_in("turn_off", %{"body" => body}, socket) do
    Ui.Led.turn_all_off
    {:noreply, socket}
  end
end
