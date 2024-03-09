defmodule ElixirGistWeb.GistsFormComponent do
  use ElixirGistWeb, :live_component

  alias ElixirGist.{Gists, Gists.Gist}

  def mount(socket) do
    gist_form =
      if Map.has_key?(socket.assigns, :form) do
        socket.assigns.form
      else
        to_form(Gists.change_gist(%Gist{}))
      end

    socket = assign(socket, form: gist_form)
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
      {:ok, gist} ->
        socket = push_event(socket, "clear-textareas", %{})
        changeset = Gists.change_gist(%Gist{})

        socket = assign(socket, :form, to_form(changeset))
        {:noreply, push_navigate(socket, to: ~p"/gist?#{[id: gist]}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
end
