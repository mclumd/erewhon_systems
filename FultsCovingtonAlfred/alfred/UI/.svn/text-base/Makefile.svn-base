SRC         = src
INC         = /fs/metacog/group/systems/quintus3.5/generic/qplib3.5/IPC/TCP
OBJ         = obj
BIN         = .
CC          = gcc
CFLAGS      = -c -g -O
CLDFLAGS    = -O -g

OBJECTS     = ${OBJ}/getutterance.o 


INCLUDES    = ${INC}/tcp.h

LIBS = -L/usr/ucblib -lucb -lsocket -lnsl -lelf
LIBS = -L/fs/metacog/group/systems/quintus3.5/generic/qplib3.5/library/linux

#this is ok, need to find the right LIBS 
TCPLIB = /fs/metacog/group/systems/quintus3.5/generic/qplib3.5/IPC/TCP/linux/tcp_p.so
TCPLIB = /fs/metacog/group/systems/quintus3.5/generic/qplib3.5/IPC/TCP/tcp_p.so
TCPLIB = /fs/metacog/group/systems/quintus3.5/generic/qplib3.5/IPC/TCP/tcp.o


${BIN}/getutterance: ${OBJECTS} ${TCPLIB}  ${INCLUDES}
		${CC} ${CLDFLAGS} ${OBJECTS} ${TCPLIB} ${LIBS} -o ${BIN}/getutterance

${OBJ}/getutterance.o: ${SRC}/getutterance.c  ${INCLUDES}
		${CC} ${CFLAGS} -I${INC} ${SRC}/getutterance.c -o ${OBJ}/getutterance.o

clean:
	/bin/rm ${OBJ}/*.o




