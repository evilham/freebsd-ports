--- aclocal.m4.orig	2019-08-25 12:03:36 UTC
+++ aclocal.m4
@@ -985,8 +985,6 @@ else
 fi;
 changequote([, ])dnl
 ])
-FP_COMPARE_VERSIONS([$fptools_cv_alex_version],[-lt],[3.1.7],
-  [AC_MSG_ERROR([Alex version 3.1.7 or later is required to compile GHC.])])[]
 AlexVersion=$fptools_cv_alex_version;
 AC_SUBST(AlexVersion)
 ])
