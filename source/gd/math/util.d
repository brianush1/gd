module gd.math.util;

T mix(T, A)(T from, T to, A alpha) {
	return from * (1 - alpha) + to * alpha;
}

T smoothstep(T)(T x) {
	if (x > 1)
		return 1;
	else if (x < 0)
		return 0;
	else
		return 3*x*x - 2*x*x*x;
}

T signum(T)(T x) {
	if (x > 0)
		return 1;
	else if (x == 0)
		return 0;
	else if (x < 0)
		return -1;
	else
		return x;
}
