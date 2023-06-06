let costPerUnitMeasurement = (
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

  let (convertedTotalMeasurement, convertedUnitMeasurement) = switch measurement {
  | #weight => (
      parsedTotalMeasurement->Convert.toGrams(~from=totalMeasurementUom),
      parsedUnitMeasurement->Convert.toGrams(~from=unitMeasurementUom),
    )
  | #length => (
      parsedTotalMeasurement->Convert.toMeters(~from=totalMeasurementUom),
      parsedUnitMeasurement->Convert.toGrams(~from=unitMeasurementUom),
    )
  | #volume => (
      parsedTotalMeasurement->Convert.toLiters(~from=totalMeasurementUom),
      parsedUnitMeasurement->Convert.toLiters(~from=unitMeasurementUom),
    )
  | _ => (0.0, 0.0)
  }

  switch (convertedTotalMeasurement, convertedUnitMeasurement) {
  | (0.0, _) => 0.0
  | (_, 0.0) => 0.0
  | _ => parsedTotalPrice /. (convertedTotalMeasurement /. convertedUnitMeasurement)
  }
}
