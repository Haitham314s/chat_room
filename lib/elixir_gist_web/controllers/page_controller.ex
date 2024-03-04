defmodule ElixirGistWeb.PageController do
  use ElixirGistWeb, :controller

  def home(conn, _params) do
    # redirect(conn, to: "/create")

    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home)
  end
end
