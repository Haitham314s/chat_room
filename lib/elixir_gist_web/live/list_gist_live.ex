defmodule ElixirGistWeb.ListGistLive do
  use ElixirGistWeb, :live_view

  alias ElixirGist.Gists
  alias ElixirGist.Accounts

  alias ElixirGistWeb.GistItemComponent
  alias ElixirGistWeb.PaginationComponent

  @page 0
  @limit 1

  def mount(_params, %{"user_token" => user_token}, socket) do
    current_user = Accounts.get_user_by_session_token(user_token)
    gists = Gists.list_gists()
    total = Gists.list_gists_count()

    socket =
      assign(socket,
        current_user: current_user,
        gists: gists,
        total: total,
        page: @page,
        limit: @limit
      )

    {:ok, socket, temporary_assigns: [gists: []]}
  end

  def handle_params(%{"page" => page, "limit" => limit}, _uri, socket) do
    page = String.to_integer(page)
    limit = String.to_integer(limit)

    socket = assign(socket, page: page, limit: limit)
    {:noreply, socket}
  end

  def handle_params(_, _uri, socket), do: {:noreply, socket}

  def handle_event("previous", _, socket) do
    page = socket.assigns.page

    if page == 0 do
      {:noreply, socket}
    else
      socket = update_params(socket, page - 1)
      {:noreply, socket}
    end
  end

  def handle_event("next", _, socket) do
    page = socket.assigns.page
    socket = update_params(socket, page + 1)
    {:noreply, socket}
  end

  def handle_event("page", %{"page" => page}, socket) do
    socket = update_params(socket, page)
    {:noreply, socket}
  end

  defp update_params(socket, page, limit \\ @limit) do
    params = [page: page, limit: limit]
    push_patch(socket, to: ~p"/gists?#{params}")
  end
end
