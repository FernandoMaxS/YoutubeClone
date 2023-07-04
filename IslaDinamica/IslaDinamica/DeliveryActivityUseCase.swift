//
//  DeliveryActivityUseCase.swift
//  IslaDinamica
//
//  Created by Fernando Maximiliano on 27/06/23.
//

import Foundation
import ActivityKit

final class DeliveryActivityUseCase {
    static func startActivity(deliveryStatus: DeliveryStatus,
                              productName: String,
                              estimatedArrivalDate: String ) throws -> String {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else { return "" }
        
        let initialState = DeliveryAttributes.ContentState(deliveryStatus: deliveryStatus,
                                                           productName: productName,
                                                           estimatedArrivalDate: estimatedArrivalDate)
        let futureDate: Date = .now + 3600
        let activityContent = ActivityContent(state:initialState,
                                              staleDate: futureDate)
        
        let attributes = DeliveryAttributes()
        do {
            let activity = try Activity.request(attributes: attributes, content: activityContent)
            return activity.id
        }catch{
            throw error
        }
        
        
        
    }
    
    static func updateActivity(activityIdentifier: String,
                               newDeliveryStatus: DeliveryStatus,
                               productName: String,
                               estimatedArrivalDate: String ) async {
        let updateContentState = DeliveryAttributes.ContentState(deliveryStatus: newDeliveryStatus,
                                                                 productName: productName,
                                                                 estimatedArrivalDate: estimatedArrivalDate)
        
        let activity = Activity<DeliveryAttributes>.activities.first(where: {$0.id == activityIdentifier})
        let actiityContent = ActivityContent(state: updateContentState, staleDate: .now + 3600)
        
        await activity?.update(actiityContent)
        
    }
    
    static func endActivity(withActivityIdentifier activityIndentifier: String) async {
        let activity = Activity<DeliveryAttributes>.activities.first(where: {$0.id == activityIndentifier})
        await activity?.end(nil)
    }
}
