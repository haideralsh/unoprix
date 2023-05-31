let floatOfString = stringNum => Belt.Option.getWithDefault(Belt.Float.fromString(stringNum), 0.0)
