defmodule ElixirGistWeb.PaginationComponent do
  use ElixirGistWeb, :live_component

  @page_set 5

  def update(assigns, socket) do
    socket = assign(socket, assigns)
    total_pages = div(socket.assigns.total, socket.assigns.limit) - 1
    pages = get_filtered_pages(total_pages, socket.assigns.page)

    {:ok, assign(socket, pages: pages, total_pages: total_pages)}
  end

  defp get_filtered_pages(total_pages, page) do
    IO.inspect("total_pages: #{total_pages}, page: #{page}", label: "Pagination")
    half_page = div(@page_set, 2)

    start_page =
      cond do
        total_pages - half_page < page and total_pages - @page_set + 1 >= 0 ->
          total_pages - @page_set + 1

        page - half_page >= 0 ->
          page - half_page

        true ->
          0
      end

    end_page =
      cond do
        page < half_page and @page_set - 1 <= total_pages ->
          @page_set - 1

        page + half_page <= total_pages ->
          page + half_page

        true ->
          total_pages
      end

    if end_page <= 0 do
      [start_page]
    else
      start_page..end_page
    end
  end
end
