import gleam/erlang/process
import mist
import wisp
import wisp/wisp_mist

import app/router
import db

pub fn main() {
  wisp.configure_logger()

  let secret_key: String = wisp.random_string(64)

  let assert Ok(_) =
    wisp_mist.handler(router.handle_request, secret_key)
    |> mist.new
    |> mist.port(8080)
    |> mist.start_http

  let connection = db.connect_to_db()
  case db.create_todo_table(connection) {
    Ok(_) -> wisp.log_info("Created todos table")
    Error(_) -> wisp.log_error("Failed to create todos table")
  }

  process.sleep_forever()
}
