import gleam/dict
import gleam/function
import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn parse_pair(p: #(a, a), f: fn(a) -> Result(b, c)) -> Result(#(b, b), c) {
  use a <- result.try(f(p.0))
  use b <- result.try(f(p.1))
  Ok(#(a, b))
}

pub fn parse(st: String) -> #(List(Int), List(Int)) {
  let assert Ok(pairs) =
    st
    |> string.split("\n")
    |> list.try_map(fn(s) {
      string.split_once(s, "   ")
      |> result.try(parse_pair(_, int.parse))
    })
  list.unzip(pairs)
}

pub fn pt_1(input: #(List(Int), List(Int))) -> Int {
  let pairs = #(
    list.sort(input.0, int.compare),
    list.sort(input.1, int.compare),
  )
  list.zip(pairs.0, pairs.1)
  |> list.map(fn(p) { int.absolute_value(p.0 - p.1) })
  |> list.fold(0, int.add)
}

pub fn pt_2(input: #(List(Int), List(Int))) -> Int {
  // let #(left, right) = input
  // left
  // |> list.map(fn(n) { n * list.count(right, fn(x) { x == n }) })
  // |> int.sum
  // Optimized here, 1 time count
  let #(left, right) = input
  let cntr =
    list.group(right, function.identity)
    |> dict.map_values(fn(_, b) { list.length(b) })

  left
  |> list.map(fn(x) { x * { dict.get(cntr, x) |> result.unwrap(0) } })
  |> int.sum
}
