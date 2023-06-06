type system = Metric | Imperial

type measurment = [#weight | #volume | #length]

type config = {
  defaultValue: string,
  units: array<string>,
}

type measurements = {weight: config, volume: config, length: config}

type systemMeasurements = {m: measurements, i: measurements}

let systemMeasurements = {
  m: {
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
  },
  i: {
    weight: {
      defaultValue: "lb",
      units: ["lb", "oz"],
    },
    volume: {
      defaultValue: "gal",
      units: ["gal", "fl oz"],
    },
    length: {
      defaultValue: "ft",
      units: ["in", "ft", "mi"],
    },
  },
}

let defaultUnitFor = (~system, ~measurement) =>
  switch (system, measurement) {
  | (Metric, #weight) => systemMeasurements.m.weight.defaultValue
  | (Metric, #volume) => systemMeasurements.m.volume.defaultValue
  | (Metric, #length) => systemMeasurements.m.length.defaultValue

  | (Imperial, #weight) => systemMeasurements.i.weight.defaultValue
  | (Imperial, #volume) => systemMeasurements.i.volume.defaultValue
  | (Imperial, #length) => systemMeasurements.i.length.defaultValue

  | _ => ""
  }

let unitsFor = (~system, ~measurement) =>
  switch (system, measurement) {
  | (Metric, #weight) => systemMeasurements.m.weight.units
  | (Metric, #volume) => systemMeasurements.m.volume.units
  | (Metric, #length) => systemMeasurements.m.length.units

  | (Imperial, #weight) => systemMeasurements.i.weight.units
  | (Imperial, #volume) => systemMeasurements.i.volume.units
  | (Imperial, #length) => systemMeasurements.i.length.units

  | _ => []
  }
