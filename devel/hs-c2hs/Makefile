# Created by: Oliver Braun <obraun@FreeBSD.org>
# $FreeBSD$

PORTNAME=	c2hs
PORTVERSION=	0.28.6
PORTREVISION=	3
CATEGORIES=	devel haskell

MAINTAINER=	haskell@FreeBSD.org
COMMENT=	C->Haskell FFI tool that gives some cross-language type safety

LICENSE=	GPLv2

USE_CABAL=	alex-3.2.4 dlist-0.8.0.5 happy-1.19.9_3 language-c-0.8.2_1 syb-0.7

BUILD_DEPENDS=	happy:devel/hs-happy

XMLDOCS=	doc/users_guide:html

MAN1PAGES=	c2hs.1
MAN1SRC=	doc/man1

.include "${.CURDIR}/../../lang/ghc/bsd.new-cabal.mk"
.include <bsd.port.mk>
