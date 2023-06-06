module Switch = {
  @react.component
  let make = (~value, ~system, ~measurement, ~onClick) =>
    <button
      onClick={onClick}
      className={`
                ${system == value ? "bg-white" : "bg-gray-200"}
                pointer-events-auto 
                rounded-md
                px-2.5
                text-s
                focus-visible:outline-none
                focus-visible:ring-2
                focus-visible:ring-emerald-500`}>
      {React.string(Measurement.defaultUnitFor(~system=value, ~measurement))}
    </button>
}

@react.component
let make = (~system, ~measurement, ~onChange) =>
  <div className="flex ring-1 ring-gray-200 rounded-md p-0.5 bg-gray-200 gap-0.5">
    <Switch
      system
      measurement
      value={Measurement.Imperial}
      onClick={_ => onChange(_ => Measurement.Imperial)}
    />
    <Switch
      system measurement value={Measurement.Metric} onClick={_ => onChange(_ => Measurement.Metric)}
    />
  </div>
