# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
NEED_PYTHON=2.5

inherit distutils

DESCRIPTION="Python network library that uses greenlet and libevent for easy and scalable concurrency"
HOMEPAGE="http://gevent.org/"
SRC_URI="http://pypi.python.org/packages/source/g/gevent/${P}.tar.gz"

LICENSE="as-is MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc examples"

DEPEND="dev-libs/libevent
	>=dev-python/greenlet-0.2
	doc? ( dev-python/sphinx )"
RDEPEND="${DEPEND}"

src_compile() {
	distutils_src_compile

	if use doc; then
		cd "${S}/doc"
		PYTHONPATH=".." emake html || die "Building documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/_build/html/* || die
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "doins failed"
	fi

	dodoc TODO || die "dodoc failed"
}