//
//  FetchState.swift
//  ItunesApp
//
//  Created by MacBook Air on 12.06.2023.
//

import Foundation

enum FetchState: Comparable {
    case good
    case isLoading
    case loadedAll
    case error(String)
}
