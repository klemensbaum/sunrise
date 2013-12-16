# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit sgml-catalog

MY_PV=${PV/_beta/b}
MY_PV=${PV/_rc/CR}

DESCRIPTION="Docbook DTD for MathML"
HOMEPAGE="http://www.docbook.org/xml/mathml/"
SRC_URI="http://www.docbook.org/xml/mathml/${MY_PV}/dbmathml.dtd"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-text/mathml-xml-dtd"
RDEPEND="dev-libs/libxml2
	app-text/docbook-xml-dtd:4.3
	>=app-text/build-docbook-catalog-1.6
	${DEPEND}"

S=${WORKDIR}

sgml-catalog_cat_include "/etc/sgml/mathml-docbook-${PV}.cat" \
	"/usr/share/sgml/docbook/${P#docbook-}/docbook.cat"

src_unpack() {
	cp "${DISTDIR}"/${A} "${S}" || die
}

src_prepare() {
	cat <<- EOF > docbook.cat || die
		PUBLIC "-//OASIS//DTD DocBook MathML Module V${MY_PV}//EN" "dbmathml.dtd"
		SYSTEM "http://www.oasis-open.org/docbook/xml/mathml/1.1CR1/dbmathml.dtd" "dbmathml.dtd"
	EOF
}

src_install() {
	insinto /usr/share/sgml/docbook/${P#docbook-}
	doins *.cat *.dtd
}

pkg_postinst() {
	build-docbook-catalog || die
	sgml-catalog_pkg_postinst || die

	xmlcatalog --noout \
		--add public "-//OASIS//DTD DocBook MathML Module V${MV_PV}//EN" "file:///usr/share/sgml/docbook/${P#docbook-}/dbmathml.dtd" \
		--add rewriteSystem "http://www.oasis-open.org/docbook/xml/mathml/1.1CR1" "file:///usr/share/sgml/docbook/${P#docbook-}" \
		"${EPREFIX}"/etc/xml/docbook \
	|| die
}

pkg_postrm() {
	build-docbook-catalog || die
	sgml-catalog_pkg_postrm || die

	xmlcatalog --noout \
		--del "-//OASIS//DTD DocBook MathML Module V${MV_PV}//EN" \
		--del "http://www.oasis-open.org/docbook/xml/mathml/1.1CR1/dbmathml.dtd" \
		"${EPREFIX}"/etc/xml/docbook \
	|| die
}
