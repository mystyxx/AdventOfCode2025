let ind_max (line: string)  = 
    let rec helper (line: string) (cur: int) (ind_acc: int) = 
        if cur >= String.length line then ind_acc
        else 
            if line.[ind_acc] >= line.[cur] then 
                helper line (cur + 1) ind_acc
            else
                helper line (cur + 1) cur
    in helper line 0 0

(*

let rec max_joltage (line: string) (nb_digits: int) = 
    if nb_digits = 0 then ""
    else 
        let ind_digit = ind_max (String.sub line 0 (String.length line - nb_digits - 1)) in
        let rest = String.sub line (ind_digit + 1) (String.length line - (ind_digit + 1)) in
        (String.make 1 line.[ind_digit]) ^ max_joltage rest (nb_digits - 1)
*)



let rec max_joltage (line : string) (nb_digits : int) =
  if nb_digits = 0 then ""
  else
    let prefix =
      if String.length line - (nb_digits - 1) <= 0 then line
      else String.sub line 0 (String.length line - (nb_digits - 1))
    in
    let ind = ind_max prefix in
    (String.make 1 line.[ind]) ^ max_joltage
       (String.sub line (ind + 1) (String.length line - ind - 1))
      (nb_digits - 1)






let rec solve (input: string) (nb_digits: int) = 
    let lines = String.split_on_char '\n' input in
    let maximums = List.map (fun a -> int_of_string(max_joltage a nb_digits)) lines in
    List.fold_left (+) 0 maximums
