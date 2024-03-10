import Config

# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix assets.deploy` task,
# which you should run after static files are built and
# before starting your production server.
config :elixir_gist, ElixirGistWeb.Endpoint,
  url: [host: "https://elixir-gist.gigalixirapp.com/", scheme: "https", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  check_origin: ["https://elixir-gist.gigalixirapp.com/"],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: ElixirGist.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
