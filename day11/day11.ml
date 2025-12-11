let rec output_list (device: string) (device_list: (string * string list) list) = match device_list with
    | [] -> []
    | (i, o) :: xs -> if i = device then o
                      else output_list device xs

let rec step_from (device: string) (output: string list) (device_list: (string * string list) list) = match output with
     | [] -> []
     | x :: xs ->
            if x = "out" 
                then ["out"] @ step_from device xs device_list
            else let new_outputs = (output_list x device_list) @ xs in
                step_from device new_outputs device_list


let rec number_of_paths (device_list: (string * string list) list) = 
    let you_outputs = output_list "you" device_list in
    let ends = step_from "you" you_outputs device_list in
    List.length ends


let rec create_device_list (input: string list) = match input with
    | [] -> [] 
    | x :: xs -> 
            let list = String.split_on_char ':' x in
            let device_list = 
                (List.hd list, 
                String.split_on_char ' ' (List.nth list 1)) in
            [device_list] @ create_device_list xs

let result1 (input: string) = (create_device_list (String.split_on_char '\n' input)) |> number_of_paths 


