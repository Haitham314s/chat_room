defmodule ElixirGistWeb.ListGistLive do
  use ElixirGistWeb, :live_view

  alias ElixirGist.Gists
  alias ElixirGist.Accounts

  alias ElixirGistWeb.GistItemComponent
  alias ElixirGistWeb.PaginationComponent

  @page 0
  @limit 100

  def mount(params, %{"user_token" => user_token}, socket) do
    page = if not is_nil(params["page"]), do: String.to_integer(params["page"]), else: @page
    limit = if not is_nil(params["limit"]), do: String.to_integer(params["limit"]), else: @limit
    user_id = if is_not_empty?(params["user_id"]), do: params["user_id"], else: nil

    current_user = Accounts.get_user_by_session_token(user_token)

    gists =
      if is_not_empty?(user_id),
        do: Gists.list_gists(page, limit, user_id),
        else: Gists.list_gists(page, limit)

    total = Gists.list_gists_count()

    socket =
      assign(socket,
        current_user: current_user,
        gists: gists,
        total: total,
        page: page,
        limit: limit
      )

    {:ok, socket, temporary_assigns: [gists: []]}
  end

  def handle_params(%{"page" => page, "limit" => limit, "user_id" => user_id}, _uri, socket) do
    page = String.to_integer(page)
    limit = String.to_integer(limit)

    gists =
      if is_not_empty?(user_id),
        do: Gists.list_gists(page, limit, user_id),
        else: Gists.list_gists(page, limit)

    socket = assign(socket, page: page, limit: limit, gists: gists)
    {:noreply, socket}
  end

  def handle_params(_, _uri, socket), do: {:noreply, socket}

  defp is_not_empty?(text), do: not is_nil(text) and String.trim(text) != ""

  def handle_event("previous", _, socket) do
    page = socket.assigns.page

    if page == 0 do
      {:noreply, socket}
    else
      socket =
        socket
        |> assign(page: page - 1)
        |> update_params()

      {:noreply, socket}
    end
  end

  def handle_event("next", _, socket) do
    page = socket.assigns.page

    socket =
      socket
      |> assign(page: page + 1)
      |> update_params()

    {:noreply, socket}
  end

  def handle_event("page", %{"page" => page}, socket) do
    socket =
      socket
      |> assign(page: page)
      |> update_params()

    {:noreply, socket}
  end

  defp update_params(socket) do
    params = [
      page: socket.assigns.page,
      limit: socket.assigns.limit,
      user_id: socket.assigns.user_id
    ]

    push_patch(socket, to: ~p"/gists?#{params}")
  end
end
