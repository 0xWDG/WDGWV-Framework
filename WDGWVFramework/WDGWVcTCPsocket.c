//
//  WDGWVcTCPsocket.c
//  WDGFramework
//
//  Created by Wesley de Groot on 21/12/2017.
//  Copyright © 2017 WDGWV. All rights reserved.
//

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <dirent.h>
#include <netdb.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <sys/select.h>

void WDGWVcTCPsocket_set_block(int socket, int on) {
    int flags;
    flags = fcntl(socket, F_GETFL, 0);
    if (on == 0) {
        fcntl(socket, F_SETFL, flags | O_NONBLOCK);
    } else {
        flags &= ~ O_NONBLOCK;
        fcntl(socket, F_SETFL, flags);
    }
}

int WDGWVcTCPsocket_connect(const char *host, int port, int timeout) {
    struct sockaddr_in sa;
    struct hostent *hp;
    int sockfd = -1;
    hp = gethostbyname(host);
    if (hp == NULL) {
        return -1;
    }
    
    bcopy((char *)hp->h_addr, (char *)&sa.sin_addr, hp->h_length);
    sa.sin_family = hp->h_addrtype;
    sa.sin_port = htons(port);
    sockfd = socket(hp->h_addrtype, SOCK_STREAM, 0);
    WDGWVcTCPsocket_set_block(sockfd,0);
    connect(sockfd, (struct sockaddr *)&sa, sizeof(sa));
    fd_set fdwrite;
    struct timeval  tvSelect;
    FD_ZERO(&fdwrite);
    FD_SET(sockfd, &fdwrite);
    tvSelect.tv_sec = timeout;
    tvSelect.tv_usec = 0;
    
    int retval = select(sockfd + 1, NULL, &fdwrite, NULL, &tvSelect);
    if (retval < 0) {
        close(sockfd);
        return -2;
    } else if(retval == 0) {//timeout
        close(sockfd);
        return -3;
    } else {
        int error = 0;
        int errlen = sizeof(error);
        getsockopt(sockfd, SOL_SOCKET, SO_ERROR, &error, (socklen_t *)&errlen);
        if (error != 0) {
            close(sockfd);
            return -4;//connect fail
        }
        
        int set = 1;
        setsockopt(sockfd, SOL_SOCKET, SO_NOSIGPIPE, (void *)&set, sizeof(int));
        return sockfd;
    }
}

int WDGWVcTCPsocket_close(int socketfd){
    return close(socketfd);
}

int WDGWVcTCPsocket_pull(int socketfd, char *data, int len, int timeout_sec) {
    int readlen = 0;
    int datalen = 0;
    if (timeout_sec > 0) {
        fd_set fdset;
        struct timeval timeout;
        timeout.tv_usec = 0;
        timeout.tv_sec = timeout_sec;
        FD_ZERO(&fdset);
        FD_SET(socketfd, &fdset);
        int ret = select(socketfd + 1, &fdset, NULL, NULL, &timeout);
        if (ret <= 0) {
            return ret; // select-call failed or timeout occurred (before anything was sent)
        }
    }
    // use loop to make sure receive all data
    do {
        readlen = (int)read(socketfd, data + datalen, len - datalen);
        if (readlen > 0) {
            datalen += readlen;
        }
    } while (readlen > 0);
    
    return datalen;
}

int WDGWVcTCPsocket_send(int socketfd, const char *data, int len){
    int byteswrite = 0;
    while (len - byteswrite > 0) {
        int writelen = (int)write(socketfd, data + byteswrite, len - byteswrite);
        if (writelen < 0) {
            return -1;
        }
        byteswrite += writelen;
    }
    return byteswrite;
}

//return socket fd
int WDGWVcTCPsocket_listen(const char *address, int port) {
    //create socket
    int socketfd = socket(AF_INET, SOCK_STREAM, 0);
    int reuseon = 1;
    setsockopt(socketfd, SOL_SOCKET, SO_REUSEADDR, &reuseon, sizeof(reuseon));
    
    //bind
    struct sockaddr_in serv_addr;
    memset( &serv_addr, '\0', sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = inet_addr(address);
    serv_addr.sin_port = htons(port);
    int r = bind(socketfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr));
    if (r == 0) {
        if (listen(socketfd, 128) == 0) {
            return socketfd;
        } else {
            return -2;//listen error
        }
    } else {
        return -1;//bind error
    }
}

//return client socket fd
int WDGWVcTCPsocket_accept(int onsocketfd, char *remoteip, int *remoteport, int timeouts) {
    socklen_t clilen;
    struct sockaddr_in  cli_addr;
    clilen = sizeof(cli_addr);
    fd_set fdset;
    FD_ZERO(&fdset);
    FD_SET(onsocketfd, &fdset);
    struct timeval *timeptr = NULL;
    struct timeval timeout;
    if (timeouts > 0) {
        timeout.tv_sec = timeouts;
        timeout.tv_usec = 0;
        timeptr = &timeout;
    }
    int status = select(FD_SETSIZE, &fdset, NULL, NULL, timeptr);
    if (status != 1) {
        return -1;
    }
    int newsockfd = accept(onsocketfd, (struct sockaddr *) &cli_addr, &clilen);
    char *clientip=inet_ntoa(cli_addr.sin_addr);
    memcpy(remoteip, clientip, strlen(clientip));
    *remoteport = cli_addr.sin_port;
    if (newsockfd > 0) {
        int set = 1;
        setsockopt(newsockfd, SOL_SOCKET, SO_NOSIGPIPE, (void*) &set, sizeof(int));
        return newsockfd;
    } else {
        return -1;
    }
}

//return socket port
int WDGWVcTCPsocket_port(int socketfd) {
    struct sockaddr_in sin;
    socklen_t len = sizeof(sin);
    if (getsockname(socketfd, (struct sockaddr *)&sin, &len) == -1) {
        return -1;
    } else {
        return ntohs(sin.sin_port);
    }
}
