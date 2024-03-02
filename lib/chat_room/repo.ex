defmodule ChatRoom.Repo do
  use Ecto.Repo,
    otp_app: :chat_room,
    adapter: Ecto.Adapters.SQLite3
end
