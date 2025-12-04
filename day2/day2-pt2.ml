let is_invalid (s: string) (n: int) = 
    (* n est le nombre de fois qu'est répété le patterne *)
    if (String.length s) mod n <> 0 then "0" 
    else
        let half = String.length s / n in
        let rec check i =
            if i == n then true
            else
                if compare (String.sub s 0 half) (String.sub s (half * i) half) == 0 
                then check (i + 1) else false 
        in if (check 1) == true then s else "0"

let rec range_list (start: int) (finish: int) = 
    if start == finish then [finish]
    else start :: range_list (start + 1) finish

let rec sum_invalid_ids (ids: int list) (n: int) = match ids with
    | [] -> 0
    | x :: xs -> ((is_invalid (string_of_int x) n) |> int_of_string) + sum_invalid_ids xs n

(* une fonction qui détermine le plus petit n possible*)
let smallest_invalid_n (s: string) = 
    let rec helper (s: string) (n: int) = 
        if n > String.length s then (String.length s) + 1
        else if (is_invalid s n) <> "0"
        then (*c'est le plus grand*) n
        else helper s (n + 1)
    in helper s 2

(* une fonction à qui on donne les id invalide et qui fait la somme en utilisant le plus petit n possible *)
let rec sum_invalid_ids_pt2 (s: int list) = match s with
    | [] -> 0
    | x :: xs -> (int_of_string (is_invalid (string_of_int x) (smallest_invalid_n (string_of_int x))))
    + sum_invalid_ids_pt2 xs


let rec my_parser (input: string list) = match input with
    | [""] -> 0
    | x :: xs -> 
            let range = (String.split_on_char '-' x) in
            sum_invalid_ids_pt2 (
                range_list (int_of_string (String.trim (List.nth range 0))) (int_of_string (String.trim (List.nth range 1))))
            + my_parser xs
    | _ -> 0

let rec result (input: string) = my_parser (String.split_on_char ',' input)
