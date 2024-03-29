#!/usr/bin/env zsh

function hsl {
	local h s l c k x r1 g1 b1 m r g b
	setopt -L force_float
	zmodload -af zsh/mathfunc abs

	((
		h = $1,
		s = $2,
		l = $3,

		c = (1 - abs(2 * l - 1)) * s,

		k = h / 60,
		x = c * (1 - abs(k % 2 - 1)),
 
		r1 = g1 = b1 = 0
	))

	(( k >= 0 && k <= 1 )) && ((r1 = c, g1 = x))
	(( k > 1  && k <= 2 )) && ((r1 = x, g1 = c))

	(( k > 2  && k <= 3 )) && ((g1 = c, b1 = x))
	(( k > 3  && k <= 4 )) && ((g1 = x, b1 = c))

	(( k > 4  && k <= 5 )) && ((r1 = x, b1 = c))
	(( k > 5  && k <= 6 )) && ((r1 = c, b1 = x))

	(( m = l - c / 2 ))

	((
		r = r1 + m,
		g = g1 + m,
		b = b1 + m
	))

	if [[ $COLORTERM = 'truecolor' ]]; then
		(( r *= 255, g *= 255, b *= 255))
		printf "#%0.2x%0.2x%0.2x" $r $g $b
	else
		(([#10] r *= 5, g *= 5, b *= 5))
		print -n $((16 + (6#$r$g$b)))
	fi
}
