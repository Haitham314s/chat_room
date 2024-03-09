defmodule ElixirGistWeb.GistLive do
  use ElixirGistWeb, :live_view

  alias ElixirGist.Gists
  alias ElixirGist.Accounts

  alias ElixirGistWeb.GistsFormComponent

  def mount(%{"id" => id}, %{"user_token" => user_token}, socket) do
    current_user = Accounts.get_user_by_session_token(user_token)
    gist = Gists.get_gist!(id)

    gist_form =
      gist
      |> Gists.change_gist()
      |> to_form()

    {:ok, relative_time} = Timex.format(gist.updated_at, "{relative}", :relative)
    gist = Map.put(gist, :relative_time, relative_time)

    socket = assign(socket, current_user: current_user, gist: gist, form: gist_form)

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
