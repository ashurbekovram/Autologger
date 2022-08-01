//
//  PublisherExtension.swift
//
//
//  Created by Ramazan Ashurbekov on 18.07.2022.
//

import Combine

public extension Publisher {
    func weakSink<T: AnyObject>(
        on object: T,
        receiveCompletion onCompletion: ((T, Subscribers.Completion<Failure>) -> Void)? = nil,
        receiveValue: ((T, Output) -> Void)? = nil,
        receiveError: ((T, Failure) -> Void)? = nil
    ) -> AnyCancellable {
        return sink { [weak object] result in
            guard let object = object else {
                return
            }

            if case let .failure(error) = result {
                receiveError?(object, error)
            }

            onCompletion?(object, result)
        } receiveValue: { [weak object] output in
            guard let object = object else {
                return
            }

            receiveValue?(object, output)
        }
    }

    /// May used for result type `AnyPublisher<Void, Error>`
    func weakSink<T: AnyObject>(
        on object: T,
        receiveCompletion: ((T, Subscribers.Completion<Failure>) -> Void)?
    ) -> AnyCancellable {
        weakSink(
            on: object,
            receiveCompletion: receiveCompletion,
            receiveValue: nil,
            receiveError: nil
        )
    }
}
