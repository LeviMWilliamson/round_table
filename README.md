# RoundTable

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Development Database Setup

To install PostgreSQL, visit the [downloads page](https://www.postgresql.org/download/), select your operating system, and follow the provided instructions. After installation, configuration instructions for creating a development environment are provided below.

### 1. Modify access permissions.
The Postgres `pg_hba.conf` file configures access control for your database. It which hosts can access Postgres and specifies the authentication protocol they must use. To find the location of the configuration file, use the following commands:
```sh
sudo -i -u postgres
psql
```
```sql
SHOW config_file;
SHOW hba_file;
```

Copy the path displayed by the first `SHOW` command, and modify the file with elevated permissions:
```sh
sudo vim $CONFIG_FILE_PATH
```
Change the line: `#password_encryption = md5` to `password_encryption = scram-sha-256`.

Copy the path displayed by the second `SHOW` command, and modify the file with elevated permissions:
```sh
sudo vim $HBA_FILE_PATH
```

To understand this file, please read the [PostgreSQL documentation](https://www.postgresql.org/docs/current/auth-pg-hba-conf.html). Change the authentication method from `peer` to `scram-sha-256` on all lines except for the administrative login (shown on the first line).

### 2. Restart the database.
```sh
sudo service postgresql restart
```

### 3. Create a Postgres role for your application and its database.
```sh
sudo -i -u postgres
psql
```
```sql
CREATE USER round_table_dev CREATEDB PASSWORD 'round_table_dev';
```

### Troubleshooting

#### Changing the encryption scheme:
PostgreSQL defaults to using `md5` as the login encryption method. Once you change the encryption method to `scram-sha-256`, you will have to alter the passwords for all existing users in order to allow them to login. This will bite you if you followed the previous steps out of order, or are using an existing database user.

#### Creating roles:
Make sure you use `CREATE USER` to create your database role, or add the `LOGIN` privilege when using the `CREATE ROLE` command.

#### Adding missing extensions:
Phoenix's authentication module uses the `citext` PostgreSQL extension. If you run into issues related to this extension while running migrations, you may need to add superuser privileges to your database user:
```sh
sudo -i -u postgres
psql
```
```sql
ALTER USER round_table_dev WITH SUPERUSER;
```
Then run your migrations again.
