import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :round_table, RoundTable.Repo,
  username: "round_table_dev",
  password: "round_table_dev",
  hostname: "localhost",
  database: "round_table_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :round_table, RoundTableWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "n3RTpG4YYme1Vwm8rq88BwEaOeLRd8S4It92VCcC3iu4uOvmug0ziINlMINFql89",
  server: false

# In test we don't send emails.
config :round_table, RoundTable.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
