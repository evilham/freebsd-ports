# Created by: Volker Stolz <stolz@i2.informatik.rwth-aachen.de>
# $FreeBSD$

PORTNAME=	alex
PORTVERSION=	3.2.4
CATEGORIES=	devel haskell

MAINTAINER=	haskell@FreeBSD.org
COMMENT=	Tool for generating lexical analysers in Haskell

LICENSE=	BSD3CLAUSE

USES=		cabal

OPTIONS_DEFINE=	EXAMPLES

INSTALL_PORTEXAMPLES=	cd ${WRKSRC}/examples/ && ${COPYTREE_SHARE} \* ${STAGEDIR}${EXAMPLESDIR}

.include <bsd.port.mk>
