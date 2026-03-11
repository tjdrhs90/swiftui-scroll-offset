import SwiftUI

// MARK: - Preference Key

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

// MARK: - Coordinate Space

private let coordinateSpaceName = "scrollOffset"

// MARK: - Offset Reader

struct ScrollOffsetReader: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: CGPoint(
                        x: -geometry.frame(in: .named(coordinateSpaceName)).origin.x,
                        y: -geometry.frame(in: .named(coordinateSpaceName)).origin.y
                    )
                )
        }
        .frame(height: 0)
    }
}

// MARK: - ScrollView with Offset Tracking

/// A ScrollView wrapper that reports its scroll offset.
public struct OffsetTrackingScrollView<Content: View>: View {
    let axes: Axis.Set
    let showsIndicators: Bool
    let onOffsetChange: (CGPoint) -> Void
    let content: Content

    public init(
        _ axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        onOffsetChange: @escaping (CGPoint) -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.onOffsetChange = onOffsetChange
        self.content = content()
    }

    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            VStack(spacing: 0) {
                ScrollOffsetReader()
                content
            }
        }
        .coordinateSpace(name: coordinateSpaceName)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
            onOffsetChange(offset)
        }
    }
}

// MARK: - View Extension

public extension View {
    /// Wraps this view in a scroll view that tracks its offset.
    func trackScrollOffset(
        axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        onOffsetChange: @escaping (CGPoint) -> Void
    ) -> some View {
        OffsetTrackingScrollView(axes, showsIndicators: showsIndicators, onOffsetChange: onOffsetChange) {
            self
        }
    }
}
