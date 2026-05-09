# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Day/night gamma adjustments for Wayland"
HOMEPAGE="https://sr.ht/~kennylevinsen/wlsunset/"

SRC_URI="https://git.sr.ht/~kennylevinsen/wlsunset/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-util/wayland-scanner
	app-text/scdoc
"
RDEPEND="dev-libs/wayland"

DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
"

src_configure() {
	local emesonargs=(
		-Dwerror=false
		-Dman-pages=enabled
	)

	meson_src_configure
}
