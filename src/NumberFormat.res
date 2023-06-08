let formatWithFormatter = (value, formatter) => {
  switch value {
  | "" => value
  | _ => {
      let raw = value->Utils.String.stripCommas
      let parsed = Js.Float.fromString(raw)

      switch Js.Float.isNaN(parsed) {
      | true => value
      | false => Intl.NumberFormat.format(formatter, parsed)
      }
    }
  }
}

let format = value => {
  let numberFormatter = Intl.NumberFormat.make()

  value->formatWithFormatter(numberFormatter)
}

let formatCurrency = value => {
  let currencyFormatter = Intl.NumberFormat.makeWithOptions({
    "minimumFractionDigits": 2,
  })

  value->formatWithFormatter(currencyFormatter)
}
