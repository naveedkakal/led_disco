defmodule Ui.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(UiWeb.Endpoint, []),
      worker(Nerves.Neopixel, [[pin: 18, count: 30]])
      # Start your own worker by calling: Ui.Worker.start_link(arg1, arg2, arg3)
      # worker(Ui.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ui.Supervisor]
    start_val = Supervisor.start_link(children, opts)
    Nerves.Neopixel.render(0, {127, 1..30 |> Enum.map(fn (x) -> {0, 0, 0} end)})
    start_val
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    UiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
