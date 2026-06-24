# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module

DESCRIPTION="Network proxy platform supporting multiple protocols and transport layers"
HOMEPAGE="https://github.com/XTLS/Xray-core"

SRC_URI="https://github.com/XTLS/Xray-core/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		 https://github.com/RadioNoiseE/deliver/raw/refs/heads/main/portage/${P}-deps.tar.xz"

S="${WORKDIR}/${P^}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND=">=dev-lang/go-1.26.0"

src_compile() {
	CGO_ENABLED=0 ego build -o xray -trimpath -buildvcs=false -gcflags=-l=4 ./main
}

src_install() {
	dobin xray
}
