let toGrams = (weight, ~from) => {
  switch from {
  | "kg" => weight *. 1000.0
  | "mg" => weight /. 1000.0
  | _ => weight
  }
}

let toLiters = (volume, ~from) => {
  switch from {
  | "ml" => volume /. 1000.0
  | _ => volume
  }
}

let toMeters = (length, ~from) => {
  switch from {
  | "mm" => length /. 1000.0
  | "cm" => length /. 100.0
  | _ => length
  }
}
