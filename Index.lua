--[[::--

Copyright (C) 2022, Luc Rodriguez (Aliases : Shambi, StyledDev).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Source : https://github.com/Shambi-0/StringModifier/Index.lua

--::]]--

--------------------------
--// Type Definitions //--
--------------------------

type Array<Type> = {[number] : Type};
type Dictionary<Type> = {[string] : Type};

-----------------------
--// Initalization //--
-----------------------

local Module : any? = {
	["Location"] = if (game:GetService("RunService"):IsServer()) then "Server" else "Client";
	["Whitespaces"] = {
		9, -- Horizontal Tab
		10, -- Line Feed
		11, -- Vertical Tab
		12, -- Form Feed
		13, -- Carriage return
		32, -- Space
		133, -- Next Line
		160, -- No-Break Space
		5760, -- Ogham Space Mark
		8192, -- En Quad
		8193, -- Em Quad
		8194, -- En Space
		8195, -- Em Space
		8196, -- Three-Per-Em Space
		8197, -- Four-Per-Em Space
		8198, -- Six-Per-Em Space
		8199, -- Figure Space
		8200, -- Punctuation Space
		8201, -- Thin Space
		8202, -- Hair Space
		8232, -- Line Separator
		8233, -- Paragraph Separator
		8239, -- Narrow No-Break Space
		8287, -- Medium Mathematical Space
		12288, -- Ideographic Space
		
		--<<>> Special Cases <<>>--
		
		6158, -- Mongolian Vowel Separator
		8203, -- Zero Width Space
		8204, -- Zero Width Non-Joiner
		8205, -- Zero Width Joiner
		8288, -- Word Joiner
		65279 -- Zero Width Non-Breaking Space
	};
};
Module.__index = Module;

-------------------
--// Functions //--
-------------------

local function Check(Condition : boolean?, Message : string) : nil?
	if not (Condition) then
		error(string.format("[Framework] [%s] %s", Module.Location or "Unknown", Message or ""), 2);
	end;
end;

local function Minimize(Callback : (... any?) -> ... any?, Combine : boolean, ... : any?) : () -> nil?
	Check(type(Callback) == "function", "Expected type \"function\" for argument #1 of \"Minimize\".");
	local Arguments : Array<any?> = {...};

	return (function(... : any?) : nil?
		if (Combine) then
			Callback(..., unpack(Arguments));
		else
			Callback(unpack(Arguments));
		end;
	end);
end;

-----------------
--// Methods //--
-----------------

function Module:ToHexadecimal(String : string) : string
	Check(type(String) == "string", "Expected type \"string\" in \":ToHexadecimal\".");
	
	return (string.gsub(String, ".", function(Character : string) : string?
		return (string.format("%02x", string.byte(Character)));
	end));
end;

function Module:FromHexadecimal(String : string) : string
	local Divided : number = #String / 2;
	
	Check(type(String) == "string", "Expected type \"string\" in \":FromHexadecimal\".");
	Check(math.floor(Divided) == Divided, "\"string\" provided in \":FromHexadecimal\" cannot be equally divided.");
	
	return (string.gsub(String, "..", function(HexadecimalPair : string) : string
		return (string.char(tonumber(HexadecimalPair, 16)));
	end));
end;

function Module:DecimalToBits(Integer : number, Padding : number?) : string
	Padding = Padding or math.max(1, select(2, math.frexp(Integer)));
	
	local Bits : Array<number> = {}; 
	
	for Bit : number = Padding, 1, -1 do
		Bits[Bit] = math.fmod(Integer, 2);
		Integer = math.floor((Integer - Bits[Bit]) / 2);
	end;
	
	return (table.concat(Bits));
end;

function Module:ToBinary(String : string) : string
	Check(type(String) == "string", "[Framework] Expected type \"string\" in \":ToBinary\".");
	
	return (string.gsub(String, ".", function(Character : string) : string?
		local Bits : string = self:DecimalToBits(string.byte(Character), 8);
		
		return (Bits);
	end));
end;

function Module:FromBinary(String : string) : string
	local Divided : number = #String / 8;
	
	Check(type(String) == "string", "Expected type \"string\" in \":FromBinary\".");
	Check(math.floor(Divided) == Divided, "\"string\" provided in \":FromBinary\" cannot be equally divided.");
	
	string.gsub(String, ".", function(Digit : string) : string?
		Check(Digit == "0" or Digit == "1", "Non-binary \"string\" provided in \":FromBinary\".");
	end);
	
	return (string.gsub(String, string.rep(".", 8), function(Byte : string) : string?
		return (string.char(tonumber(Byte, 2)));
	end));
end;

function Module:Chain(Operation : (... any?) -> ... any?, Inital : Array<any?>, ... : Array<any?>) : string
	local Output : string = Operation(unpack(Inital));
	
	for Index : number, Arguments : string? in ipairs({...}) do
		Output = Operation(Output, unpack(Arguments));
	end;
	
	return (Output);
end;

function Module:Compress(Input : string) : string
	return (self:Chain(string.gsub, 
		{Input, ".", "\0%0%0"},
		{"(.)%z%1", "%1"},
		{"%z.(%Z+)",
			function(CharacterSet : string) : string?
				local Size : number = string.len(CharacterSet);
			
				if (Size > 4) then
					return (string.format("\129%s%s\254", string.sub(CharacterSet, 1, 1), Size));
				else
					return (CharacterSet);
				end;
			end;
		}
	));
end;

function Module:Decompress(Input : string) : string
	Check(type(Input) == "string", "Expected type \"string\" in \":Decompress\".");
	
	return (string.gsub(Input, "\129.%d+\254", function(Data : string) : string?
		local Data : string = string.sub(Data, 2, -2);
		
		return (string.rep(string.sub(Data, 1, 1), tonumber(string.sub(Data, 2, -1))));
	end));
end;

function Module:LeadingUppercase(Input : string) : string
	return (string.gsub(Input, "^%l", string.upper));
end;

function Module:LeadingLowercase(Input : string) : string
	return (string.gsub(Input, "^%l", string.lower));
end;

function Module:RemoveWhitespace(Input : string) : string
	local Result : string = "";
	
	for Codepoint : string in utf8.codes(Input) do
		if (table.find(self.Whitespaces, Codepoint) == nil) then
			Result ..= utf8.char(Codepoint);
		end
	end;
	
	return (Result);
end;

function Module:Pascal(Input : string) : string
	assert(typeof(Input) == "string", string.format("Type \"string\" expected for argument #1 in \":Pascal\", Recieved type \"%s\".", typeof(Input)));

	return (string.gsub(string.lower(Input), "%w+", Minimize(self.LeadingUppercase, true, nil)));
end;

function Module:Camel(Input : string) : string
	assert(typeof(Input) == "string", string.format("Type \"string\" expected for argument #1 in \":Camel\", Recieved type \"%s\".", typeof(Input)));

	return (self:LeadingLowercase(self:Pascal(Input)));
end;

----------------
--// Ending //--
----------------

return (Module);
