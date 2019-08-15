# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TodoApi.Repo.insert!(%TodoApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias TodoApi.Repo
alias TodoApi.Directory.Todo
Repo.insert! %Todo{name: "Milk", description: "get milk", priority: 1}
Repo.insert! %Todo{name: "Clean", description: "clean house", priority: 2}
Repo.insert! %Todo{name: "read", description: "read effective Java", priority: 3}
