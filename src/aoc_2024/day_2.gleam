import gleam/int
import gleam/list
import gleam/string

pub fn parse(st: String) -> List(List(Int)) {
  st
  |> string.split("\n")
  |> list.map(fn(s) { string.split(s, " ") |> list.filter_map(int.parse) })
}

pub fn pt_1(input: List(List(Int))) -> Int {
  // LOL just realized there is window_by_2
  input
  |> list.filter(fn(l) {
    { valid_increasing(l) || valid_decreasing(l) } && safe_line(l)
  })
  |> list.length
}

pub fn pt_2(input: List(List(Int))) -> Int {
  input
  |> list.filter(fn(l) { list.any(one_dropped(l), safe) })
  |> list.length
}

fn safe(l: List(Int)) -> Bool {
  { valid_increasing(l) || valid_decreasing(l) } && safe_line(l)
}

fn valid_increasing(line: List(Int)) -> Bool {
  case line {
    [a, b, ..] -> a > b && valid_increasing(list.drop(line, 1))
    _ -> True
  }
}

fn valid_decreasing(line: List(Int)) -> Bool {
  case line {
    [a, b, ..] -> a < b && valid_decreasing(list.drop(line, 1))
    _ -> True
  }
}

fn safe_line(line: List(Int)) -> Bool {
  case line {
    [a, b, ..] -> {
      let diff = int.absolute_value(a - b)
      diff <= 3 && diff >= 1 && safe_line(list.drop(line, 1))
    }
    _ -> True
  }
}

fn one_dropped(line: List(Int)) -> List(List(Int)) {
  let idxs = list.range(0, list.length(line) - 1)
  idxs |> list.map(one_dropped_helper(_, line))
}

fn one_dropped_helper(idx: Int, line: List(Int)) -> List(Int) {
  list.take(line, idx) |> list.append(list.drop(line, idx + 1))
}
