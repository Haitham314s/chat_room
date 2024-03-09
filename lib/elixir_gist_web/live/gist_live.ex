defmodule ElixirGistWeb.GistLive do
  use ElixirGistWeb, :live_view

  alias ElixirGist.Gists
  alias ElixirGist.Accounts

  def mount(%{"id" => id}, %{"user_token" => user_token}, socket) do
    current_user = Accounts.get_user_by_session_token(user_token)
    gist = Gists.get_gist!(id)

    socket = assign(socket, current_user: current_user, gist: gist)

    {:ok, socket}
  end
end
