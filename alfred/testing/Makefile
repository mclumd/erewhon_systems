INC	=/fs/metacog/group/systems/quintus3.5/generic/qplib3.5/IPC/TCP
TCPLIB	= /fs/metacog/group/systems/quintus3.5/generic/qplib3.5/IPC/TCP/linux/tcp_p.so
TCPLIB	= /fs/metacog/group/systems/quintus3.5/generic/qplib3.5/IPC/TCP/tcp_p.so
TCPLIB	= /fs/metacog/group/systems/quintus3.5/generic/qplib3.5/IPC/TCP/tcp.o
#LIBS	=-lsocket -lm
all:	testrover.c 
	gcc -I${INC} ${TCPLIB} ${LIBS} -o testrover testrover.c  
