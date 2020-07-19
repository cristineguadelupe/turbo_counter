defmodule TurboCounterWeb.CountLive do
  use TurboCounterWeb, :live_view
  alias TurboCounter.Counters

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> new
    }
  end

  defp new(socket) do
    assign(socket, counters: Counters.new())
  end

  def render(assigns) do
    ~L"""
    <h1>Welcome to Turbo Counter! </h1>
    <h2>If you dream it, we can count it!<h2>
    <hr>
    <%= for {name, count} <- @counters do %>
      <p>Count <%= name %>: <%= count %>
        <button phx-click="inc" phx-value-counter="<%= name %>">Inc</button> |
        <button phx-click="dec" phx-value-counter="<%= name %>">Dec</button> |
        <button phx-click="clear"phx-value-counter="<%= name %>">Clear</button>
      </p>
    <% end %>
    <hr>
    <button phx-click="add">Add a counter</button>
    """
  end

  defp add(socket) do
    assign(socket, counters: Counters.add_counter(socket.assigns.counters))
  end
  defp inc(socket, counter) do
    assign(socket, counters: Counters.inc(socket.assigns.counters, counter))
  end

  defp dec(socket, counter) do
    assign(socket, counters: Counters.dec(socket.assigns.counters, counter))
  end

  defp clear(socket, counter) do
    assign(socket, counters: Counters.clear(socket.assigns.counters, counter))
  end

  def handle_event("add", _, socket) do
    {:noreply, add(socket)}
  end

  def handle_event("inc", %{"counter" => counter}, socket) do
    {:noreply, inc(socket, counter)}
  end

  def handle_event("dec", %{"counter" => counter}, socket) do
    {:noreply, dec(socket, counter)}
  end

  def handle_event("clear", %{"counter" => counter}, socket) do
    {:noreply, clear(socket, counter)}
  end

end
