//
//  Interactor.swift
//  NukeExample
//
//  Created by Tyler Nickerson on 7/2/21.
//

import Foundation
import Nuke
import UIKit
import Combine
import Resolver

class Interator {

    @Injected var viewModel: ViewModel

    var cancellable: AnyCancellable?

    deinit {
        cancellable?.cancel()
    }

    func loadImage(id: String) -> AnyPublisher<Item, Never> {
        ImagePipeline.shared.imagePublisher(
            with: ImageRequest(
                url: URL(string: "https://placedog.net/1000"),
                processors: [
                    ImageProcessors.Resize(
                        size: .init(width: 48, height: 48)
                    )
                ]
            )
        )
        .map(\.image)
        .replaceError(with: UIImage(systemName: "multiply.circle.fill")!)
        .map { img in
            Item(id: id, image: img)
        }
        .eraseToAnyPublisher()
    }

    func loadImages() {
        cancellable = viewModel
            .$tapped
            .compactMap { _  -> AnyPublisher<[Item], Error> in
                Publishers.MergeMany(
                    Array(repeating: 0, count: 5).compactMap { [weak self] i in
                        self?.loadImage(id: String(i))
                    }
                )
                .collect()
                .mapError { _ -> Error in }
                .eraseToAnyPublisher()
            }
            .mapError { _ -> Error in }
            .switchToLatest()
            .eraseToAnyPublisher()
            .replaceError(with: [])
            .sink { [weak self] imgs in
                self?.viewModel.images = imgs
            }
    }
}
