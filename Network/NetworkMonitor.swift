//
//  NetworkMonitor.swift
//  ChatApp
//
//  Created by bakhva  on 17.05.23.
//

import Foundation
import Network

final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    private let que = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    public private(set) var connectionType: ConnectionType = .unknown
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: que)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else {return}
            self.isConnected = path.status == .satisfied
            self.getConnectionType(path)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .wiredEthernet
        } else {
            connectionType = .unknown
        }
    }
}

extension NetworkMonitor {
    enum ConnectionType {
        case wifi
        case cellular
        case wiredEthernet
        case unknown
    }
}
