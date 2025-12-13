
let is_in_range (n: int) (start: int) (finish: int) = 
  n >= start && n <= finish

let rec is_fresh (fresh: int list) (available: int) = match fresh with 
    | [] -> 0
    | f1 :: f2 :: fs -> if (is_in_range available f1 f2) = true
        then 1 
        else is_fresh fs available 

let count_fresh_ids (fresh: int list) (available: int list) = 
    let rec helper (fresh: int list) (available: int list) (acc: int) = match available with
        | [] -> acc
        | x :: xs -> helper fresh xs (acc + is_fresh fresh x)
    in helper fresh available 0

let parse_range line =
  let parts = String.split_on_char '-' line in
  let a = List.hd parts in
  let b = List.hd (List.tl parts) in
  [int_of_string a; int_of_string b]

let rec result (range: string) (available: string) =
  let fresh = (List.map parse_range (String.split_on_char '\n' range))
  in let ingredients = List.map int_of_string (List.map String.trim (String.split_on_char '\n' available))
  in count_fresh_ids (List.flatten fresh) ingredients

