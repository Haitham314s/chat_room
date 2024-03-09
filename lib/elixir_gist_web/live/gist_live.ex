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

  def handle_event("delete", %{"id" => id}, socket) do
    case Gists.delete_gist(socket.assigns.current_user, id) do
      {:ok, _gist} ->
        socket =
          socket
          |> put_flash(:info, "Gist successfully deleted")
          |> push_navigate(to: ~p"/create")

        {:noreply, socket}

      {:error, message} ->
        socket = put_flash(socket, :error, message)
        {:noreply, socket}
    end
  end
end
