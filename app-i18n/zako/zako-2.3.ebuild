# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

DESCRIPTION="Cangjie input method for Wayland"
HOMEPAGE="https://github.com/RadioNoiseE/zako"

SRC_URI="https://github.com/RadioNoiseE/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND="dev-util/wayland-scanner"

RDEPEND="
	dev-libs/wayland
	x11-libs/libxkbcommon
"

DEPEND="${RDEPEND}"

src_compile() {
	local x
	for x in wayland/*.xml; do
		wayland-scanner client-header ${x} $(basename ${x} .xml).h
		wayland-scanner private-code ${x} $(basename ${x} .xml).c
	done

	edo $(tc-getCC) ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} -o ${PN} \
		-lwayland-client -lxkbcommon *.c libzako/*.c
}

src_install() {
	dobin ${PN}
}
