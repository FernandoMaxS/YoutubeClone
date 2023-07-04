//
//  DeliveryAttributes.swift
//  IslaDinamica
//
//  Created by Fernando Maximiliano on 27/06/23.
//

import Foundation
import ActivityKit


struct DeliveryAttributes: ActivityAttributes{
    public struct ContentState: Codable, Hashable {
        var deliveryStatus: DeliveryStatus
        var productName: String
        var estimatedArrivalDate: String
    }
    
    
    
}
