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

  def handle_event("validate", %{"gist" => params}, socket) do
    changeset =
      %Gist{}
      |> Gists.change_gist(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  def handle_event("create", %{"gist" => params}, socket) do
    case Gists.create_gist(socket.assigns.current_user, params) do
      {:ok, _gist} ->
        changeset = Gists.change_gist(%Gist{})
        {:noreply, assign(socket, :form, to_form(changeset))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
end
