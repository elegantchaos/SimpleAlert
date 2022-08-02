# SimpleAlert

SimpleAlert implements a simple way to put up a parameterised Alert in SwiftUI. 

Works with SwiftUI 3 / iOS 15.0.

## Usage

```swift

import SimpleInput

struct MyView: View {
    @State var input: SimpleInput?

    var body: some View {
        VStack {
            Text("Some stuff")
            Button(action: handleShowAlert) {
                Text("Show It")
            }
            .simpleAlert($alert)
        }
    }
    
    func handleShowAlert() {
        alert = SimpleAlert(
            title: "Hello",
            verbatim: "This is a simple alert",
            buttons: [
                .normal("Option A", { /* do stuff */ }),
                .normal("Option B", { /* do stuff */ }),
                .cancel
            ])
    }
}
```

 
