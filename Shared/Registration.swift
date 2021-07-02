//
//  Registration.swift
//  NukeExample
//
//  Created by Tyler Nickerson on 7/2/21.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { Interator() }.scope(.application)
        register { ViewModel() }.scope(.application)
    }
}
