type system = Metric | Imperial

type kind = [#weight | #volume | #length | #quantity]

type config = {
  defaultValue: string,
  units: array<string>,
}

type systemConfig = {metric: config, imperial: config}

type measurementConfig = {
  weight: systemConfig,
  volume: systemConfig,
  length: systemConfig,
  quantity: config,
}

let configs = {
  weight: {
    metric: {
      defaultValue: "g",
      units: ["mg", "g", "kg"],
    },
    imperial: {
      defaultValue: "lb",
      units: ["lb", "oz"],
    },
  },
  volume: {
    metric: {
      defaultValue: "l",
      units: ["l", "ml"],
    },
    imperial: {
      defaultValue: "gal",
      units: ["gal", "fl oz"],
    },
  },
  length: {
    metric: {
      defaultValue: "m",
      units: ["mm", "cm", "m"],
    },
    imperial: {
      defaultValue: "ft",
      units: ["in", "ft"],
    },
  },
  quantity: {
    defaultValue: "item",
    units: ["item", "dozen"],
  },
}

let defaultUnitFor = (~system, ~measurement) =>
  switch (system, measurement) {
  | (Metric, #weight) => configs.weight.metric.defaultValue
  | (Metric, #volume) => configs.volume.metric.defaultValue
  | (Metric, #length) => configs.length.metric.defaultValue

  | (Imperial, #weight) => configs.weight.imperial.defaultValue
  | (Imperial, #volume) => configs.volume.imperial.defaultValue
  | (Imperial, #length) => configs.length.imperial.defaultValue

  | (_, #quantity) => configs.quantity.defaultValue

  | _ => ""
  }

let unitsFor = (~system, ~measurement) =>
  switch (system, measurement) {
  | (Metric, #weight) => configs.weight.metric.units
  | (Metric, #volume) => configs.volume.metric.units
  | (Metric, #length) => configs.length.metric.units

  | (Imperial, #weight) => configs.weight.imperial.units
  | (Imperial, #volume) => configs.volume.imperial.units
  | (Imperial, #length) => configs.length.imperial.units

  | (_, #quantity) => configs.quantity.units

  | _ => []
  }
