package;

import haxe.io.Path;
import little.tools.Data;
import little.tools.Plugins;
import little.tools.Conversion;
import little.Little;
import little.interpreter.Runtime;
import little.tools.PrettyPrinter;
import little.interpreter.Interpreter;
#if js
import js.Browser;
#elseif sys 
import sys.FileSystem;
import sys.io.File;
#end
import little.parser.Parser;
import little.lexer.Lexer;

using StringTools;

class Main {

	static function main() {
		new JsExample();
	}
}
