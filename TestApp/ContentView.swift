//
//  ContentView.swift
//  TestApp
//
//  Created by Maxim Potapov on 23.09.2021.
//

import SwiftUI
import Pilgrim

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                TextField(" ", text: $viewModel.venueName)
                    .frame(height: 30)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.leading, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1)
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                    )
                
                Spacer()
                
                Button(action: {
                    viewModel.snapToPlace()
                }) {
                    Text("Search")
                }
            }
            .padding()
            
            
            List(viewModel.items, id: \.venueId) { v in
                Text("name:")
                Text(v.name ?? "not found")
            }
        }.onAppear(perform: {
            viewModel.lodaData()
            print("Venues: \(viewModel.items)")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
