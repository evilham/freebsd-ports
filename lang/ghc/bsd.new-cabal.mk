DISTFILES=	${DISTNAME}-builddata${EXTRACT_SUFX}

GHC_VERSION?=	8.6.3
GHC_ARCH=	${ARCH:S/amd64/x86_64/:C/armv.*/arm/}

CABAL_HOME=	${WRKDIR}/cabal-home

BUILD_DEPENDS=	cabal:devel/hs-cabal-install

# Inherited via lang/ghc we need to depend on iconv and libgmp.so (stage q/a)
USES+=		iconv:translit tar:xz
LIB_DEPENDS+=	libgmp.so:math/gmp \
		libffi.so.6:devel/libffi

PLIST_FILES=	bin/${PORTNAME}

# Fetches and unpacks package source from Hackage using only PORTNAME and PORTVERSION.
cabal-extract:
	mkdir -p ${WRKDIR}
	${SETENV} HOME=${CABAL_HOME} cabal new-update
	cd ${WRKDIR} && \
		${SETENV} HOME=${CABAL_HOME} cabal get ${PORTNAME}-${PORTVERSION}

# Fetches and unpacks dependencies sources for a cabal-extract'ed package.
# Builds them as side-effect.
cabal-extract-deps:
	cd ${WRKSRC} && \
		${SETENV} HOME=${CABAL_HOME} cabal new-configure
	cd ${WRKSRC} && \
		${SETENV} HOME=${CABAL_HOME} cabal new-build --dependencies-only

# After fetching dependencies, removes unnecessary stuff from cabal cache and
# packs it along with WRKSRC into a tar.xz.
cabal-makesum:
	rm -rf ${CABAL_HOME}/.cabal/logs
	rm -rf ${CABAL_HOME}/.cabal/store
	rm -rf ${CABAL_HOME}/.cabal/packages/hackage.haskell.org/01-index.tar
	rm -rf ${CABAL_HOME}/.cabal/packages/hackage.haskell.org/01-index.tar.gz
	rm -rf ${CABAL_HOME}/.cabal/packages/hackage.haskell.org/01-index.tar.idx
	rm -rf ${WRKSRC}/dist

	tar -C ${WRKDIR} -ca -f /tmp/${PORTNAME}-${PORTVERSION}-builddata.tar.xz ${PORTNAME}-${PORTVERSION} cabal-home

	cd /tmp \
		&& sha256 ${PORTNAME}-${PORTVERSION}-builddata.tar.xz \
		&& ${ECHO} -n "SIZE (${PORTNAME}-${PORTVERSION}-builddata.tar.xz) = " \
		&& ${STAT} -f %z ${PORTNAME}-${PORTVERSION}-builddata.tar.xz

do-build:
	cd ${WRKSRC} && \
		${SETENV} HOME=${CABAL_HOME} cabal new-build --offline

do-install:
	${INSTALL_PROGRAM} \
		${WRKSRC}/dist-newstyle/build/${GHC_ARCH}-freebsd/ghc-${GHC_VERSION}/${PORTNAME}-${PORTVERSION}/x/${PORTNAME}/build/${PORTNAME}/${PORTNAME} \
		${STAGEDIR}${PREFIX}/bin/