open Measurement

let costPerUnitMeasurement = (
  ~system,
  ~measurement,
  ~totalMeasurement,
  ~totalPrice,
  ~totalMeasurementUom,
  ~unitMeasurement,
  ~unitMeasurementUom,
) => {
  let parsedPrice = totalPrice->Utils.String.stripCommas->Utils.Float.fromString

  let parsedTotal = totalMeasurement->Utils.String.stripCommas->Utils.Float.fromString
  let parsedUnit = unitMeasurement->Utils.String.stripCommas->Utils.Float.fromString

  let (convertedTotal, convertedUnit) = switch (system, measurement) {
  | (Metric, #weight) => (
      parsedTotal->Convert.toGrams(~from=totalMeasurementUom),
      parsedUnit->Convert.toGrams(~from=unitMeasurementUom),
    )
  | (Metric, #volume) => (
      parsedTotal->Convert.toMeters(~from=totalMeasurementUom),
      parsedUnit->Convert.toGrams(~from=unitMeasurementUom),
    )
  | (Metric, #length) => (
      parsedTotal->Convert.toLiters(~from=totalMeasurementUom),
      parsedUnit->Convert.toLiters(~from=unitMeasurementUom),
    )

  | (Imperial, #weight) => (
      parsedTotal->Convert.toPounds(~from=totalMeasurementUom),
      parsedUnit->Convert.toPounds(~from=unitMeasurementUom),
    )
  | (Imperial, #volume) => (
      parsedTotal->Convert.toGallons(~from=totalMeasurementUom),
      parsedUnit->Convert.toGallons(~from=unitMeasurementUom),
    )
  | (Imperial, #length) => (
      parsedTotal->Convert.toFoot(~from=totalMeasurementUom),
      parsedUnit->Convert.toFoot(~from=unitMeasurementUom),
    )
  | (_, #quantity) => (
      parsedTotal->Convert.toEach(~from=totalMeasurementUom),
      parsedUnit->Convert.toEach(~from=unitMeasurementUom),
    )

  | _ => (0.0, 0.0)
  }

  switch (convertedTotal, convertedUnit) {
  | (0.0, _) => 0.0
  | (_, 0.0) => 0.0
  | _ => parsedPrice /. (convertedTotal /. convertedUnit)
  }
}
