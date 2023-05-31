let unitOptions = units =>
  Belt.Array.map(units, unit => {
    <option value={unit} key={unit}> {React.string(unit)} </option>
  })

let units = measurement =>
  switch measurement {
  | "weight" => unitOptions(Measurement.measurements.weight.units)
  | "volume" => unitOptions(Measurement.measurements.volume.units)
  | "length" => unitOptions(Measurement.measurements.length.units)
  | _ => []
  }

let defaultMeasurement = "weight"

@react.component
let make = () => {
  let (measurement, setMeasurement) = React.useState(() => defaultMeasurement)
  let (totalMeasurement, setTotalMeasurement) = React.useState(() => "")
  let (totalMeasurementUom, setTotalMeasurementUom) = React.useState(() =>
    Measurement.uom(defaultMeasurement)
  )
  let (totalPrice, setTotalPrice) = React.useState(() => "")
  let (unitMeasurement, setUnitMeasurement) = React.useState(() => "")
  let (unitMeasurementUom, setUnitMeasurementUom) = React.useState(() =>
    Measurement.uom(defaultMeasurement)
  )

  React.useEffect1(() => {
    setTotalMeasurementUom(_prev => Measurement.uom(measurement))
    setUnitMeasurementUom(_prev => Measurement.uom(measurement))

    None
  }, [measurement])

  <div className="flex flex-col gap-8 p-8 max-w-sm mx-auto">
    <div className="flex justify-between">
      <h1 className="font-extrabold leading-7 text-lime-500 truncate text-3xl tracking-tight">
        {React.string("prix")}
      </h1>
      <div className="inset-y-0 right-0 flex items-center">
        <label htmlFor="unit type" className="sr-only"> {React.string("Unit type")} </label>
        <select
          value={measurement}
          onChange={e => {
            setMeasurement(ReactEvent.Form.target(e)["value"])
          }}
          id="unit-type"
          name="unit-type"
          className="h-full rounded-md border-0 bg-transparent py-2 pl-3 pr-7 text-gray-500 focus:ring-2 focus:ring-inset focus:ring-lime-600 sm:text-sm">
          <option value="weight"> {React.string("Weight")} </option>
          <option value="volume"> {React.string("Volume")} </option>
          <option value="length"> {React.string("Length")} </option>
        </select>
      </div>
    </div>
    <div className="flex flex-col gap-6">
      <div>
        <label
          htmlFor="total-weight"
          className="block text-sm leading-6 text-gray-500 font-medium uppercase">
          {React.string(`Total ${measurement}`)}
        </label>
        <div className="relative mt-1 rounded-md">
          <input
            value={totalMeasurement}
            onChange={e => {
              setTotalMeasurement(ReactEvent.Form.target(e)["value"])
            }}
            type_="number"
            name="total-weight"
            id="total-weight"
            className="block w-full rounded-md border-0 py-3 pl-4 pr-20 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-lime-600 sm:text-sm sm:leading-6"
            placeholder="0"
          />
          <div className="absolute inset-y-0 right-0 flex items-center">
            <label htmlFor="unit" className="sr-only"> {React.string("Unit")} </label>
            <select
              value={totalMeasurementUom}
              onChange={e => {
                setTotalMeasurementUom(ReactEvent.Form.target(e)["value"])
              }}
              id="unit"
              name="unit"
              className="h-full rounded-md border-0 bg-transparent py-0 pl-2 pr-7 text-gray-500 focus:ring-2 focus:ring-inset focus:ring-lime-600 sm:text-sm">
              {React.array(units(measurement))}
            </select>
          </div>
        </div>
      </div>
      <div>
        <label
          htmlFor="total-price"
          className="block text-sm leading-6 text-gray-500 font-medium uppercase">
          {React.string("Total price")}
        </label>
        <div className="relative mt-1 rounded-md">
          <div className="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4">
            <span className="text-gray-500 sm:text-sm"> {React.string("$")} </span>
          </div>
          <input
            value={totalPrice}
            onChange={e => {
              setTotalPrice(ReactEvent.Form.target(e)["value"])
            }}
            type_="number"
            name="total-price"
            id="total-price"
            className="block w-full rounded-md border-0 py-3 pr-20 pl-8 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-lime-600 sm:text-sm sm:leading-6"
            placeholder="0.00"
          />
        </div>
      </div>
      <hr className="mt-2" />
      <div>
        <label
          htmlFor="price-per"
          className="block text-sm leading-6 text-gray-500 font-medium uppercase">
          {React.string("Price per")}
        </label>
        <div className="relative mt-1 rounded-md">
          <input
            value={unitMeasurement}
            onChange={e => {
              setUnitMeasurement(ReactEvent.Form.target(e)["value"])
            }}
            type_="number"
            name="price-per"
            id="price-per"
            className="block w-full rounded-md border-0 py-3 px-4 pr-20 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-lime-600 sm:text-sm sm:leading-6"
            placeholder="0"
          />
          <div className="absolute inset-y-0 right-0 flex items-center">
            <label htmlFor="unit-weight-uom" className="sr-only">
              {React.string("Unit weight unit of measurement")}
            </label>
            <select
              value={unitMeasurementUom}
              onChange={e => {
                setUnitMeasurementUom(ReactEvent.Form.target(e)["value"])
              }}
              id="unit-weight-uom"
              name="unit-weight-uom"
              className="h-full rounded-md border-0 bg-transparent py-0 pl-2 pr-7 text-gray-500 focus:ring-2 focus:ring-inset focus:ring-lime-600 sm:text-sm">
              {React.array(units(measurement))}
            </select>
          </div>
        </div>
      </div>
      <div className="flex items-baseline justify-between">
        <span className="text-gray-500"> {React.string("=")} </span>
        <h2 className="text-2xl font-bold leading-7 text-gray-900 whitespace-nowrap">
          <span className="font-light"> {React.string("$")} </span>
          {Js.Float.toFixedWithPrecision(
            Calculate.costPerUnitMeasurement(
              ~measurement,
              ~totalMeasurement,
              ~totalPrice,
              ~totalMeasurementUom,
              ~unitMeasurement,
              ~unitMeasurementUom,
            ),
            ~digits=2,
          )->React.string}
        </h2>
      </div>
    </div>
  </div>
}
