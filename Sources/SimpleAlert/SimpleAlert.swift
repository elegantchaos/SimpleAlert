// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 10/09/2021.
//  All code (c) 2021 - present day, Elegant Chaos.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import SwiftUI

public struct SimpleAlert {
    let title: LocalizedStringKey
    let message: LocalizedStringKey
    let primary: Button
    let secondary: Button?
    
    enum Button {
        case normal(LocalizedStringKey,() -> ())
        case destructive(LocalizedStringKey, () -> ())
        case cancel
        
        var alertButton: SwiftUI.Alert.Button {
            switch self {
                case .normal(let label, let action):
                    return .default(Text(label), action: action)
                case .destructive(let label, let action):
                    return .destructive(Text(label), action: action)
                case .cancel:
                    return .cancel()
            }
        }
    }
}
