# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
inherit python-r1

WINE_PN="dwproton"
WINE_PV=$(ver_rs 2 -)
WINE_P="${WINE_PN}-${WINE_PV}"

DESCRIPTION="Proton builds with the latest Dawn Winery fixes"
HOMEPAGE="https://dawn.wine/dawn-winery/dwproton"

SRC_URI="https://dawn.wine/dawn-winery/dwproton/releases/download/${WINE_P}/${WINE_P}-x86_64.tar.xz -> ${P}.tar.xz"

LICENSE="
	BSD BSD-2 IJG LGPL-2.1+ MIT OPENLDAP ZLIB gsm libpng2 libtiff
	|| ( WTFPL-2 public-domain )
"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"

src_unpack() {
	unpack ${A}
	mv ${WINE_P}-x86_64 ${P} || die
}

src_install() {
	python_setup
	python_fix_shebang proton

	dodir /opt
	cp -r ../${P} "${ED}/opt" || die

	sed s/'${P}'/${P}/ "${FILESDIR}/dwproton" > "${T}/dwproton" || die
	dobin "${T}/dwproton"
}
