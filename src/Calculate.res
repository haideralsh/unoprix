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

  let (convertedTotal, convertedUnit) = (
    parsedTotal->Convert.toBase(~system, ~measurement, ~from=totalMeasurementUom),
    parsedUnit->Convert.toBase(~system, ~measurement, ~from=unitMeasurementUom),
  )

  switch (convertedTotal, convertedUnit) {
  | (0.0, _) => 0.0
  | (_, 0.0) => 0.0
  | _ => parsedPrice /. (convertedTotal /. convertedUnit)
  }
}
