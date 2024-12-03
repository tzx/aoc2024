import gleam/int
import gleam/list
import gleam/option
import gleam/pair
import gleam/regexp.{type Match}
import gleam/string

pub fn pt_1(input: String) -> Int {
  let assert Ok(re) = regexp.from_string("mul\\((\\d+),(\\d+)\\)")
  let matches = regexp.scan(re, input)
  matches
  |> mul_matches
}

pub fn pt_2(input: String) -> Int {
  let dont = "don't\\(\\)"
  let do = "do\\(\\)"
  let mul = "mul\\((\\d+),(\\d+)\\)"
  let regex_str = string.join([dont, do, mul], "|")
  let assert Ok(re) = regexp.from_string(regex_str)
  let matches = regexp.scan(re, input)

  list.zip(matches, f(matches))
  |> list.filter(fn(x) { x.1 && !string.starts_with({ x.0 }.content, "do") })
  |> list.map(pair.first)
  |> mul_matches
}

fn mul_matches(matches: List(Match)) -> Int {
  matches
  |> list.map(fn(x) {
    x.submatches
    |> list.filter_map(option.to_result(_, "error"))
    |> list.filter_map(int.parse)
  })
  |> list.map(int.product)
  |> int.sum
}

fn f(matches: List(Match)) -> List(Bool) {
  fp(matches, True)
}

fn fp(matches: List(Match), keep: Bool) -> List(Bool) {
  let nk = new_keep(matches, keep)
  case matches {
    [] -> []
    _ -> {
      let rest = fp(list.drop(matches, 1), nk)
      [keep] |> list.append(rest)
    }
  }
}

fn new_keep(m: List(Match), keep: Bool) -> Bool {
  case m {
    [a, ..] ->
      case string.starts_with(a.content, "don't") {
        True -> False
        False -> string.starts_with(a.content, "do") || keep
      }
    _ -> keep
  }
}
