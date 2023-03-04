//
//  ContentView.swift
//  PushNotificationDemo
//
//  Created by Erik Flores on 4/03/23.
//

import SwiftUI

struct MainView: View {
    @State var openModal: Bool = false
    
    var body: some View {
        VStack {
            Button("Mostrar promocion") {
                openModal.toggle()
            }
            .sheet(isPresented: $openModal) {
                ModalDemo()
            }
            .onOpenURL { url in
                guard let scheme = url.scheme, scheme == "pushNotificationDemo" else {
                    return
                }
                openModal.toggle()
            }
        }
    }
}
struct ModalDemo: View {
    var body: some View {
        Text("Modal Demo 🥳")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
