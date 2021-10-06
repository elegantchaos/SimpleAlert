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
    
    public init(title: LocalizedStringKey, message: LocalizedStringKey, primary: SimpleAlert.Button, secondary: SimpleAlert.Button?) {
        self.title = title
        self.message = message
        self.primary = primary
        self.secondary = secondary
    }

    public enum Button {
        case normal(LocalizedStringKey,() -> ())
        case destructive(LocalizedStringKey, () -> ())
        case cancel(() -> ())
        
        var alertButton: Alert.Button {
            switch self {
                case .normal(let label, let action):
                    return .default(Text(label), action: action)
                case .destructive(let label, let action):
                    return .destructive(Text(label), action: action)
                case .cancel(let action):
                    return .cancel(action)
            }
        }
        
        public static var cancel: Button {
            return Self.cancel({})
        }
    }
}

public struct SimpleAlertModifier: ViewModifier {
    @Binding var alert: SimpleAlert?
    
    var showAlert: Binding<Bool> {
        Binding<Bool>(
            get: { alert != nil }, set: { value in if !value { alert = nil }}
        )
    }

    public func body(content: Content) -> some View {
        content
            .alert(isPresented: showAlert) {
                let alert = self.alert!
                if let secondary = alert.secondary {
                    return Alert(
                        title: Text(alert.title),
                        message: Text(alert.message),
                        primaryButton: alert.primary.alertButton,
                        secondaryButton: secondary.alertButton
                    )
                } else {
                    return Alert(
                        title: Text(alert.title),
                        message: Text(alert.message),
                        dismissButton: alert.primary.alertButton
                    )
                }
            }
    }
}

public extension View {
    func simpleAlert(_ alert: Binding<SimpleAlert?>) -> some View {
        return self
            .modifier(SimpleAlertModifier(alert: alert))
    }
}
