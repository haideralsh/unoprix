open Measurement

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

let toGallons = (volume, ~from) => {
  switch from {
  | "fl oz" => volume /. 128.0
  | _ => volume
  }
}

let toFoot = (length, ~from) => {
  switch from {
  | "in" => length /. 12.0
  | _ => length
  }
}

let toPounds = (weight, ~from) => {
  switch from {
  | "oz" => weight /. 16.0
  | _ => weight
  }
}

let toEach = (quantity, ~from) => {
  switch from {
  | "doz" => quantity *. 12.0
  | _ => quantity
  }
}

let toBase = (value, ~from, ~system, ~measurement) =>
  switch (system, measurement) {
  | (Metric, #weight) => value->toGrams(~from)
  | (Metric, #volume) => value->toLiters(~from)
  | (Metric, #length) => value->toMeters(~from)

  | (Imperial, #weight) => value->toPounds(~from)
  | (Imperial, #volume) => value->toGallons(~from)
  | (Imperial, #length) => value->toFoot(~from)

  | (_, #quantity) => value->toEach(~from)

  | _ => 0.0
  }
