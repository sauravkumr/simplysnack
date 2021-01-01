
var UIState: UIStateModel = UIStateModel()

import SwiftUI
import SDWebImageSwiftUI

struct SnapCarousel: View{
    
    @Environment(\.openURL) var openURL
    
    var UIState: UIStateModel
    
    @Binding var modelURL: String
    
    var body: some View
    {
        
        let spacing:            CGFloat = 16
        let widthOfHiddenCards: CGFloat = 32
        let cardHeight:         CGFloat = 279
        
        let items = [
            Card( id: 0, name: model[0].title ),
            Card( id: 1, name: model[1].title ),
            Card( id: 2, name: model[2].title ),
            Card( id: 3, name: model[3].title ),
            Card( id: 4, name: model[4].title ),
            Card( id: 5, name: model[5].title ),
            Card( id: 6, name: model[6].title ),
            Card( id: 7, name: model[7].title )
            //            Card( id: 8, name: model[8].title ),
            //            Card( id: 9, name: model[9].title )
        ]
        
        return  Canvas
        {
            //
            // TODO: find a way to avoid passing same arguments to Carousel and Item
            //
            Carousel( numberOfItems: CGFloat( items.count ), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards )
            {
                
                ForEach( items, id: \.self.id) { item in
                    
                    //                        NavigationView{
                    Item( _id:                  Int(item.id),
                          spacing:              spacing,
                          widthOfHiddenCards:   widthOfHiddenCards,
                          cardHeight:           cardHeight )
                    {
                        Text("\(item.name)").font(.title2).foregroundColor(Color.white).bold().frame(width: cardHeight-20)
                        
                    }
                    .foregroundColor(Color.white)
                    .background(
                        ZStack{
                            WebImage(url: URL(string: model[item.id].image))
                                .resizable()
                                .cornerRadius(20)
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.black.opacity(0.3))
                                .clipped()

                        }.frame(width: 279, height: 279)
                        
                        .onTapGesture {
                            self.modelURL = model[item.id].url
                            print(model[item.id].url)
                            openURL(URL(string: model[item.id].url)!)
                        }
                        
                    )
                    
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    //                            .shadow(color: Color( "shadow1" ), radius: 4, x: 0, y: 4 )
                    .transition(AnyTransition.slide)
                    .animation(.spring())
                    
                    //                    }
                }
            }
            .environmentObject(self.UIState)
        }
    }
}

struct Card: Decodable, Hashable, Identifiable
{
    var id:     Int
    var name:   String = ""
}

public class UIStateModel: ObservableObject
{
    @Published var activeCard: Int      = 0
    @Published var screenDrag: Float    = 0.0
}

struct Carousel<Items : View> : View {
    let items: Items
    let numberOfItems: CGFloat //= 8
    let spacing: CGFloat //= 16
    let widthOfHiddenCards: CGFloat //= 32
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = false
    
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        @ViewBuilder _ items: () -> Items) {
        
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        
    }
    
    var body: some View {
        
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing
        
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) + 1)
        
        var calcOffset = Float(activeOffset)
        
        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + UIState.screenDrag
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            self.UIState.screenDrag = Float(currentState.translation.width)
            
        }.onEnded { value in
            self.UIState.screenDrag = 0
            
            if (value.translation.width < -50 && CGFloat(self.UIState.activeCard) < numberOfItems - 1) {
                self.UIState.activeCard = self.UIState.activeCard + 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
            
            if (value.translation.width > 50 && CGFloat(self.UIState.activeCard) > 0) {
                self.UIState.activeCard = self.UIState.activeCard - 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
        })
    }
}

struct Canvas<Content : View> : View {
    let content: Content
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct Item<Content: View>: View {
    @EnvironmentObject var UIState: UIStateModel
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    
    var _id: Int
    var content: Content
    
    @inlinable public init(
        _id: Int,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        cardHeight: CGFloat,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        self.cardHeight = cardHeight
        self._id = _id
    }
    
    var body: some View {
        content
            .frame(width: cardWidth, height: _id == UIState.activeCard ? cardHeight : cardHeight - 60, alignment: .center)
    }
}
