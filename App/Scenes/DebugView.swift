//
//  DebugView.swift
//  App
//
//  Created by 日野森寛也 on 2022/11/06.
//

import SwiftUI

struct DebugView: View {
    var body: some View {
        NavigationView {
            Form {
                NavigationLink("Home") {
                    HomeContentView(
                        store: .init(
                            initialState: .init(),
                            reducer: HomeContent().signpost()._printChanges()
                        )
                    )
                }
                NavigationLink("OptionalContent") {
                    OptionalContentView(
                        store: .init(
                            initialState: .init(),
                            reducer: OptionalContent(middleware: .init()).signpost()._printChanges()
                        )
                    )
                }
                Group {
                    NavigationLink("First") {
                        FirstFeatureView(
                            store: .init(
                                initialState: .init(),
                                reducer: FirstFeature().signpost()._printChanges()
                            )
                        )
                    }
                    NavigationLink("Second") {
                        SecondFeatureView(
                            store: .init(
                                initialState: .init(),
                                reducer: SecondFeature(middleware: .init()).signpost()._printChanges()
                            )
                        )
                    }
                    NavigationLink("Third") {
                        ThirdFeatureView(
                            store: .init(
                                initialState: .init(),
                                reducer: ThirdFeature(middleware: .init()).signpost()._printChanges()
                            )
                        )
                    }
                }
            }
        }
        .navigationTitle("Debug")
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}

struct DebugPresentationModifier: ViewModifier {
    @State var isShowDebug = false
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotifiaction)) { _ in
                isShowDebug = true
            }
            .sheet(isPresented: $isShowDebug) {
                DebugView()
            }
    }
}

extension NSNotification.Name {
    static let deviceDidShakeNotifiaction = NSNotification.Name("DeviceDidShakeNotification")
}

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        NotificationCenter
            .default
            .post(name: .deviceDidShakeNotifiaction, object: event)
    }
}
