defmodule ElixirGistWeb.CreateGistLive do
  use ElixirGistWeb, :live_view

  alias ElixirGist.Accounts
  alias ElixirGist.{Gists, Gists.Gist}

  def mount(_params, %{"user_token" => user_token}, socket) do
    current_user = Accounts.get_user_by_session_token(user_token)
    gist_form = to_form(Gists.change_gist(%Gist{}))

    socket =
      assign(
        socket,
        current_user: current_user,
        form: gist_form
      )

    {:ok, socket}
  end
end
