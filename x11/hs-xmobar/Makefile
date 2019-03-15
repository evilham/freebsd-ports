# Created by: Samy Al Bahra <sbahra@kerneled.org>
# $FreeBSD$

PORTNAME=	xmobar
PORTVERSION=	0.29.4
PORTREVISION=	3
CATEGORIES=	x11 haskell

MAINTAINER=	haskell@FreeBSD.org
COMMENT=	Minimalistic text-based status bar

LICENSE=	BSD3CLAUSE

USE_CABAL=	HTTP>=4000.2.4 async extensible-exceptions http-conduit \
		mtl>=2.1 regex-compat X11>=1.6.1 parsec-numbers
USE_XORG=	x11 xext xinerama xpm xrandr xrender

OPTIONS_DEFINE=	EXAMPLES

INSTALL_PORTEXAMPLES=	${INSTALL_DATA} ${WRKSRC}/examples/xmobar.config \
				${STAGEDIR}${EXAMPLESDIR}

FLAGS_DEFINE=		XFT UTF8 MPD INOTIFY DATEZONE THREADED
FLAGS_DEFAULT=		XFT UTF8

XFT_DESC=		Use Xft to render text (UTF-8 support included)
XFT_FLAG_ENABLE=	with_xft
XFT_FLAG_CABAL=		utf8-string X11-xft>=0.2
XFT_USE_XORG=		xft

UTF8_DESC=		UTF-8 support
UTF8_FLAG_ENABLE=	with_utf8
UTF8_FLAG_CABAL=	utf8-string

MPD_DESC=		mpd support
MPD_FLAG_ENABLE=	with_mpd
MPD_FLAG_CABAL=		libmpd

INOTIFY_DESC=		inotify support
INOTIFY_FLAG_ENABLE=	with_inotify
INOTIFY_FLAG_CABAL=	hinotify>=0.3

DATEZONE_DESC=		Localized date support
DATEZONE_FLAG_ENABLE=	with_datezone
DATEZONE_FLAG_CABAL=	timezone-olson>=0.1 timezone-series>=0.1

THREADED_DESC=		Use threaded runtime
THREADED_FLAG_ENABLE=	with_threaded

# Disable unsupported options and enable new default ones
FLAGS_ENABLE=		with_weather
FLAGS_DISABLE=		with_mpris with_dbus with_iwlib with_alsa

USE_CABAL=	X11-1.9 data-default-0.7.1.1 data-default-class-0.1.2.0 \
		data-default-instances-containers-0.0.1 \
		data-default-instances-dlist-0.0.1 \
		data-default-instances-old-locale-0.0.1 dlist-0.8.0.5 \
		extensible-exceptions-0.1.1.4 parsec-numbers-0.1.0 \
		regex-base-0.93.2 regex-compat-0.95.1 regex-posix-0.95.2 \
		utf8-string-1.0.1.1_3

USE_XORG=	xrandr xrender xscrnsaver xinerama xext x11

.include "${.CURDIR}/../../lang/ghc/bsd.new-cabal.mk"
.include <bsd.port.mk>
