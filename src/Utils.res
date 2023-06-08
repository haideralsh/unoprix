module String = {
  let stripCommas = value => Js.String.replaceByRe(%re("/,/g"), "", value)
}

module Float = {
  let fromString = (~default=0.0, value) =>
    Belt.Option.getWithDefault(Belt.Float.fromString(value), default)
}
