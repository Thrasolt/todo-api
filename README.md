
# Todo API with Phoenix and Elixir 


## Get started 


`echo yes | mix phx.new todo_api --no-html`

`cd todo_api`


### Setup Database

`docker run --name todo -e POSTGRES_DB=todo_api_dev -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=mysecretpassword -d -p 5432:5432 -v database:/var/lib/postgresql/data postgres`


### Connect Phoenix to DB and create DB

#### **`todo_app/config/dev.exs`**
``` elixir
use Mix.Config

# Configure your database
config :todo_api, TodoApi.Repo,
  username: "postgres",
  password: "mysecretpassword",
  database: "todo_api_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

...
```

`mix ecto.create`

### Start the Server 

`mix phx.server`

[localhost/4000](http://localhost:4000/)

### See something

#### **`todo_app/lib/todo_app_web/router.ex`**
``` elixir

defmodule TodoApiWeb.Router do
  use TodoApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TodoApiWeb do
    pipe_through :api
  end

  # Add code ----------------------------
  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", TodoApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end
  # ------------------------------------

end
```

### Create DeafaulController 

#### **`todo_app/lib/todo_app_web/controller/default_controller.ex`**
``` elixir
# New file

defmodule TodoApiWeb.DefaultController do
  use TodoApiWeb, :controller

  def index(conn, _params) do
    text conn, "TodoApi!"
  end
end
```

### Check

[localhost/4000](http://localhost:4000/)

## JSON API

`mix phx.gen.json Directory Todo todos name:string description:text priority:integer`


### DB migration

`mix ecto.migrate`

### Add Routes


#### **`todo_app/lib/todo_app_web/router.ex`**
``` elixir

defmodule TodoApiWeb.Router do
  use TodoApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

scope "/api", TodoApiWeb do
  pipe_through :api

  # Add code ----------------------------------------------
  resources "/todos", TodoController, except: [:new, :edit]
  # -------------------------------------------------------

end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", TodoApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end
end
```

### Check Routes

`mix phx.routes`

### Seed DB

#### **`todo_app/priv/repo/seeds.exs`**
``` elixir

...
# and so on) as they will fail if something goes wrong.

# add code -----------------------------------------------------------

alias TodoApi.Repo
alias TodoApi.Directory.Todo
Repo.insert! %Todo{name: "Milk", description: "get milk", priority: 1}
Repo.insert! %Todo{name: "Clean", description: "clean house", priority: 2}
Repo.insert! %Todo{name: "read", description: "read effective Java", priority: 3}

```
` mix run priv/repo/seeds.exs`

## Test API

`curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://localhost:4000/api/todos`