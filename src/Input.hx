package;

import js.html.PreElement;
import little.Keywords;
import js.Browser;
import js.html.ParagraphElement;
import js.html.TextAreaElement;
import little.Keywords.*;

using TextTools;

class Input {
	static var window = Browser.window;
	static var document = Browser.document;

	public var area:TextAreaElement;

	public var pre:PreElement;

	public function new(textArea:TextAreaElement) {
		area = textArea;
		var s = window.getComputedStyle(area);

		for (styleName in s) {
			untyped pre.style[styleName] = s.getPropertyValue(styleName);
		}

		area.oninput = () -> {
			pre.innerHTML = highlightLittle(area.value);
		}


		area.style.opacity = "0.05";
		pre.style.position = "absolute";
		var posA = area.getBoundingClientRect();
		pre.style.top = posA.top + "px";
		pre.style.left = posA.left + "px";
		pre.style.width = posA.width + "px";
		pre.style.height = posA.height + "px";

		document.appendChild(pre);
	}

	public function highlightLittle(text:String):String {

		var indexOfIdent = ~/(\w+)/,
			indexOfBlue = new EReg('\\b(${Keywords.VARIABLE_DECLARATION}|${Keywords.FUNCTION_DECLARATION}|${Keywords.TRUE_VALUE}|${Keywords.FALSE_VALUE}|${Keywords.NULL_VALUE}|${Keywords.FOR_LOOP_IDENTIFIERS.FROM}|${Keywords.FOR_LOOP_IDENTIFIERS.TO}|${Keywords.FOR_LOOP_IDENTIFIERS.JUMP})\\b',"g"),
			indexOfPurple = new EReg(Keywords.CONDITION_TYPES.concat([Keywords.ELSE]).join("|"), "g"),
			indexOfFunctionName = ~/([a-zA-Z0-9_]+)\(/g,
			indexOfClassName = ~/(?::|\(| |\n|^)([A-Z][a-zA-Z]+)/g,
			indexOfString = ~/("[^"]*"|'[^']*')/g,
			indexOfNumbers = ~/([0-9]+\.?[0-9]*)/g,
			indexOfComments = ~/(\/\/.*)/g,
			indexOfDocs = ~/(""".*""")/gs;

			text = indexOfNumbers.replace(text, '<span style="#b5cea8">$1</span>');
			text = indexOfIdent.replace(text, '<span style="#9cdcfe">$1</span>');
			text = indexOfFunctionName.replace(text, '<span style="#dcdcaa">$1</span>');
			text = indexOfBlue.replace(text, '<span style="#569cd6">$1</span>');
			text = indexOfPurple.replace(text, '<span style="#c586c0">$1</span>');
			text = indexOfClassName.replace(text, '<span style="#44c9b0">$1</span>');
			text = indexOfString.replace(text, '<span style="#ff5e00">$1</span>');
			text = indexOfComments.replace(text, '<span style="#5e5e5e">$1</span>');
			text = indexOfDocs.replace(text, '<span style="#6a9955">$1</span>');
		return text;
	}
}
