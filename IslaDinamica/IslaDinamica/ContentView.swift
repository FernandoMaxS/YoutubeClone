//
//  ContentView.swift
//  IslaDinamica
//
//  Created by Fernando Maximiliano on 27/06/23.
//

import SwiftUI


struct ContentView: View {
    @State var productName: String = "Camiseta 20$"
    @State var currentDeliveryState: DeliveryStatus = .pending
    @State var activityIdentifier: String = ""
    
    var body: some View {
        VStack {
            Text("Suscribete a Swift beta")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 32)
            AsyncImage(url: .init(string: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg")){ image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
            }placeholder: {
                ProgressView()
            }
            
            Text(productName)
                .font(.system(.largeTitle))
            Text(currentDeliveryState.rawValue)
                .font(.system(.body))
            Button {
               buyProduct()
            } label: {
                Label("Comprar", systemImage: "cart.fill")
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 32)
            
            Spacer()
            
            Button {
                changeState()
            } label: {
                Label("Cambiar estado", systemImage: "arrow.clockwise.circle.fill")
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .padding(.top, 32)
            
            Button {
                removeState()
            } label: {
                Label("Eliminar", systemImage: "trash.fill")
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 32)
            Spacer()
        }
        .padding()
    }
    func buyProduct(){
        currentDeliveryState = .sent
        print(currentDeliveryState)
        do {
            activityIdentifier = try DeliveryActivityUseCase.startActivity(deliveryStatus: currentDeliveryState, productName: productName, estimatedArrivalDate: "9:00")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func changeState(){
        currentDeliveryState = .inTransit
        print(currentDeliveryState)
        Task{
            await
            DeliveryActivityUseCase.updateActivity(activityIdentifier:activityIdentifier,
                                                   newDeliveryStatus:currentDeliveryState,
                                                   productName:productName,
                                                   estimatedArrivalDate:"21:00")
        }
    }
    
    func removeState(){
        currentDeliveryState = .inTransit
        print(currentDeliveryState)
        Task{
            await
            DeliveryActivityUseCase.endActivity(withActivityIdentifier:activityIdentifier)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
