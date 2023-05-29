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

let toFloat = stringNum => Belt.Option.getWithDefault(Belt.Float.fromString(stringNum), 0.0)

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
let calculateCostPerUnitMeasurement = (
  ~measurement,
  ~totalMeasurement,
  ~totalPrice,
  ~totalMeasurementUom,
  ~unitMeasurement,
  ~unitMeasurementUom,
) => {
  let parsedTotalPrice = toFloat(totalPrice)

  let convertedTotalMeasurement = switch measurement {
  | "weight" => toFloat(totalMeasurement)->toGrams(~from=totalMeasurementUom)
  | "length" => toFloat(totalMeasurement)->toMeters(~from=totalMeasurementUom)
  | "volume" => toFloat(totalMeasurement)->toLiters(~from=totalMeasurementUom)
  | _ => 0.0
  }

  let convertedUnitMeasurement = switch measurement {
  | "weight" => toFloat(unitMeasurement)->toGrams(~from=unitMeasurementUom)
  | "length" => toFloat(unitMeasurement)->toMeters(~from=unitMeasurementUom)
  | "volume" => toFloat(unitMeasurement)->toLiters(~from=unitMeasurementUom)
  | _ => 0.0
  }

  switch (convertedTotalMeasurement, convertedUnitMeasurement) {
  | (0.0, _) => 0.0
  | (_, 0.0) => 0.0
  | _ => parsedTotalPrice /. (convertedTotalMeasurement /. convertedUnitMeasurement)
  }
}
