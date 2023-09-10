module gd.math.util;

T mix(T, A)(T from, T to, A alpha) {
	return from * (1 - alpha) + to * alpha;
}
