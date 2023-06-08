type system = Metric | Imperial

type kind = [#weight | #volume | #length]

type config = {
  defaultValue: string,
  units: array<string>,
}

type measurements = {weight: config, volume: config, length: config}

type systemMeasurements = {metric: measurements, imperial: measurements}

let systemMeasurements = {
  metric: {
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
  imperial: {
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
      units: ["in", "ft"],
    },
  },
}

let defaultUnitFor = (~system, ~measurement) =>
  switch (system, measurement) {
  | (Metric, #weight) => systemMeasurements.metric.weight.defaultValue
  | (Metric, #volume) => systemMeasurements.metric.volume.defaultValue
  | (Metric, #length) => systemMeasurements.metric.length.defaultValue

  | (Imperial, #weight) => systemMeasurements.imperial.weight.defaultValue
  | (Imperial, #volume) => systemMeasurements.imperial.volume.defaultValue
  | (Imperial, #length) => systemMeasurements.imperial.length.defaultValue

  | _ => ""
  }

let unitsFor = (~system, ~measurement) =>
  switch (system, measurement) {
  | (Metric, #weight) => systemMeasurements.metric.weight.units
  | (Metric, #volume) => systemMeasurements.metric.volume.units
  | (Metric, #length) => systemMeasurements.metric.length.units

  | (Imperial, #weight) => systemMeasurements.imperial.weight.units
  | (Imperial, #volume) => systemMeasurements.imperial.volume.units
  | (Imperial, #length) => systemMeasurements.imperial.length.units

  | _ => []
  }
