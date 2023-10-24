//
//  TaskEnvironment .swift
//  TaskSDK
//
//  Created by gbl on 2023/10/20.
//

import Foundation

//@objc
//public enum TaskEnvironment {
//    case TEST
//    case PRE
//    case PRODUCTION
//}

@objc public enum TaskEnvironment: Int {
    case TEST
    case PRE
    case PRODUCTION

    func name() -> String {
        switch self {
        case .TEST: return "test"
        case .PRE: return "pre"
        case .PRODUCTION: return "prod"
        }
    }
}
