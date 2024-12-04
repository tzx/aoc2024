import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/pair
import gleam/regex
import gleam/regexp.{type Match, type Regexp}
import gleam/string

pub fn pt_1(input: String) -> Int {
  let h_cnt = num_matches(input)

  let v_cnt =
    input
    |> string.split("\n")
    |> list.map(string.to_graphemes)
    |> list.transpose
    |> list.map(string.join(_, ""))
    |> string.join("\n")
    |> num_matches
    |> io.debug

  diagonals(input) |> io.debug

  todo
}

pub fn pt_2(input: String) -> Int {
  todo
}

fn num_matches(input: String) -> Int {
  let n = string.length(input)
  list.range(0, n)
  |> list.map(fn(i) { string.slice(input, i, 4) })
  |> list.filter(fn(s) { s == "XMAS" || s == "SAMX" })
  |> list.length
}

fn get_primary_diagonal(matrix: List(List(String)), index: Int) -> List(String) {
  list.range(0, list.length(matrix))
  |> list.filter(fn(i) {
    i == index
  }
  todo
}

fn get_secondary_diagonal(
  matrix: List(List(String)),
  index: Int,
) -> List(String) {
  list.filter(0.0.list.length(matrix), fn(i) {
    i == list.length(matrix) - 1 - index
  })
}
