module Switch = {
  @react.component
  let make = (~value, ~system, ~measurement, ~onClick) =>
    <button
      onClick={onClick}
      className={`
                ${system == value ? "font-medium" : "font-normal"}
                text-gray-900
                pointer-events-auto 
                rounded-md
                w-12
                h-6
                text-s
                z-20
                focus-visible:outline-none
                focus-visible:ring-2
                focus-visible:ring-emerald-500`}>
      {React.string(Measurement.defaultUnitFor(~system=value, ~measurement))}
    </button>
}

@react.component
let make = (~system, ~measurement, ~onChange) =>
  switch measurement {
  | #quantity => React.null
  | _ =>
    <div className="relative flex rounded-md p-0.5 bg-gray-200">
      <Switch
        system
        measurement
        value={Measurement.Imperial}
        onClick={_ => onChange(_ => Measurement.Imperial)}
      />
      <Switch
        system
        measurement
        value={Measurement.Metric}
        onClick={_ => onChange(_ => Measurement.Metric)}
      />
      <span
        className={`absolute block h-6 w-12 bg-white shadow-sm rounded-md transition-transform z-10 ease-out duration-200
     ${switch system {
          | Measurement.Metric => "translate-x-12"
          | Measurement.Imperial => "translate-x-0"
          }}
    `}
      />
    </div>
  }
