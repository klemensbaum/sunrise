# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit bash-completion distutils

DESCRIPTION="pip is a replacement for easy_install"
HOMEPAGE="http://pip.openplans.org"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc zsh-completion"

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install
	COMPLETION="${T}/completion.tmp"
	export PYTHONPATH="${S}:${PYTHONPATH}"

	if use bash-completion; then
		./scripts/pip completion --bash > "${COMPLETION}" || die
		dobashcompletion "${COMPLETION}" ${PN}
	fi

	if use zsh-completion; then
		./scripts/pip completion --zsh > "${COMPLETION}" || die
		insinto /usr/share/zsh/site-functions
		newins "${COMPLETION}" _pip || die
	fi

	if use doc; then
		dohtml -r docs/_build/* || die
	fi
}
