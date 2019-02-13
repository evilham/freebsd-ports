# Created by: Li-Wen Hsu <lwhsu@FreeBSD.org>
# $FreeBSD$

PORTNAME=	cgrep
PORTVERSION=	6.6.25
PORTREVISION=	3
CATEGORIES=	textproc

MAINTAINER=	lwhsu@FreeBSD.org
COMMENT=	Context-aware grep for source codes

LICENSE=	GPLv2

LIB_DEPENDS=	libpcre.so:devel/pcre

USE_CABAL=	colour-2.3.4 base-compat-0.10.5 base-orphans-0.8 unix-compat-0.5.1 \
		conduit-1.3.1 semigroupoids-5.3.2 cabal-doctest-1.0.6 StateVar-1.1.1.1 \
		split-0.2.3.3 bifunctors-5.5.3 contravariant-1.5 safe-0.3.17 \
		regex-base-0.93.2 dlist-0.8.0.5 mono-traversable-1.0.11.0 \
		unicode-show-0.1.0.3 resourcet-1.2.2 profunctors-5.3 \
		utf8-string-1.0.1.1 regex-posix-0.95.2 exceptions-0.10.0 \
		transformers-compat-0.6.2 integer-logarithms-1.0.2.2 yaml-0.11.0.0 \
		libyaml-0.1.0.0 aeson-1.4.2.0 primitive-0.6.4.0 vector-0.12.0.2 \
		comonad-5.0.4 unliftio-core-0.1.2.0 cmdargs-0.10.20 \
		semigroups-0.18.5 scientific-0.3.6.2 tagged-0.8.6 \
		ansi-terminal-0.9 either-5.0.1 uuid-types-1.0.3 \
		time-locale-compat-0.1.1.5 vector-algorithms-0.8.0.1 \
		regex-pcre-0.94.4 attoparsec-0.13.2.2 distributive-0.6 \
		th-abstraction-0.2.10.0 unordered-containers-0.2.10.0 \
		stringsearch-0.3.6.6

.include "${.CURDIR}/../../lang/ghc/bsd.new-cabal.mk"
.include <bsd.port.mk>
