# StringModifier
A Library with a number of methods for modifying strings in Luau.

# Methods
- `StringModifier:ToHexadecimal(string) : string`

Converts the provided string into it's hexadecimal equivalent.

<br/>
- `StringModifier:FromHexadecimal(string) : string`

Converts the provided string into it's ASCII equivalent.

<br/>
- `StringModifier:DecimalToBits(number, number?) : string`

Converts an integer into it's literal binary equivalent.

<br/>
- `StringModifier:ToBinary(string) : string`

Converts the provided string into it's literal binary equivalent.

<br/>
- `StringModifier:FromBinary(string) : string`

Converts literal binary into it's equivalent string, intended to be used with `StringModifier:ToBinary()`.

<br/>
- `StringModifier:Chain((... any?) -> ... any?, {[number] : any?}, ... {[number] : any?}) : string`

Chain a sequence of string operations and parameters to apply to a given string.

<br/>
- `StringModifier:Compress(string) : string`

A fast & simplistic method for compressing strings.

<br/>
- `StringModifier:Decompress(string) : string`

Uncompress strings, intended to be used with `StringModifier:Compress()`.

<br/>
- `StringModifier:LeadingUppercase(string) : string`

Set the first letter of the provided string to it's uppercase varient.

<br/>
- `StringModifier:LeadingLowercase(string) : string`

Set the first letter of the provided string to it's lowercase varient.

<br/>
- `StringModifier:RemoveWhitespace(string) : string`

Removes any identifiable whitespace from the provided string.

<br/>
- `StringModifier:Pascal(string) : string`

Converts the provided string into "Pascal" case.

<br/>
- `StringModifier:Camel(string) : string`

Converts the provided string into "Camel" case.

