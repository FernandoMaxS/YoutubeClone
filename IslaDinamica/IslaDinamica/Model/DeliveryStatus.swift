//
//  DeliveryStatus.swift
//  IslaDinamica
//
//  Created by Fernando Maximiliano on 27/06/23.
//

import Foundation

enum DeliveryStatus: String, Codable {
    case pending = ""
    case sent = "Enviado"
    case inTransit = "En Reparto"
    case delivered = "Entregado"
}
