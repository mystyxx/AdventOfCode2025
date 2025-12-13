
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


(* part 2 *)

let sort_ranges (ranges: (int * int) list) =
    List.sort (fun (a_start, a_finish) (b_start, b_finish) ->
        if a_start <> b_start
        then compare a_start b_start  
        else compare a_finish b_finish
    ) ranges

let merge_overlap_ranges (ranges: (int * int) list) = 
    let rec helper (cur: (int * int)) (ranges: (int * int) list) = match ranges with
        | [] -> [cur]
        | (start, finish) :: rest ->
            let cur_start = fst cur in
            let cur_finish = snd cur in
            if start <= cur_finish + 1 
                then let new_cur = (cur_start, (max cur_finish finish))
                in helper new_cur rest
            else
                cur :: helper (start, finish) rest
    in helper (List.hd ranges) (List.tl ranges)

let count_all_fresh_ids (fresh: (int * int) list) = 
    let rec helper (fresh: (int * int) list) (acc: int) = match fresh with
        | [] -> acc
        | (start, finish) :: xs -> helper xs (acc + finish - start + 1)
    in helper fresh 0

let rec make_pairs (lst: int list) = match lst with
    | [] -> []
    | [_] -> []
    | start :: finish :: xs -> (start, finish) :: make_pairs xs


let rec result2 (range: string) = 
    let fresh = (List.map parse_range (String.split_on_char '\n' range)) 
    |> List.flatten |> make_pairs |> sort_ranges |> merge_overlap_ranges in
    count_all_fresh_ids fresh
