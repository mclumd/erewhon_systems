#ifndef __PLAYER_CPP_CONFIG_H__
#define __PLAYER_CPP_CONFIG_H__

#define HAVE_BOOST_THREAD 1
#define HAVE_BOOST_SIGNALS 1

#if defined (HAVE_BOOST_THREAD)
#define _POSIX_PTHREAD_SEMANTICS
#if !defined(_REENTRANT)
#define _REENTRANT
#endif
#endif

#endif
