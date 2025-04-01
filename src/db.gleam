import gleam/dynamic/decode
import gleam/option
import pog

pub fn connect_to_db() -> pog.Connection {
  let _ =
    pog.default_config()
    |> pog.host("localhost")
    |> pog.database("postgres")
    |> pog.user("postgres")
    |> pog.password(option.Some("postgres"))
    |> pog.pool_size(15)
    |> pog.connect
}

pub fn create_todo_table(
  connection: pog.Connection,
) -> Result(pog.Returned(Nil), pog.QueryError) {
  let sql_query =
    "
  create table todos (
    id serial primary key,
    title text not null,
    completed boolean not null
  )"
  pog.query(sql_query)
  |> pog.execute(connection)
}

pub fn create_todo_decoder() -> decode.Decoder(#(Int, String, Bool)) {
  let _ = {
    use id <- decode.field(0, decode.int)
    use title <- decode.field(1, decode.string)
    use completed <- decode.field(2, decode.bool)
    decode.success(#(id, title, completed))
  }
}
