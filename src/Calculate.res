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
  let parsedTotalPrice = Parse.floatOfString(totalPrice)
  let parsedTotalMeasurement = Parse.floatOfString(totalMeasurement)
  let parsedUnitMeasurement = Parse.floatOfString(unitMeasurement)

  let (convertedTotalMeasurement, convertedUnitMeasurement) = switch (system, measurement) {
  | (Metric, #weight) => (
      parsedTotalMeasurement->Convert.toGrams(~from=totalMeasurementUom),
      parsedUnitMeasurement->Convert.toGrams(~from=unitMeasurementUom),
    )
  | (Metric, #volume) => (
      parsedTotalMeasurement->Convert.toMeters(~from=totalMeasurementUom),
      parsedUnitMeasurement->Convert.toGrams(~from=unitMeasurementUom),
    )
  | (Metric, #length) => (
      parsedTotalMeasurement->Convert.toLiters(~from=totalMeasurementUom),
      parsedUnitMeasurement->Convert.toLiters(~from=unitMeasurementUom),
    )

  | (Imperial, #weight) => (
      parsedTotalMeasurement->Convert.toPounds(~from=totalMeasurementUom),
      parsedUnitMeasurement->Convert.toPounds(~from=unitMeasurementUom),
    )
  | (Imperial, #volume) => (
      parsedTotalMeasurement->Convert.toGallons(~from=totalMeasurementUom),
      parsedUnitMeasurement->Convert.toGallons(~from=unitMeasurementUom),
    )
  | (Imperial, #length) => (
      parsedTotalMeasurement->Convert.toFoot(~from=totalMeasurementUom),
      parsedUnitMeasurement->Convert.toFoot(~from=unitMeasurementUom),
    )

  | _ => (0.0, 0.0)
  }

  switch (convertedTotalMeasurement, convertedUnitMeasurement) {
  | (0.0, _) => 0.0
  | (_, 0.0) => 0.0
  | _ => parsedTotalPrice /. (convertedTotalMeasurement /. convertedUnitMeasurement)
  }
}
