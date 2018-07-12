CABAL_HOME=	${WRKDIR}/cabal-home

# Fetches package sources from Hackage using only PORTNAME and PORTVERSION
cabal-extract:
	mkdir ${WRKDIR}
	${SETENV} HOME=${CABAL_HOME} cabal new-update
	cd ${WRKDIR} && \
		${SETENV} HOME=${CABAL_HOME} cabal get ${PORTNAME}-${PORTVERSION}

# Fetches dependencies sources for a cabal-extract'ed package. Builds them as
# side-effect.
# After that, removes unnecessary stuff from cabal cache and packs it along with
# WRKSRC into a tar.xz.
cabal-makesum:
	cd ${WRKSRC} && \
		${SETENV} HOME=${CABAL_HOME} cabal new-configure
	cd ${WRKSRC} && \
		${SETENV} HOME=${CABAL_HOME} cabal new-build --dependencies-only

	rm -rf ${CABAL_HOME}/.cabal/logs
	rm -rf ${CABAL_HOME}/.cabal/store
	rm -rf ${CABAL_HOME}/.cabal/packages/hackage.haskell.org/01-index.tar
	rm -rf ${CABAL_HOME}/.cabal/packages/hackage.haskell.org/01-index.tar.gz
	rm -rf ${CABAL_HOME}/.cabal/packages/hackage.haskell.org/01-index.tar.idx
	rm -rf ${WRKSRC}/dist
	rm -rf ${WRKSRC}/dist-newstyle

	tar -C ${WRKDIR} -ca -f /tmp/${PORTNAME}-${PORTVERSION}-builddata.tar.xz ${PORTNAME}-${PORTVERSION} cabal-home

	cd /tmp \
		&& sha256 ${PORTNAME}-${PORTVERSION}-builddata.tar.xz \
		&& ${ECHO} -n "SIZE (${PORTNAME}-${PORTVERSION}-builddata.tar.xz) = " \
		&& ${STAT} -f %z ${PORTNAME}-${PORTVERSION}-builddata.tar.xz

do-build:
	cd ${WRKSRC} && \
		${SETENV} HOME=${CABAL_HOME} cabal new-build --offline