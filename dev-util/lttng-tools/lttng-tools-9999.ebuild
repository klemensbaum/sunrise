# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 linux-info

DESCRIPTION="Linux Trace Toolkit - next generation"
HOMEPAGE="http://lttng.org"
EGIT_REPO_URI="git://git.lttng.org/${PN}.git"
EGIT_BOOTSTRAP="eautoreconf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+ust"

DEPEND="dev-libs/userspace-rcu
	dev-libs/popt
	ust? ( dev-util/lttng-ust )
"
RDEPEND="${DEPEND}"

pkg_pretend() {
	if kernel_is -lt 2 6 27; then
		ewarn "${PN} require Linux kernel >= 2.6.27"
		ewarn "   pipe2(), epoll_create1() and SOCK_CLOEXEC are needed to run"
		ewarn "   the session daemon. There were introduce in the 2.6.27"
	fi
}

src_configure() {
	econf $(use_enable ust lttng-ust)
}
