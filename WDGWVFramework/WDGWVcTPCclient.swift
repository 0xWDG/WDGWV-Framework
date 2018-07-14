//
//  WDGWVcTPCclient.swift
//  WDGFramework
//
//  Created by Wesley de Groot on 21/12/2017.
//  Copyright © 2017 WDGWV. All rights reserved.
//

import Foundation

import Foundation

@_silgen_name("WDGWVcTCPsocket_connect") private func c_WDGWVcTCPsocket_connect(_ host:UnsafePointer<Byte>,port:Int32,timeout:Int32) -> Int32
@_silgen_name("WDGWVcTCPsocket_close") private func c_WDGWVcTCPsocket_close(_ fd:Int32) -> Int32
@_silgen_name("WDGWVcTCPsocket_send") private func c_WDGWVcTCPsocket_send(_ fd:Int32,buff:UnsafePointer<Byte>,len:Int32) -> Int32
@_silgen_name("WDGWVcTCPsocket_pull") private func c_WDGWVcTCPsocket_pull(_ fd:Int32,buff:UnsafePointer<Byte>,len:Int32,timeout:Int32) -> Int32
@_silgen_name("WDGWVcTCPsocket_listen") private func c_WDGWVcTCPsocket_listen(_ address:UnsafePointer<Int8>,port:Int32)->Int32
@_silgen_name("WDGWVcTCPsocket_accept") private func c_WDGWVcTCPsocket_accept(_ onsocketfd:Int32,ip:UnsafePointer<Int8>,port:UnsafePointer<Int32>,timeout:Int32) -> Int32
@_silgen_name("WDGWVcTCPsocket_port") private func c_WDGWVcTCPsocket_port(_ fd:Int32) -> Int32

open class TCPClient: Socket {
    
    /*
     * connect to server
     * return success or fail with message
     */
    open func connect(timeout: Int) -> Result {
        let rs: Int32 = c_WDGWVcTCPsocket_connect(self.address, port: Int32(self.port), timeout: Int32(timeout))
        if rs > 0 {
            self.fd = rs
            return .success
        } else {
            switch rs {
            case -1:
                return .failure(SocketError.queryFailed)
            case -2:
                return .failure(SocketError.connectionClosed)
            case -3:
                return .failure(SocketError.connectionTimeout)
            default:
                return .failure(SocketError.unknownError)
            }
        }
    }
    
    /*
     * close socket
     * return success or fail with message
     */
    open func close() {
        guard let fd = self.fd else { return }
        
        _ = c_WDGWVcTCPsocket_close(fd)
        self.fd = nil
    }
    
    /*
     * send data
     * return success or fail with message
     */
    open func send(data: [Byte]) -> Result {
        guard let fd = self.fd else { return .failure(SocketError.connectionClosed) }
        
        let sendsize: Int32 = c_WDGWVcTCPsocket_send(fd, buff: data, len: Int32(data.count))
        if Int(sendsize) == data.count {
            return .success
        } else {
            return .failure(SocketError.unknownError)
        }
    }
    
    /*
     * send string
     * return success or fail with message
     */
    open func send(string: String) -> Result {
        guard let fd = self.fd else { return .failure(SocketError.connectionClosed) }
        
        let sendsize = c_WDGWVcTCPsocket_send(fd, buff: string, len: Int32(strlen(string)))
        if sendsize == Int32(strlen(string)) {
            return .success
        } else {
            return .failure(SocketError.unknownError)
        }
    }
    
    /*
     *
     * send nsdata
     */
    open func send(data: Data) -> Result {
        guard let fd = self.fd else { return .failure(SocketError.connectionClosed) }
        
        var buff = [Byte](repeating: 0x0,count: data.count)
        (data as NSData).getBytes(&buff, length: data.count)
        let sendsize = c_WDGWVcTCPsocket_send(fd, buff: buff, len: Int32(data.count))
        if sendsize == Int32(data.count) {
            return .success
        } else {
            return .failure(SocketError.unknownError)
        }
    }
    
    /*
     * read data with expect length
     * return success or fail with message
     */
    open func read(_ expectlen: Int, timeout: Int = 10) -> [Byte]? {
        guard let fd:Int32 = self.fd else {
            print("FD Missing")
            return nil
        }
        
        var buff = [Byte](repeating: 0x0,count: expectlen)
        let readLen = c_WDGWVcTCPsocket_pull(fd, buff: &buff, len: Int32(expectlen), timeout: Int32(timeout))
        if readLen <= 0 { return nil }
        let rs = buff[0...Int(readLen-1)]
        let data: [Byte] = Array(rs)
        
        return data
    }
}

open class TCPServer: Socket {
    
    open func listen() -> Result {
        let fd = c_WDGWVcTCPsocket_listen(self.address, port: Int32(self.port))
        if fd > 0 {
            self.fd = fd
            
            // If port 0 is used, get the actual port number which the server is listening to
            if (self.port == 0) {
                let p = c_WDGWVcTCPsocket_port(fd)
                if (p == -1) {
                    return .failure(SocketError.unknownError)
                } else {
                    self.port = p
                }
            }
            
            return .success
        } else {
            return .failure(SocketError.unknownError)
        }
    }
    
    open func accept(timeout :Int32 = 0) -> TCPClient? {
        guard let serferfd = self.fd else { return nil }
        
        var buff: [Int8] = [Int8](repeating: 0x0,count: 16)
        var port: Int32 = 0
        let clientfd: Int32 = c_WDGWVcTCPsocket_accept(serferfd, ip: &buff, port: &port, timeout: timeout)
        
        guard clientfd >= 0 else { return nil }
        guard let address = String(cString: buff, encoding: String.Encoding.utf8) else { return nil }
        
        let client = TCPClient(address: address, port: port)
        client.fd = clientfd
        
        return client
    }
    
    open func close() {
        guard let fd: Int32=self.fd else { return }
        
        _ = c_WDGWVcTCPsocket_close(fd)
        self.fd = nil
    }
}
