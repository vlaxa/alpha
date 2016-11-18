# vim: set ts=4:

# Compares two versions and prints:
#   -1 if $1 < $2
#    0 if $1 = $2
#    1 if $1 > $2
# $1: left version
# $2: right version
compver() {
	awk -v vera="$1" -v verb="$2" -f - <<-EOF
		BEGIN {
			split(vera, a, ".")
			split(verb, b, ".")
			for (i = 1; !x && a[i]b[i] != ""; i++)
				x = (a[i] < b[i]) ? -1 : ((a[i] > b[i]) ? 1 : 0)
			print x
		}
	EOF
}

die() {
	# bold red
	printf '\033[1;31mERROR:\033[0m %s\n' "$1" >&2
	shift
	printf '  %s\n' "$@"
	exit 2
}

einfo() {
	# bold cyan
	printf '\033[1;36m> %s\033[0m\n' "$@" >&2
}

ewarn() {
	# bold yellow
	printf '\033[1;33m> %s\033[0m\n' "$@" >&2
}

has() {
	command -v "$1" >/dev/null 2>&1
}
