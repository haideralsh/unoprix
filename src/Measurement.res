type measurment = {
  defaultValue: string,
  units: array<string>,
}

type measurements = {weight: measurment, volume: measurment, length: measurment}

let measurements = {
  weight: {
    defaultValue: "g",
    units: ["mg", "g", "kg"],
  },
  volume: {
    defaultValue: "l",
    units: ["l", "ml"],
  },
  length: {
    defaultValue: "m",
    units: ["mm", "cm", "m"],
  },
}

let uom = measurement =>
  switch measurement {
  | "weight" => measurements.weight.defaultValue
  | "volume" => measurements.volume.defaultValue
  | "length" => measurements.length.defaultValue
  | _ => ""
  }
