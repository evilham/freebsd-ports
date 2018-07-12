# Created by: Li-Wen Hsu <lwhsu@FreeBSD.org>
# $FreeBSD$

PORTNAME=	cgrep
PORTVERSION=	6.6.25
PORTREVISION=	2
CATEGORIES=	textproc

MAINTAINER=	lwhsu@FreeBSD.org
COMMENT=	Context-aware grep for source codes

LICENSE=	GPLv2

BUILD_DEPENDS=	cabal:devel/hs-cabal-install

USES=		tar:xz

DISTFILES=	${DISTNAME}-builddata${EXTRACT_SUFX}

.include "${.CURDIR}/bsd.new-cabal.mk"
.include <bsd.port.mk>
