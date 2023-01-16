module gd.gui2.element;
import gd.graphics.color;

/+

Source:
	color or gradient + image

Border:
	source: Source
	width: double
	pattern: double[]

Style:
	background: Source
	interiorBorders: Border[]
	exteriorBorders: Border[]
	borderRadius:
		topLeft, topRight
		bottomLeft, bottomRight
	padding
	margin

InlineStyle extends Style:
	font
		family
		size
		weight
	color: Source
	alignment
		top, middle, baseline
		+ em amount
		+ px amount

BlockStyle extends Style:
	size: % + px
	position: %parent.size + %size + px
	transform
	overflow x/y
		visible
		scroll
		hidden

+/

enum PropertySource {
	inherit,
	initial,
}

struct Source {
	Color color;
}

class Style {

}

class Element {

}

enum State {
	none,
	hover,
	focus,
}

struct StyleProvider {
	string selector;
	Style style;
}

class Theme {
	StyleProvider[] styles;
}

interface IComponent {
	Element render();
}
