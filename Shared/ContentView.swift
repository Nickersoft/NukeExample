//
//  ContentView.swift
//  Shared
//
//  Created by Tyler Nickerson on 7/2/21.
//

import SwiftUI
import Resolver

struct Item: Hashable, Equatable, Identifiable {
    var id: String
    var image: UIImage
}

struct ContentView: View {

    @InjectedObject var viewModel: ViewModel

    @Injected var interactor: Interator

    var body: some View {
        VStack {
            Button("Reload") {
                viewModel.tapped = true
            }
            List {
                ForEach(viewModel.images) { img in
                    Image(uiImage: img.image)
                }
            }
            .onAppear {
                interactor.loadImages()
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
