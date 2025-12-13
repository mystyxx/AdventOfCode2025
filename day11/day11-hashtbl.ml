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


let number_of_paths (device_list: (string * string list) list) = 
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
            device_list :: create_device_list xs

let result1 (input: string) = (create_device_list (String.split_on_char '\n' input)) |> number_of_paths 

(* part 2 *)

let create_device_hashtbl (device_list: (string * string list) list) =
    let table = Hashtbl.create 0 in 
    
    List.iter (fun (device, outputs) -> Hashtbl.add table device outputs) device_list;
    table

let output_list_hashtbl (device: string) (table: (string, string list) Hashtbl.t) : string list = 
    try Hashtbl.find table device
    with Not_found -> []


let rec step_from_stop_at (output: string list) (table: (string, string list) Hashtbl.t) (stop: string)  = match output with
     | [] -> []
     | x :: xs ->
            if x = stop 
                then [stop] @ step_from_stop_at xs table stop 
                else let new_outputs = (output_list_hashtbl x table) @ xs in
                step_from_stop_at new_outputs table stop 


let count_paths_dfs (start_device: string) (target_device: string) (table: (string, string list) Hashtbl.t) (must_visit: string list) =
    let rec dfs (current_device: string) (visited: string list) = 
        if List.mem current_device visited then
            0
        else if current_device = target_device 
            then if List.for_all (fun m -> List.mem m visited) must_visit = true
                then 1 else 0
        else
            let outputs = output_list_hashtbl current_device table in
            let new_visited = current_device :: visited in
            let paths = List.map (fun a -> dfs a new_visited) outputs in
            List.fold_left (+) 0 paths
    in dfs start_device []

let number_of_paths2 (table: (string, string list) Hashtbl.t) = 
    count_paths_dfs "svr" "out" table []

let result2 (input: string) =
    let device_list = create_device_list (String.split_on_char '\n' input) |> create_device_hashtbl in
    number_of_paths2 device_list
