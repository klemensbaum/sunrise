# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Glue to stick OptionParser and ConfigParser together"
HOMEPAGE="https://launchpad.net/configglue"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="test? ( dev-python/mock )"
RDEPEND="dev-python/pyxdg"

RESTRICT_PYTHON_ABIS="2.4 3.*"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}" "$(PYTHON)" setup.py test
	}
	python_execute_function testing
}
