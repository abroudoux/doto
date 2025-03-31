import gleam/http.{Get}
import gleam/string_tree
import wisp.{type Request, type Response}

import app/todos
import app/web

pub fn handle_request(req: Request) -> Response {
  use req <- web.middleware(req)
  case wisp.path_segments(req) {
    [] -> home_page(req)
    ["todos"] -> todos.todos(req)
    ["todos", id] -> todos.handle_todo(req, id)
    _ -> wisp.not_found()
  }
}

fn home_page(req: Request) -> Response {
  use <- wisp.require_method(req, Get)
  let html = string_tree.from_string("Hello wisp!")

  wisp.ok()
  |> wisp.html_body(html)
}
