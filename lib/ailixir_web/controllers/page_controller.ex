defmodule AilixirWeb.PageController do
  use AilixirWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
