defmodule TurboCounterWeb.CountLive do
  use TurboCounterWeb, :live_view
  alias TurboCounter.Counters

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> new
      |> add_counter
    }
  end

  defp new(socket) do
    assign(socket, counters: Counters.new())
  end

  defp add_counter(socket) do
    assign(
      socket,
      counters: Counters.add_counter(socket.assigns.counters)
      )
  end

  def render(assigns) do
    ~L"""
    <h1>Welcome to Turbo Counter! </h1>
    <h2>If you dream it, we can count it!<h2>
    <p>Count: <%= @counters["1"] %>
      <button phx-click="inc">Inc</button> |
      <button phx-click="dec">Dec</button>
    </p>
    """
  end

  defp count(socket) do
    assign(socket, counters: Counters.inc(socket.assigns.counters, "1"))
  end

  defp dec(socket) do
    assign(socket, counters: Counters.dec(socket.assigns.counters, "1"))
  end

  def handle_info(:tick, socket) do
    {:noreply, count(socket)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, count(socket)}
  end

  def handle_event("dec", _, socket) do
    {:noreply, dec(socket)}
  end
end
