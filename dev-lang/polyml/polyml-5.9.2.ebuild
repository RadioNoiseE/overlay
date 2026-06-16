# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Poly/ML is a full implementation of Standard ML"
HOMEPAGE="https://www.polyml.org/"

SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64"
IUSE="+gmp portable"

RDEPEND="
	gmp? ( >=dev-libs/gmp-4:= )
	portable? ( dev-libs/libffi:= )
"

DEPEND="${RDEPEND}"

src_prepare() {
	default

	# for compatibility with libc++
	sed -i '/AC_CHECK_LIB(stdc++, main)/d' configure.ac || die

	eautoreconf
}

src_configure() {
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
