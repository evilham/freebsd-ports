# Created by: Oliver Braun <obraun@FreeBSD.org>
# $FreeBSD$

PORTNAME=	darcs
PORTVERSION=	2.14.2
CATEGORIES=	devel haskell

MAINTAINER=	haskell@FreeBSD.org
COMMENT=	Distributed, interactive, smart revision control system

LICENSE=	GPLv2

USES=		cabal

OPTIONS_DEFINE=		CURL TERMINFO THREADED
OPTIONS_DEFAULT=	CURL TERMINFO THREADED

CURL_DESC=		Use libcurl for HTTP support
CURL_FLAG_ENABLE=	curl
CURL_LIB_DEPENDS=	libcurl.so:ftp/curl

TERMINFO_DESC=		Use terminfo library for enhanced console support
TERMINFO_CABAL_FLAGS=	terminfo

THREADED_DESC=		Use threading and SMP support
THREADED_CABAL_FLAGS=	threaded

USE_CABAL=	attoparsec-0.13.2.2_2 base-compat-0.10.5 basement-0.0.10_1 \
		byteable-0.1.1 colour-2.3.4 conduit-1.3.1.1 cryptohash-0.11.9 \
		cryptonite-0.25 data-ordlist-0.4.7.0 dlist-0.8.0.5 \
		exceptions-0.10.0_2 fgl-5.7.0.1 graphviz-2999.20.0.3 html-1.0.1.2 \
		integer-logarithms-1.0.2.2_1 memory-0.14.18_1 mmap-0.5.9 \
		mono-traversable-1.0.11.0 polyparse-1.12.1 primitive-0.6.4.0_1 \
		regex-applicative-0.3.3 regex-base-0.93.2 \
		regex-compat-tdfa-0.95.1.4 regex-tdfa-1.2.3.1 resourcet-1.2.2 \
		sandi-0.5 scientific-0.3.6.2 split-0.2.3.3_1 temporary-1.3 \
		transformers-compat-0.6.2 unix-compat-0.5.1 \
		unliftio-core-0.1.2.0_1 unordered-containers-0.2.10.0 \
		utf8-string-1.0.1.1_3 vector-0.12.0.2 vector-algorithms-0.8.0.1 \
		wl-pprint-text-1.2.0.0

CABAL_FLAGS=	pkgconfig executable optimize

MAN1PAGES=	darcs.1

.include <bsd.port.mk>
