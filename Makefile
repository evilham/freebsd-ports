# $FreeBSD$
#

SUBDIR += accessibility
SUBDIR += arabic
SUBDIR += archivers
SUBDIR += astro
SUBDIR += audio
SUBDIR += benchmarks
SUBDIR += biology
SUBDIR += cad
SUBDIR += chinese
SUBDIR += comms
SUBDIR += converters
SUBDIR += databases
SUBDIR += deskutils
SUBDIR += devel
SUBDIR += dns
SUBDIR += editors
SUBDIR += emulators
SUBDIR += finance
SUBDIR += french
SUBDIR += ftp
SUBDIR += games
SUBDIR += german
SUBDIR += graphics
SUBDIR += hebrew
SUBDIR += hungarian
SUBDIR += irc
SUBDIR += japanese
SUBDIR += java
SUBDIR += korean
SUBDIR += lang
SUBDIR += mail
SUBDIR += math
SUBDIR += mbone
SUBDIR += misc
SUBDIR += multimedia
SUBDIR += net
SUBDIR += net-mgmt
SUBDIR += news
SUBDIR += palm
SUBDIR += picobsd
SUBDIR += polish
SUBDIR += portuguese
SUBDIR += print
SUBDIR += russian
SUBDIR += science
SUBDIR += security
SUBDIR += shells
SUBDIR += sysutils
SUBDIR += textproc
SUBDIR += ukrainian
SUBDIR += vietnamese
SUBDIR += www
SUBDIR += x11
SUBDIR += x11-clocks
SUBDIR += x11-fm
SUBDIR += x11-fonts
SUBDIR += x11-servers
SUBDIR += x11-themes
SUBDIR += x11-toolkits
SUBDIR += x11-wm

PORTSTOP=	yes

.include <bsd.port.subdir.mk>

index:
	@rm -f ${.CURDIR}/${INDEXFILE}
	@cd ${.CURDIR} && make ${.CURDIR}/${INDEXFILE}

fetchindex:
	@cd ${.CURDIR} && fetch -am http://www.FreeBSD.org/ports/${INDEXFILE} && chmod a+r ${INDEXFILE}

INDEX_JOBS?=	2

.if !defined(INDEX_VERBOSE)
INDEX_ECHO_MSG=		echo > /dev/null
INDEX_ECHO_1ST=		echo -n
.else
INDEX_ECHO_MSG=		echo 1>&2
INDEX_ECHO_1ST=		echo
.endif

${.CURDIR}/${INDEXFILE}:
	@${INDEX_ECHO_1ST} "Generating ${INDEXFILE} - please wait.."; \
	if [ "${INDEX_PRISTINE}" != "" ]; then \
		export LOCALBASE=/nonexistentlocal; \
		export X11BASE=/nonexistentx; \
	fi; \
	tmpdir=`/usr/bin/mktemp -d -t index` || exit 1; \
	trap "rm -rf $${tmpdir}; exit 1" 1 2 3 5 10 13 15; \
	( cd ${.CURDIR} && make -j${INDEX_JOBS} INDEX_TMPDIR=$${tmpdir} BUILDING_INDEX=1 \
		ECHO_MSG="${INDEX_ECHO_MSG}" describe ) || \
		(rm -rf $${tmpdir} ; \
		if [ "${INDEX_QUIET}" = "" ]; then \
			echo; \
			echo "********************************************************************"; \
			echo "Before reporting this error, verify that you are running a supported"; \
			echo "version of FreeBSD (see http://www.FreeBSD.org/ports/) and that you"; \
			echo "have a complete and up-to-date ports collection.  (INDEX builds are"; \
			echo "not supported with partial or out-of-date ports collections -- in"; \
			echo "particular, if you are using cvsup, you must cvsup the \"ports-all\""; \
			echo "collection, and have no \"refuse\" files.)  If that is the case, then"; \
			echo "report the failure to ports@FreeBSD.org together with relevant"; \
			echo "details of your ports configuration (including FreeBSD version,"; \
			echo "your architecture, your environment, and your /etc/make.conf"; \
			echo "settings, especially compiler flags and WITH/WITHOUT settings)."; \
			echo; \
			echo "Note: the latest pre-generated version of INDEX may be fetched"; \
			echo "automatically with \"make fetchindex\"."; \
			echo "********************************************************************"; \
			echo; \
		fi; \
		exit 1); \
	cat $${tmpdir}/${INDEXFILE}.desc.* | perl ${.CURDIR}/Tools/make_index | \
		sed -e 's/  */ /g' -e 's/|  */|/g' -e 's/  *|/|/g' -e 's./..g' | \
		sort -t '|' +1 -2 | \
		sed -e 's../.g' > ${.CURDIR}/${INDEXFILE}.tmp; \
	if [ "${INDEX_PRISTINE}" != "" ]; then \
		sed -e "s,$${LOCALBASE},/usr/local," -e "s,$${X11BASE},/usr/X11R6," \
			${.CURDIR}/${INDEXFILE}.tmp > ${.CURDIR}/${INDEXFILE}; \
	else \
		mv ${.CURDIR}/${INDEXFILE}.tmp ${.CURDIR}/${INDEXFILE}; \
	fi; \
	rm -rf $${tmpdir}; \
	echo " Done."

print-index:	${.CURDIR}/${INDEXFILE}
	@awk -F\| '{ printf("Port:\t%s\nPath:\t%s\nInfo:\t%s\nMaint:\t%s\nIndex:\t%s\nB-deps:\t%s\nR-deps:\t%s\nE-deps:\t%s\nP-deps:\t%s\nF-deps:\t%s\nWWW:\t%s\n\n", $$1, $$2, $$4, $$6, $$7, $$8, $$9, $$11, $$12, $$13, $$10); }' < ${.CURDIR}/${INDEXFILE}

CVS?= cvs
SUP?= cvsup
.if defined(SUPHOST)
SUPFLAGS+=	-h ${SUPHOST}
.endif
update:
.if defined(SUP_UPDATE) && defined(PORTSSUPFILE)
	@echo "--------------------------------------------------------------"
	@echo ">>> Running ${SUP}"
	@echo "--------------------------------------------------------------"
	@${SUP} ${SUPFLAGS} ${PORTSSUPFILE}
.elif defined(CVS_UPDATE)
	@echo "--------------------------------------------------------------"
	@echo ">>> Updating ${.CURDIR} from cvs repository" ${CVSROOT}
	@echo "--------------------------------------------------------------"
	cd ${.CURDIR}; ${CVS} -R -q update -A -P -d
.elif defined(SUP_UPDATE) && !defined(PORTSSUPFILE)
	@${ECHO_MSG} "Error: Please define PORTSSUPFILE before doing make update."
	@exit 1
.else
	@${ECHO_MSG} "Error: Please define either SUP_UPDATE or CVS_UPDATE first."
.endif
