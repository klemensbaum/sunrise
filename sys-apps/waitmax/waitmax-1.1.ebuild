# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="allow a program to run at most a specified amount of time"
HOMEPAGE="http://mathias-kettner.de/waitmax.html"
SRC_URI="http://mathias-kettner.de/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}/${P}-make.patch"
}
