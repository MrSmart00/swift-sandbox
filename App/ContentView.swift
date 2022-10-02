//
//  ContentView.swift
//  App
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import SwiftUI

public struct ContentView: View {
    public init() { }
    
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
