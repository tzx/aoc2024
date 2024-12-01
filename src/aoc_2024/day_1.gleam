import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn pt_1(st: String) -> Int {
  let lines = string.split(st, "\n")
  let numbers = list.map(lines, sp)
  let lefts =
    list.map(numbers, fn(nums: List(String)) {
      list.first(nums)
      |> result.lazy_unwrap(p)
      |> int.parse()
      |> result.lazy_unwrap(p)
    })
    |> list.sort(by: int.compare)
  let rights =
    list.map(numbers, fn(nums: List(String)) {
      list.last(nums)
      |> result.lazy_unwrap(p)
      |> int.parse()
      |> result.lazy_unwrap(p)
    })
    |> list.sort(by: int.compare)
  list.zip(lefts, rights)
  |> list.map(fn(nums) { int.absolute_value(nums.0 - nums.1) })
  |> list.fold(0, int.add)
}

fn sp(st: String) -> List(String) {
  string.split(st, "   ")
}

fn p() {
  panic
}

pub fn pt_2(st: String) -> Int {
  let lines = string.split(st, "\n")
  let numbers = list.map(lines, sp)
  let lefts =
    list.map(numbers, fn(nums: List(String)) {
      list.first(nums)
      |> result.lazy_unwrap(p)
      |> int.parse()
      |> result.lazy_unwrap(p)
    })
    |> list.sort(by: int.compare)
  let rights =
    list.map(numbers, fn(nums: List(String)) {
      list.last(nums)
      |> result.lazy_unwrap(p)
      |> int.parse()
      |> result.lazy_unwrap(p)
    })
    |> list.sort(by: int.compare)

  list.map(lefts, fn(n) { n * list.count(rights, fn(x) { x == n }) })
  |> int.sum()
}
