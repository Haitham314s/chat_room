defmodule ElixirGistWeb.CreateGistLive do
  alias ElixirGist.Accounts
  use ElixirGistWeb, :live_view

  def mount(_params, %{"user_token" => user_token}, socket) do
    socket = assign(socket, current_user: Accounts.get_user_by_session_token(user_token))
    {:ok, socket}
  end
end
