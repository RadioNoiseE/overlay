# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="A proof assistant for higher-order logic"
HOMEPAGE="https://hol-theorem-prover.org/"

HOL4_PN="hol"
HOL4_PV="trindemossen-2"
HOL4_P=${HOL4_PN}-${HOL4_PV}

SRC_URI="https://github.com/HOL-Theorem-Prover/HOL/releases/download/${HOL4_PV}/${HOL4_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="mlton"

RDEPEND="
	dev-lang/polyml:=
	mlton? ( dev-lang/mlton:= )
"

DEPEND="${RDEPEND}"

pkg_pretend() {
	if has sandbox ${FEATURES}; then
		die "HOL4 is incompatible with the sandbox feature"
	fi

	if has usersandbox ${FEATURES}; then
		die "HOL4 is incompatible with the usersandbox feature"
	fi
}

src_unpack() {
	unpack ${HOL4_P}.tar.gz
	mv ${HOL4_P} ${P} || die
}

src_configure() {
	echo "val polymllibdir = \"/usr/$(get_libdir)\";" > tools-poly/poly-includes.ML || die
	poly --script tools/smart-configure.sml || die
}

src_compile() {
	bin/build || die
	bin/build cleanForReloc || [[ $? -eq 1 ]] || die
}

src_install() {
	mkdir "${EPREFIX}/opt"
	cp -r ../${P} "${EPREFIX}/opt" || die

	cd "${EPREFIX}/opt/${P}" || die
	poly --script tools/smart-configure.sml || die
	bin/build --relocbuild || die
	scanelf -yBR -E 3 -F '%F' . | xargs patchelf --set-soname "libhol4.so" || die

	dodir /opt
	mv "${EPREFIX}/opt/${P}" "${ED}/opt"

	echo "PATH=${EPREFIX}/opt/${P}/bin" | newenvd - 60${P}
}
