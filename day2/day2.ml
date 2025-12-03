let is_invalid (s: string) = 
    if (String.length s) mod 2 == 1 then "0" 
    else
        let half = String.length s / 2 in
        let is_eq = compare (String.sub s 0 half) (String.sub s half half) in
        if is_eq == 0 then s else "0"

let rec range_list (start: int) (finish: int) = 
    if start == finish then [finish]
    else start :: range_list (start + 1) finish

let rec sum_invalid_ids (ids: int list) = match ids with
    | [] -> 0
    | x :: xs -> (is_invalid (string_of_int x) |> int_of_string) + sum_invalid_ids xs

let rec my_parser (input: string list) = match input with
    | [""] -> 0
    | x :: xs -> 
            let range = (String.split_on_char '-' x) in
            sum_invalid_ids(
                range_list (int_of_string (String.trim (List.nth range 0))) (int_of_string (String.trim (List.nth range 1))))
            + my_parser xs
    | _ -> 0

let rec result (input: string) = my_parser (String.split_on_char ',' input)
