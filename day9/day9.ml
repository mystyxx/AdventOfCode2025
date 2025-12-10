let calc_rec_area (x1: int) (y1: int) (x2: int) (y2: int) = 
    (Int.abs (x1 - x2) + 1) * (Int.abs (y1 - y2) + 1)

let rec largest_rec_area_from_coord (coord: int list) (tiles: int list list) (acc: int) = match tiles with
    | [] -> acc
    | [x; y] :: xs -> 
            let area = calc_rec_area (List.hd coord) (List.nth coord 1) x y in
            if acc < area
                then largest_rec_area_from_coord coord xs area
                else largest_rec_area_from_coord coord xs acc
    | _ -> acc



let largest_rec_area (tiles: int list list) = 
    (* on veut mapper chaque tuile à l'aire de son + grand rectangle
       et ensuite folder pour avec le + grand des + grands rectangles*)
    let rectangles = List.map (fun a -> largest_rec_area_from_coord a tiles 0) tiles in
    List.fold_left max 0 rectangles

let rec create_coord_list (input: string list) = match input with
    | [] -> [] 
    | x :: xs -> 
            let coord = String.split_on_char ',' x in
            List.map int_of_string coord :: create_coord_list xs

let result (input: string) = (create_coord_list (String.split_on_char '\n' input)) |> largest_rec_area
