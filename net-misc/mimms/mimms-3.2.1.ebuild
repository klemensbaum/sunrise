# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

PYTHON_DEPEND="2:2.5"
inherit distutils

DESCRIPTION="mms stream downloader that uses libmms"
HOMEPAGE="http://savannah.nongnu.org/projects/mimms/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libmms <dev-lang/python-3"
RDEPEND="${DEPEND}"

RESTRICT_PYTHON_ABIS="3*"

DOCS="AUTHORS NEWS README teststreams.list"
