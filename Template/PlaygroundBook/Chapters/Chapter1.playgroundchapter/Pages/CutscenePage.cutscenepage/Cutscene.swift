import SwiftUI
import PlaygroundSupport
import Foundation
import UIKit
import SpriteKit
import GameplayKit
import BookCore

public struct ContentView: View {
    
    public var body: some View {
        ZStack {
            Image("cutscene0")
            .resizable()
            .scaleEffect(1.90)
        }
    }
}

public struct ContentView_Preview: PreviewProvider {
    public static var previews: some View {
        ContentView()
    }
    
}
let vc = UIHostingController(rootView: ContentView())

PlaygroundPage.current.liveView = vc
