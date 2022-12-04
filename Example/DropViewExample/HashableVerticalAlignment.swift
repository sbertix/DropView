//
//  HashableVerticalAlignment.swift
//  Ciaone
//
//  Created by Stefano Bertagno on 04/12/22.
//

import Foundation
import SwiftUI

public enum HashableVerticalAlignment: Hashable {
    case top
    case center
    case bottom

    var alignment: VerticalAlignment {
        switch self {
        case .top: return .top
        case .center: return .center
        case .bottom: return .bottom
        }
    }

    var edge: Edge {
        switch self {
        case .top: return .top
        case .center: return .trailing
        case .bottom: return .bottom
        }
    }
}
