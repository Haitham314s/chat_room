defmodule ElixirGistWeb.CreateGistLive do
  use ElixirGistWeb, :live_view

  alias ElixirGist.Accounts
  alias ElixirGistWeb.GistsFormComponent

  def mount(_params, %{"user_token" => user_token}, socket) do
    current_user = Accounts.get_user_by_session_token(user_token)

    socket = assign(socket, current_user: current_user)
    {:ok, socket}
  end
end
