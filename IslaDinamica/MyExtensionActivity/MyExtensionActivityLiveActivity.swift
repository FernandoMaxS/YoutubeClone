//
//  MyExtensionActivityLiveActivity.swift
//  MyExtensionActivity
//
//  Created by Fernando Maximiliano on 27/06/23.
//

import ActivityKit
import WidgetKit
import SwiftUI


@main
struct MyExtensionActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DeliveryAttributes.self) { context in
            // Lock screen/banner UI goes here
            HStack {
                Image(systemName: "box.truck.badge.clock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.indigo)
                    .padding(.leading, 12)
                VStack(alignment: .leading){
                    Text(context.state.productName)
                        .bold()
                    + Text(" estado: ")
                    + Text(context.state.deliveryStatus.rawValue).bold()
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("Hora de entrega")
                    Text(context.state.estimatedArrivalDate).bold()
                }
                .padding(.trailing, 12)
            }
            

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "box.truck.badge.clock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.leading, 12)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.productName)
                        .bold()
                        .multilineTextAlignment(.center)
                }
               
                DynamicIslandExpandedRegion(.center) {
                    Text("Paquete: \(context.state.deliveryStatus.rawValue)")
                        
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Button {
                        //
                    } label: {
                        Label("Cancelar Pedido", systemImage: "xmark.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                        
                }
            } compactLeading: {
                HStack{
                    Image(systemName: "box.truck.badge.clock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text(context.state.productName)
                }
                
            } compactTrailing: {
                Text(context.state.deliveryStatus.rawValue)
            } minimal: {
                Image(systemName: "box.truck.badge.clock.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.green)
            }

             
        }
    }
}

struct MyExtensionActivityLiveActivity_Previews: PreviewProvider {
    static let attributes = DeliveryAttributes()
    static let contentState = DeliveryAttributes.ContentState(deliveryStatus: .sent,
                                                             productName: "productName",
                                                             estimatedArrivalDate: "9:00")

    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Island Compact")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Island Expanded")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal")
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
