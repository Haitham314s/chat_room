git checkout main
git pull origin main
git push -u gigalixir main
gigalixir ps:restart
gigalixir ps
gigalixir logs -a elixir-gist
