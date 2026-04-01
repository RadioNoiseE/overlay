# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="Window overview and selection for Wayland compositors"
HOMEPAGE="https://github.com/RadioNoiseE/windows"

SRC_URI="https://github.com/RadioNoiseE/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
"

RDEPEND="
	dev-libs/wayland
	x11-libs/cairo
	x11-libs/libxkbcommon
"

DEPEND="
	${RDEPEND}
	>=dev-libs/wayland-protocols-1.37
"

src_install() {
	emake ${PN}
	dobin ${PN}
	doman ${PN}.1
}
