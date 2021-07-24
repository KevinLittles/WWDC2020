//#-hidden-code
import SwiftUI
import PlaygroundSupport
import Foundation
import UIKit
import SpriteKit
import GameplayKit
import BookCore

class GameViewController: UIViewController {
    
    var geometrySize: CGSize = CGSize()
    var spriteItems: [SKSpriteNode] = []
    
    public convenience init(geometrySize: CGSize, spriteItems: [SKSpriteNode]) {
        self.init(nibName:nil,bundle:nil)
        self.geometrySize = geometrySize
        self.spriteItems = spriteItems
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        
        let view = SKView()
        
        let scene = GameScene(geometrySize: geometrySize, spriteItems: spriteItems)
        // Set the scale mode to scale to fit the window
        
        //scene.scaleMode = .aspectFit
        
        // Present the scene
        view.presentScene(scene)
        
        print("LOADED SCENE!!!!")
        
        
        //            view.ignoresSiblingOrder = true
        
        view.showsFPS = true
        view.showsNodeCount = true
        view.allowsTransparency = true
        view.ignoresSiblingOrder = true
        //            view.showsPhysics = true
        
        //self.view.addSubview(view)
        self.view = view
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        let view = SKView()
        //
        //        let scene = GameScene()
        //                    // Set the scale mode to scale to fit the window
        //
        //                //scene.scaleMode = .aspectFit
        //
        //                    // Present the scene
        //        view.presentScene(scene)
        //
        //        print("LOADED SCENE!!!!")
        //
        //
        //    //            view.ignoresSiblingOrder = true
        //
        //        view.showsFPS = true
        //        view.showsNodeCount = true
        //    //            view.showsPhysics = true
        //
        //        self.view.addSubview(view)
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


struct GameViewAdapter: UIViewControllerRepresentable {
    
    var vc: GameViewController
    
    init(geometrySize: CGSize, spriteItems: [SKSpriteNode]) {
        vc = GameViewController(geometrySize: geometrySize, spriteItems: spriteItems)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GameViewAdapter>) -> GameViewController {
        return self.vc
    }
    
    func updateUIViewController(_ uiViewController: GameViewController, context: UIViewControllerRepresentableContext<GameViewAdapter>) {
        print("Updated bro")
    }
    
    typealias UIViewControllerType = GameViewController
    
    
}


public struct ContentView: View {
//#-end-hidden-code
/*:
**manager:** Aqui temos a classe que guarda todas as informações úteis que são usadas nesse playground.
     
kindOfScenery: O tipo de cenário que userá usado no playground, por padrão temos o cenário do Batman, mas voce pode escolher outro dentre as opções disponíveis.
     
amountOfItems: A quantidade de items que serão ordenados, por padrão temos 10 items, mas voce pode alterar entre 0 a 20.
*/
    
    @ObservedObject var manager = InterativePlaygroundManager(kindOfScenery: /*#-editable-code kind of scenery*/.library/*#-end-editable-code*/, amountOfItems: /*#-editable-code amount of items*/5/*#-end-editable-code*/,sortVelocity: /*#-editable-code velocity of sorting*/.verySlow/*#-end-editable-code*/)
    
/*:
**sort():** Aqui temos a função responsável por ordenar os nossos items.
     
Ao final da primeira linha da função está qual algoritmo de ordenação iremos usar, por padrão está definido como bubbleSort(), mas assim como os componentes acima, este também é alterável.
*/
    func sort() {
        self.manager.items.valueOfItemsToSort/*#-editable-code sort algorithm*/.bubbleSort()/*#-end-editable-code*/
    }
/*:
**init():** Aqui temos a nossa função construtora, significa que tudo que está dentro dela será carregado primeiramente. Neste caso carregaremos a função *sort()*.
*/
    init() {
        self.sort()
        
    }
//#-hidden-code
    //
    //    func update() {
    //        self.manager.UpdateScenery()
    //        self.manager.UpdateItems()
    //    }
    
    public var body: some View {
        ZStack {
            //Color.orange
            //.edgesIgnoringSafeArea(.all)
            Image("backgroundImagelibrary")
                .resizable()
                .scaledToFit()
            GeometryReader { geometry in
                
                GameViewAdapter(geometrySize:geometry.size, spriteItems: self.manager.items.spriteItems)
                Text(NSCoder.string(for: geometry.size))
//                if UIDevice.current.orientation.isLandscape {
//                    Text("ERRADO")
//                } else if UIDevice.current.orientation.isFlat {
//                    Text("ERRADO")
//                } else if UIDevice.current.orientation.isPortrait {
//                    Text("ERRADO")
//                } else if UIDevice.current.orientation.isValidInterfaceOrientation {
//                    Text("ERRADO")
//                }
                //            ScrollView {
                //                VStack(spacing: 400){
                //                    ForEach(self.manager.items.itemsImage, id: \.self) { image in
                //                        Image(image).resizable().scaledToFit()
                //                    }
                //                }
                //            }
            }
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

//#-end-hidden-code
