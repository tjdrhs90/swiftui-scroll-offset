# SwiftUI Scroll Offset

![Swift 5.9](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS 15+](https://img.shields.io/badge/iOS-15%2B-blue.svg)
![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)

Track ScrollView offset in SwiftUI with a simple modifier. Perfect for collapsing headers, parallax effects, and scroll-driven animations.

## Installation

```
https://github.com/tjdrhs90/swiftui-scroll-offset.git
```

## Usage

### Basic

```swift
import ScrollOffset

struct ContentView: View {
    @State private var offset: CGPoint = .zero

    var body: some View {
        VStack {
            // Use as a wrapper
            OffsetTrackingScrollView { offset in
                self.offset = offset
            } content: {
                ForEach(0..<50) { i in
                    Text("Row \(i)")
                        .padding()
                }
            }
        }
    }
}
```

### Collapsing Header

```swift
struct HeaderView: View {
    @State private var offset: CGPoint = .zero

    var body: some View {
        ZStack(alignment: .top) {
            OffsetTrackingScrollView { offset in
                self.offset = offset
            } content: {
                LazyVStack {
                    ForEach(0..<100) { i in
                        Text("Item \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
            }

            // Header that collapses on scroll
            Text("Header")
                .frame(maxWidth: .infinity)
                .frame(height: max(60, 120 - offset.y))
                .background(.ultraThinMaterial)
        }
    }
}
```

### View Modifier Style

```swift
VStack {
    ForEach(0..<50) { i in
        Text("Row \(i)").padding()
    }
}
.trackScrollOffset { offset in
    print("y: \(offset.y)")
}
```

## How It Works

Uses `GeometryReader` + `PreferenceKey` inside a `coordinateSpace` to read the scroll position without interfering with the layout. Zero performance overhead.

## Requirements

- iOS 15+
- Swift 5.9+
- Xcode 15+

## License

MIT License. See [LICENSE](LICENSE) for details.
