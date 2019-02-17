# $FreeBSD$

PORTNAME=	threadscope
PORTVERSION=	0.2.11.1
PORTREVISION=	2
CATEGORIES=	devel haskell

MAINTAINER=	haskell@FreeBSD.org
COMMENT=	Graphical tool for profiling parallel Haskell programs

LICENSE=	BSD3CLAUSE

BROKEN=		gtkhs-buildtools is unable to parse C11 in our system includes

.include "${.CURDIR}/../../lang/ghc/bsd.new-cabal.mk"
.include <bsd.port.mk>
