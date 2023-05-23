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
    
    public private(set) var isConnected: Bool = true
        
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: que)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else {return}
            self.isConnected = path.status == .satisfied
            print(self.isConnected)
        }
    }
}
