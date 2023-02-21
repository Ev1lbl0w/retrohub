extends Node

var data = {
  "debug": true,
  "layouts": [
	{
	  "name": "standart-characters",
	  "rows": [
		{
		  "keys": [
			{
			  "type": "char",
			  "output": "Q",
			  "display": "q",
			  "display-uppercase": "Q"
			},
			{
			  "type": "char",
			  "output": "W",
			  "display": "w",
			  "display-uppercase": "W"
			},
			{
			  "type": "char",
			  "output": "E",
			  "display": "e",
			  "display-uppercase": "E"
			},
			{
			  "type": "char",
			  "output": "R",
			  "display": "r",
			  "display-uppercase": "R"
			},
			{
			  "type": "char",
			  "output": "T",
			  "display": "t",
			  "display-uppercase": "T"
			},
			{
			  "type": "char",
			  "output": "Y",
			  "display": "y",
			  "display-uppercase": "Y"
			},
			{
			  "type": "char",
			  "output": "U",
			  "display": "u",
			  "display-uppercase": "U"
			},
			{
			  "type": "char",
			  "output": "I",
			  "display": "i",
			  "display-uppercase": "I"
			},
			{
			  "type": "char",
			  "output": "O",
			  "display": "o",
			  "display-uppercase": "O"
			},
			{
			  "type": "char",
			  "output": "P",
			  "display": "p",
			  "display-uppercase": "P"
			},
			{
			  "type": "special",
			  "output": "Backspace",
			  "display-icon": "PREDEFINED:DELETE",
			  "stretch-ratio": 1.5
			}
		  ]
		},
		{
		  "keys": [
			{
			  "type": "char",
			  "output": "A",
			  "display": "a",
			  "display-uppercase": "A"
			},
			{
			  "type": "char",
			  "output": "S",
			  "display": "s",
			  "display-uppercase": "S"
			},
			{
			  "type": "char",
			  "output": "D",
			  "display": "d",
			  "display-uppercase": "D"
			},
			{
			  "type": "char",
			  "output": "F",
			  "display": "f",
			  "display-uppercase": "F"
			},
			{
			  "type": "char",
			  "output": "G",
			  "display": "g",
			  "display-uppercase": "G"
			},
			{
			  "type": "char",
			  "output": "H",
			  "display": "h",
			  "display-uppercase": "H"
			},
			{
			  "type": "char",
			  "output": "J",
			  "display": "j",
			  "display-uppercase": "J"
			},
			{
			  "type": "char",
			  "output": "K",
			  "display": "k",
			  "display-uppercase": "K"
			},
			{
			  "type": "char",
			  "output": "L",
			  "display": "l",
			  "display-uppercase": "L"
			},
			{
			  "type": "special",
			  "output": "Return",
			  "display-icon": "PREDEFINED:ENTER",
			  "stretch-ratio": 1.5
			}
		  ]
		},
		{
		  "keys": [
			{
			  "type": "special-shift",
			  "display-icon": "PREDEFINED:SHIFT",
			  "stretch-ratio": 1.5
			},
			{
			  "type": "char",
			  "output": "Z",
			  "display": "z",
			  "display-uppercase": "Z"
			},
			{
			  "type": "char",
			  "output": "X",
			  "display": "x",
			  "display-uppercase": "X"
			},
			{
			  "type": "char",
			  "output": "C",
			  "display": "c",
			  "display-uppercase": "C"
			},
			{
			  "type": "char",
			  "output": "V",
			  "display": "v",
			  "display-uppercase": "V"
			},
			{
			  "type": "char",
			  "output": "B",
			  "display": "b",
			  "display-uppercase": "B"
			},
			{
			  "type": "char",
			  "output": "N",
			  "display": "n",
			  "display-uppercase": "N"
			},
			{
			  "type": "char",
			  "output": "M",
			  "display": "m",
			  "display-uppercase": "M"
			},
			{
			  "type": "special-shift",
			  "display-icon": "PREDEFINED:SHIFT",
			  "stretch-ratio": 2
			}
		  ]
		},
		{
		  "keys": [
			{
			  "type": "switch-layout",
			  "layout-name": "special-characters",
			  "display": "&123",
			  "stretch-ratio": 1.5
			},
			{
			  "type": "char",
			  "output": ",",
			  "display": ","
			},
			{
			  "type": "char",
			  "output": "Space",
			  "stretch-ratio": 5
			},
			{
			  "type": "char",
			  "output": ".",
			  "display": "."
			},
			{
			  "type": "special",
			  "output": "LeftArrow",
			  "display-icon": "PREDEFINED:LEFT"
			},
			{
			  "type": "special",
			  "output": "RightArrow",
			  "display-icon": "PREDEFINED:RIGHT"
			},
			{
			  "type": "special-hide-keyboard",
			  "display-icon": "PREDEFINED:HIDE",
			  "stretch-ratio": 2
			}
		  ]
		}
	  ]
	},
	{
	  "name": "special-characters",
	  "rows": [
		{
		  "keys": [
			{
			  "type": "char",
			  "output": "1",
			  "display": "1"
			},
			{
			  "type": "char",
			  "output": "2",
			  "display": "2"
			},
			{
			  "type": "char",
			  "output": "3",
			  "display": "3"
			},
			{
			  "type": "char",
			  "output": "4",
			  "display": "4"
			},
			{
			  "type": "char",
			  "output": "5",
			  "display": "5"
			},
			{
			  "type": "char",
			  "output": "6",
			  "display": "6"
			},
			{
			  "type": "char",
			  "output": "7",
			  "display": "7"
			},
			{
			  "type": "char",
			  "output": "8",
			  "display": "8"
			},
			{
			  "type": "char",
			  "output": "9",
			  "display": "9"
			},
			{
			  "type": "char",
			  "output": "0",
			  "display": "0"
			},
			{
			  "type": "special",
			  "output": "Backspace",
			  "display-icon": "PREDEFINED:DELETE",
			  "stretch-ratio": 1.5
			}
		  ]
		},
		{
		  "keys": [
			{
			  "type": "char",
			  "output": "@",
			  "display": "@"
			},
			{
			  "type": "char",
			  "output": "#",
			  "display": "#"
			},
			{
			  "type": "char",
			  "output": "$",
			  "display": "$"
			},
			{
			  "type": "char",
			  "output": "%",
			  "display": "%"
			},
			{
			  "type": "char",
			  "output": "&",
			  "display": "&"
			},
			{
			  "type": "char",
			  "output": "-",
			  "display": "-"
			},
			{
			  "type": "char",
			  "output": "+",
			  "display": "+"
			},
			{
			  "type": "char",
			  "output": "=",
			  "display": "="
			},
			{
			  "type": "char",
			  "output": "~",
			  "display": "~"
			},
			{
			  "type": "char",
			  "output": "(",
			  "display": "("
			},
			{
			  "type": "char",
			  "output": ")",
			  "display": ")"
			},
			{
			  "type": "special",
			  "output": "Return",
			  "display-icon": "PREDEFINED:ENTER",
			  "stretch-ratio": 2
			}
		  ]
		},
		{
		  "keys": [
			{
			  "type": "char",
			  "output": "*",
			  "display": "*"
			},
			{
			  "type": "char",
			  "output": "\"",
			  "display": "\""
			},
			{
			  "type": "char",
			  "output": "'",
			  "display": "'"
			},
			{
			  "type": "char",
			  "output": ":",
			  "display": ":"
			},
			{
			  "type": "char",
			  "output": ";",
			  "display": ";"
			},
			{
			  "type": "char",
			  "output": "!",
			  "display": "!"
			},
			{
			  "type": "char",
			  "output": "?",
			  "display": "?"
			},
			{
			  "type": "char",
			  "output": "<",
			  "display": "<"
			},
			{
			  "type": "char",
			  "output": ">",
			  "display": ">"
			},
			{
			  "type": "char",
			  "output": "{",
			  "display": "{"
			},
			{
			  "type": "char",
			  "output": "}",
			  "display": "}"
			},
			{
			  "type": "char",
			  "output": "[",
			  "display": "["
			},
			{
			  "type": "char",
			  "output": "]",
			  "display": "]"
			}
		  ]
		},
		{
		  "keys": [
			{
			  "type": "switch-layout",
			  "layout-name": "standart-characters",
			  "display": "ABC",
			  "stretch-ratio": 1.5
			},
			{
			  "type": "char",
			  "output": "_",
			  "display": "_"
			},
			{
			  "type": "char",
			  "output": "/",
			  "display": "/"
			},
			{
			  "type": "char",
			  "output": " ",
			  "stretch-ratio": 5
			},
			{
			  "type": "special",
			  "output": "LeftArrow",
			  "display-icon": "PREDEFINED:LEFT"
			},
			{
			  "type": "special",
			  "output": "RightArrow",
			  "display-icon": "PREDEFINED:RIGHT"
			},
			{
			  "type": "special-hide-keyboard",
			  "display-icon": "PREDEFINED:HIDE",
			  "stretch-ratio": 2
			}
		  ]
		}
	  ]
	}
  ]
}
