//
//  ViewModel.swift
//  NukeExample
//
//  Created by Tyler Nickerson on 7/2/21.
//

import Foundation
import UIKit

class ViewModel: ObservableObject {
    @Published var images: [Item] = []

    @Published var tapped: Bool = false
}
