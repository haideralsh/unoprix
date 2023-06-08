let unitOptions = units =>
  Array.map(units, unit => {
    <option value={unit} key={unit}> {React.string(unit)} </option>
  })

let defaultSystem = Measurement.Metric
let defaultMeasurement: Measurement.kind = #weight

@react.component
let make = () => {
  let (measurement, setMeasurement) = React.useState(() => defaultMeasurement)
  let (system, setSystem) = React.useState(() => defaultSystem)
  let (totalMeasurement, setTotalMeasurement) = React.useState(() => "")
  let (totalMeasurementUom, setTotalMeasurementUom) = React.useState(() =>
    Measurement.defaultUnitFor(~system=defaultSystem, ~measurement=defaultMeasurement)
  )
  let (totalPrice, setTotalPrice) = React.useState(() => "")
  let (unitMeasurement, setUnitMeasurement) = React.useState(() => "")
  let (unitMeasurementUom, setUnitMeasurementUom) = React.useState(() =>
    Measurement.defaultUnitFor(~system=defaultSystem, ~measurement=defaultMeasurement)
  )

  React.useEffect2(() => {
    setTotalMeasurementUom(_prev => Measurement.defaultUnitFor(~system, ~measurement))
    setUnitMeasurementUom(_prev => Measurement.defaultUnitFor(~system, ~measurement))

    None
  }, (system, measurement))

  <div className="flex flex-col gap-8 p-8 max-w-sm mx-auto">
    <div className="flex justify-between items-center">
      <h1 className="font-extrabold leading-7 text-emerald-500 truncate text-3xl tracking-tight">
        <span className="text-emerald-500"> {React.string("unoprix")} </span>
      </h1>
      <div className="inset-y-0 right-0 flex items-center">
        <label htmlFor="unit type" className="sr-only"> {React.string("Unit type")} </label>
        <select
          value={(measurement :> string)}
          onChange={e => {
            setMeasurement(ReactEvent.Form.target(e)["value"])
          }}
          id="unit-type"
          name="unit-type"
          className="h-full rounded-md border-0 bg-transparent py-2 pl-3 pr-7 text-gray-500 focus:ring-2 focus:ring-inset focus:ring-emerald-500 sm:text-sm">
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
          className="flex justify-between text-sm leading-6 text-gray-500 font-medium uppercase">
          {React.string(`Total ${(measurement :> string)}`)}
          <SystemSwitcher system measurement onChange={setSystem} />
        </label>
        <div className="relative mt-2.5 rounded-md">
          <input
            value={totalMeasurement}
            onChange={e => {
              setTotalMeasurement(ReactEvent.Form.target(e)["value"])
            }}
            onBlur={_ => setTotalMeasurement(_ => NumberFormat.format(totalMeasurement))}
            name="total-weight"
            id="total-weight"
            className="block w-full rounded-md border-0 py-3 pl-4 pr-20 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-emerald-500 sm:text-sm sm:leading-6"
            placeholder="0"
            type_="text"
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
              className="h-full rounded-md border-0 bg-transparent py-0 pl-3 pr-7 text-gray-500 focus:ring-2 focus:ring-inset focus:ring-emerald-500 sm:text-sm">
              {React.array(Measurement.unitsFor(~system, ~measurement)->unitOptions)}
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
        <div className="relative mt-2.5 rounded-md">
          <div className="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4">
            <span className="text-gray-500 sm:text-sm"> {React.string("$")} </span>
          </div>
          <input
            value={totalPrice}
            onChange={e => {
              setTotalPrice(ReactEvent.Form.target(e)["value"])
            }}
            onBlur={_ => setTotalPrice(_ => NumberFormat.formatCurrency(totalPrice))}
            name="total-price"
            id="total-price"
            className="block w-full rounded-md border-0 py-3 pr-20 pl-8 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-emerald-500 sm:text-sm sm:leading-6"
            placeholder="0.00"
            type_="text"
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
        <div className="relative mt-2.5 rounded-md">
          <input
            value={unitMeasurement}
            onChange={e => {
              setUnitMeasurement(ReactEvent.Form.target(e)["value"])
            }}
            onBlur={_ => setUnitMeasurement(_ => NumberFormat.format(unitMeasurement))}
            name="price-per"
            id="price-per"
            className="block w-full rounded-md border-0 py-3 px-4 pr-20 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-emerald-500 sm:text-sm sm:leading-6"
            placeholder="0"
            type_="text"
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
              className="h-full rounded-md border-0 bg-transparent py-0 pl-3 pr-7 text-gray-500 focus:ring-2 focus:ring-inset focus:ring-emerald-500 sm:text-sm">
              {React.array(Measurement.unitsFor(~system, ~measurement)->unitOptions)}
            </select>
          </div>
        </div>
      </div>
      <PricePer
        system
        measurement
        totalMeasurement
        totalPrice
        totalMeasurementUom
        unitMeasurement
        unitMeasurementUom
      />
    </div>
  </div>
}
