import gleam/http.{Delete, Get, Post, Put}
import gleam/string_tree
import wisp.{type Request, type Response}

pub type Todo {
  Todo(title: String, completed: Bool)
}

pub fn todos(req: Request) -> Response {
  case req.method {
    Get -> get_todos()
    Post -> post_todo(req)
    _ -> wisp.method_not_allowed([Get, Post])
  }
}

fn get_todos() -> Response {
  let html = string_tree.from_string("todos!")
  wisp.ok()
  |> wisp.html_body(html)
}

fn post_todo(_req: Request) -> Response {
  let html = string_tree.from_string("Created")
  wisp.created()
  |> wisp.html_body(html)
}

pub fn handle_todo(req: Request, id: String) -> Response {
  case req.method {
    Get -> get_todo(req, id)
    Put -> put_todo(req, id)
    Delete -> delete_todo(req, id)
    _ -> wisp.method_not_allowed([Get, Put, Delete])
  }
}

fn put_todo(_req: Request, id: String) -> Response {
  let html = string_tree.from_string("Updated todo with id " <> id)
  wisp.created()
  |> wisp.html_body(html)
}

fn delete_todo(_req: Request, id: String) -> Response {
  let html = string_tree.from_string("Deleted todo with id " <> id)
  wisp.created()
  |> wisp.html_body(html)
}

fn get_todo(_req: Request, id: String) -> Response {
  let html = string_tree.from_string("todo with id " <> id)
  wisp.ok()
  |> wisp.html_body(html)
}
