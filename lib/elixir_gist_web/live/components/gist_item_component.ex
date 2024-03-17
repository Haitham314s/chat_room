defmodule ElixirGistWeb.GistItemComponent do
  alias ElixirGist.Gists.Gist
  use ElixirGistWeb, :live_component

  def handle_event("view", %{"id" => id}, socket) do
    {:noreply, push_navigate(socket, to: ~p"/gist?#{[id: id]}")}
  end

  def get_relative_time(%Gist{} = gist) do
    {:ok, relative_time} = Timex.format(gist.updated_at, "{relative}", :relative)
    relative_time
  end
end
