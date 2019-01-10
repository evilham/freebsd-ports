DISTFILES=	${DISTNAME}-builddata${EXTRACT_SUFX}

EXECUTABLES?=	${PORTNAME}

GHC_VERSION?=	8.6.3
GHC_ARCH=	${ARCH:S/amd64/x86_64/:C/armv.*/arm/}

CABAL_HOME=	${WRKDIR}/cabal-home

BUILD_DEPENDS=	cabal:devel/hs-cabal-install

# Inherited via lang/ghc we need to depend on iconv and libgmp.so (stage q/a)
USES+=		iconv:translit tar:xz
LIB_DEPENDS+=	libgmp.so:math/gmp \
		libffi.so.6:devel/libffi

#PLIST_FILES=	bin/${PORTNAME}

.include <bsd.port.options.mk>

# Fetches and unpacks package source from Hackage using only PORTNAME and PORTVERSION.
cabal-extract:
	mkdir -p ${WRKDIR}
	${SETENV} HOME=${CABAL_HOME} cabal new-update
	cd ${WRKDIR} && \
		${SETENV} HOME=${CABAL_HOME} cabal get ${PORTNAME}-${PORTVERSION}

cabal-patch:
	for patch in ${PATCHDIR}/pre-makesum-patch*; do \
		${PATCH} -d ${WRKSRC} -i $${patch} ;\
	done

# Fetches and unpacks dependencies sources for a cabal-extract'ed package.
# Builds them as side-effect.
cabal-extract-deps:
	cd ${WRKSRC} && \
		${SETENV} HOME=${CABAL_HOME} cabal new-configure --flags="${CABAL_FLAGS}" ${CONFIGURE_ARGS}
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
	find ${WRKSRC} -name '*.orig' -delete

	tar -C ${WRKDIR} -ca -f /tmp/${PORTNAME}-${PORTVERSION}-builddata.tar.xz ${PORTNAME}-${PORTVERSION} cabal-home

	cd /tmp \
		&& sha256 ${PORTNAME}-${PORTVERSION}-builddata.tar.xz \
		&& ${ECHO} -n "SIZE (${PORTNAME}-${PORTVERSION}-builddata.tar.xz) = " \
		&& ${STAT} -f %z ${PORTNAME}-${PORTVERSION}-builddata.tar.xz

do-build:
	cd ${WRKSRC} && \
		${SETENV} HOME=${CABAL_HOME} cabal new-build --offline ${BUILD_ARGS}

do-install:
.	for exe in ${EXECUTABLES}
# 	if [ -d ${WRKSRC}/dist-newstyle/build/${GHC_ARCH}-freebsd/ghc-${GHC_VERSION}/${PORTNAME}-${PORTVERSION}/x ]; then \
# 		${INSTALL_PROGRAM} \
# 			${WRKSRC}/dist-newstyle/build/${GHC_ARCH}-freebsd/ghc-${GHC_VERSION}/${PORTNAME}-${PORTVERSION}/x/${PORTNAME}/build/${exe}/${exe} \
# 			${STAGEDIR}${PREFIX}/bin/ ;\
# 	else \
# 		${INSTALL_PROGRAM} \
# 			${WRKSRC}/dist-newstyle/build/${GHC_ARCH}-freebsd/ghc-${GHC_VERSION}/${PORTNAME}-${PORTVERSION}/build/${exe}/${exe} \
# 			${STAGEDIR}${PREFIX}/bin/ ;\
# 	fi
	${INSTALL_PROGRAM} \
		`find ${WRKSRC}/dist-newstyle -name ${exe} -type f -perm +111` \
		${STAGEDIR}${PREFIX}/bin/
.	endfor

.	if !empty(INSTALL_PORTDATA)
		@${MKDIR} ${STAGEDIR}${DATADIR}
		${INSTALL_PORTDATA}
.	endif

.	if !empty(INSTALL_PORTEXAMPLES) && ${PORT_OPTIONS:MEXAMPLES}
		@${MKDIR} ${STAGEDIR}${EXAMPLESDIR}
		${INSTALL_PORTEXAMPLES}
.	endif

.if !target(post-install-script)
post-install-script:
.	for exe in ${EXECUTABLES}
		${ECHO_CMD} 'bin/${exe}' >> ${TMPPLIST}
.	endfor
.endif
