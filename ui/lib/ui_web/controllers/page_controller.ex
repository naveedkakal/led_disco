defmodule UiWeb.PageController do
  use UiWeb, :controller

  def index(conn, _params) do
    # ch0_config = [pin: 18, count: 8]
    # ch1_config = [pin: 19, count: 3]
    # {:ok, pid} = Nerves.Neopixel.start_link(ch0_config, ch1_config)

    # channel = 0
    # intensity = 127
    # data = [
    #   {255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1)},
    #   {255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1)},
    #   {255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1)},
    #   {255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1)},
    #   {255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1)},
    #   {255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1)},
    #   {255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1)},
    #   {255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1), 255 * (:rand.uniform(2) - 1)},
    # ]
    # Nerves.Neopixel.render(channel, {intensity, data})
    render conn, "index.html"
  end
end
