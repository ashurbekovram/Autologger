//
//  KeyChain.swift
//  
//
//  Created by Ramazan Ashurbekov on 04.01.2023.
//

import Foundation
import Security

final class KeyChain {
    static func save(data: Data, account: String, service: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecValueData: data
        ] as CFDictionary

        SecItemDelete(query)
        SecItemAdd(query, nil)
    }

    static func read(account: String, service: String) -> Data? {
        let query: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)

        return (result as? Data)
    }

    static func delete(account: String, service: String) {
        let query = [
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary

        SecItemDelete(query)
    }
}

// MARK: - Generic methods
extension KeyChain {
    static func saveItem<T: Encodable>(_ item: T, account: String, service: String) {
        guard let data = try? JSONEncoder().encode(item) else {
            return
        }
        KeyChain.save(data: data, account: account, service: service)
    }

    static func readItem<T: Decodable>(account: String, service: String) -> T? {
        guard let data = KeyChain.read(account: account, service: service),
              let decoded = try? JSONDecoder().decode(T.self, from: data)
        else {
            return nil
        }
        return decoded
    }
}
