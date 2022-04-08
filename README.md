# StringModifier
A Library with a number of methods for modifying strings in Luau.

# Methods
- `StringModifier:ToHexadecimal(string) : string`
Converts the provided string into it's hexadecimal equivalent.

- `StringModifier:FromHexadecimal(string) : string`
Converts the provided string into it's ASCII equivalent.

- `StringModifier:DecimalToBits(number, number?) : string`
Converts an integer into it's literal binary equivalent.

- `StringModifier:ToBinary(string) : string`
Converts the provided string into it's literal binary equivalent.

- `StringModifier:FromBinary(string) : string`
Converts literal binary into it's equivalent string, intended to be used with `StringModifier:ToBinary()`.

- `StringModifier:Chain((... any?) -> ... any?, {[number] : any?}, ... {[number] : any?}) : string`
Chain a sequence of string operations and parameters to apply to a given string.

- `StringModifier:Compress(string) : string`
A fast & simplistic method for compressing strings.

- `StringModifier:Decompress(string) : string`
Uncompress strings, intended to be used with `StringModifier:Compress()`.

- `StringModifier:LeadingUppercase(string) : string`
Set the first letter of the provided string to it's uppercase varient.

- `StringModifier:LeadingLowercase(string) : string`
Set the first letter of the provided string to it's lowercase varient.

- `StringModifier:RemoveWhitespace(string) : string`
Removes any identifiable whitespace from the provided string.

- `StringModifier:Pascal(string) : string`
Converts the provided string into "Pascal" case.

- `StringModifier:Camel(string) : string`
Converts the provided string into "Camel" case.
