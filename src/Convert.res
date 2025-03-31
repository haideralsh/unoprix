open Measurement

let toGrams = (weight, ~from) =>
  switch from {
  | "kg" => weight *. 1000.0
  | "mg" => weight /. 1000.0
  | "g"  => weight
  | "lb" => weight *. 453.59237
  | "oz" => weight *. 28.3495231
  | _ => weight
  }

let toLiters = (volume, ~from) =>
  switch from {
  | "l"    => volume
  | "ml"   => volume /. 1000.0
  | "gal"  => volume *. 3.78541
  | "fl oz" => volume *. 0.0295735
  | _ => volume
  }

let toMeters = (length, ~from) =>
  switch from {
  | "m"  => length
  | "mm" => length /. 1000.0
  | "cm" => length /. 100.0
  | "ft" => length *. 0.3048
  | "in" => length *. 0.0254
  | _ => length
  }

let toPounds = (weight, ~from) =>
  switch from {
  | "lb" => weight
  | "oz" => weight /. 16.0
  | "kg" => weight /. 0.45359237
  | "mg" => weight /. (453.59237 *. 1000.0)
  | "g"  => weight /. 453.59237
  | _ => weight
  }

let toGallons = (volume, ~from) =>
  switch from {
  | "gal"   => volume
  | "fl oz" => volume /. 128.0
  | "l"     => volume /. 3.78541
  | "ml"    => volume /. (3.78541 *. 1000.0)
  | _ => volume
  }

let toFoot = (length, ~from) =>
  switch from {
  | "ft" => length
  | "in" => length /. 12.0
  | "m"  => length /. 0.3048
  | "mm" => (length /. 1000.0) /. 0.3048
  | "cm" => (length /. 100.0) /. 0.3048
  | _ => length
  }

let toEach = (quantity, ~from) =>
  switch from {
  | "doz" => quantity *. 12.0
  | "ea"  => quantity
  | _ => quantity
  }

let toBase = (value, ~from, ~system, ~measurement) =>
  switch (system, measurement) {
  | (Metric, #weight) => value->toGrams(~from)
  | (Imperial, #weight) => value->toPounds(~from)
  | (Both, #weight) => value->toGrams(~from)

  | (Metric, #volume) => value->toLiters(~from)
  | (Imperial, #volume) => value->toGallons(~from)
  | (Both, #volume) => value->toLiters(~from)

  | (Metric, #length) => value->toMeters(~from)
  | (Imperial, #length) => value->toFoot(~from)
  | (Both, #length) => value->toMeters(~from)

  | (_, #quantity) => value->toEach(~from)
  | _ => 0.0
  }
