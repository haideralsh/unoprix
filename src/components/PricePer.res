@react.component
let make = (
  ~system,
  ~measurement,
  ~totalMeasurement,
  ~totalPrice,
  ~totalMeasurementUom,
  ~unitMeasurement,
  ~unitMeasurementUom,
) => {
  let result = Calculate.costPerUnitMeasurement(
    ~system,
    ~measurement,
    ~totalMeasurement,
    ~totalPrice,
    ~totalMeasurementUom,
    ~unitMeasurement,
    ~unitMeasurementUom,
  )

  let rounded = result->Js.Float.toFixedWithPrecision(~digits=2)
  let complete = result->Js.Float.toString

  let wasRounded = Js.Float.fromString(rounded) !== result

  <div className="flex flex-col gap-1 tabular-nums">
    <div className="flex items-center justify-between">
      <span className="text-gray-500"> {React.string("=")} </span>
      <h2 className="text-2xl font-bold leading-7 text-gray-900 whitespace-nowrap">
        <span className="font-light"> {React.string("$")} </span>
        {rounded->React.string}
      </h2>
    </div>
    {switch wasRounded {
    | true => <span className="text-sm self-end text-gray-400"> {complete->React.string} </span>
    | false => React.null
    }}
  </div>
}
