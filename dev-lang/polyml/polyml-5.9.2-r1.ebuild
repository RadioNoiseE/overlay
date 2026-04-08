# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Poly/ML is a full implementation of Standard ML"
HOMEPAGE="https://www.polyml.org/"

SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+gmp portable"
RESTRICT="usersandbox"

RDEPEND="
	gmp? ( >=dev-libs/gmp-5:= )
	portable? ( dev-libs/libffi:= )
"

DEPEND="${RDEPEND}"

AR="ar"
CC="gcc"
CXX="g++"
RANLIB="ranlib"

pkg_pretend() {
	if has usersandbox ${FEATURES}; then
		die "Poly/ML bootstrap is incompatible with the usersandbox feature."
	fi
}

src_configure() {
	filter-flags '*'

	local x=(
		$(use_enable !portable native-codegeneration)
		$(use_with gmp)
	)

	econf "${x[@]}"
}

src_install() {
	default

	if [[ -f "${ED}"/usr/$(get_libdir)/libpolymain.la ]] ; then
		rm "${ED}"/usr/$(get_libdir)/libpolymain.la || die
	fi

	if [[ -f "${ED}"/usr/$(get_libdir)/libpolyml.la ]] ; then
		rm "${ED}"/usr/$(get_libdir)/libpolyml.la || die
	fi
}
