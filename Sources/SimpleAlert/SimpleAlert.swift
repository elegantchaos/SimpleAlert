// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 10/09/2021.
//  All code (c) 2021 - present day, Elegant Chaos.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import SwiftUI

public struct SimpleAlert {
    let title: LocalizedStringKey
    let message: LocalizedStringKey
    let buttons: [Button]
    
    public init(title: LocalizedStringKey, message: LocalizedStringKey, primary: SimpleAlert.Button, secondary: SimpleAlert.Button? = nil) {
        self.title = title
        self.message = message
        var buttons = [primary]
        if let secondary = secondary {
            buttons.append(secondary)
        }
        self.buttons = buttons
    }

    public init(title: LocalizedStringKey, message: LocalizedStringKey, buttons: [SimpleAlert.Button]) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }

    public struct Button {
        let label: String
        let role: ButtonRole?
        let action: () -> ()

        public static func normal(_ label: String, _ action: @escaping () -> ()) -> Button {
            return .init(label: label, role: nil, action: action)
        }
        
        public static func cancel(_ label: String) -> Button {
            return .init(label: label, role: .cancel, action: {})
        }

        public static func cancel(_ action: @escaping () -> ()) -> Button {
            return .init(label: "Cancel", role: .cancel, action: action)
        }

        public static var cancel: Button {
            return .init(label: "Cancel", role: .cancel, action: {})
        }
        
        public static func destructive(_ label: String, _ action: @escaping () -> ()) -> Button {
            return .init(label: label, role: .destructive, action: action)
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

    var buttons: [SimpleAlert.Button] {
        alert?.buttons ?? []
    }
    
    var title: LocalizedStringKey {
        alert?.title ?? ""
    }
    
    var message: LocalizedStringKey {
        alert?.message ?? ""
    }
    
    public func body(content: Content) -> some View {
        return content
            .alert(title, isPresented: showAlert) {
                ForEach(buttons, id: \.label) { button in
                    SwiftUI.Button(LocalizedStringKey(button.label), role: button.role, action: button.action)
                }
            } message: {
                Text(message)
            }
    }
}

public extension View {
    func simpleAlert(_ alert: Binding<SimpleAlert?>) -> some View {
        return self
            .modifier(SimpleAlertModifier(alert: alert))
    }
}
