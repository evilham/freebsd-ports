# Created by: mainland@apeiron.net
# $FreeBSD$

PORTNAME=	lhs2tex
PORTVERSION=	1.22
PORTREVISION=	3
CATEGORIES=	textproc haskell

MAINTAINER=	haskell@FreeBSD.org
COMMENT=	Preprocessor for typesetting Haskell sources with LaTeX

LICENSE=	GPLv2

USE_TEX=	latex dvipsk

EXECUTABLES=	lhs2TeX

USE_CABAL=	regex-base-0.93.2 regex-compat-0.95.1 regex-posix-0.95.2

.include "${.CURDIR}/../../lang/ghc/bsd.new-cabal.mk"
.include <bsd.port.mk>
