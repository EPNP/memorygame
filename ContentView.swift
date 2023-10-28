import SwiftUI
let emojis1 = ["🐳", "🐊", "🐖", "🐩","🐳", "🐊", "🐖", "🐩","🐫","🐫"]
let emojis2 = ["🇰🇷", "🇹🇭", "🇨🇭", "🏴󠁧󠁢󠁥󠁮󠁧󠁿","🇰🇷", "🇹🇭", "🇨🇭", "🏴󠁧󠁢󠁥󠁮󠁧󠁿","🇨🇦","🇨🇦","🇯🇵","🇯🇵"]
let emojis3 = ["📒", "📏", "✏️", "🖋️","📒", "📏", "✏️", "🖋️"]



struct ContentView: View {
    
    @State var theme = emojis1
    @State var cardCount = 8
    @State var selectedTheme: String = "Animals"
    
    var body: some View {
        VStack {
            Text("Memorize!!!!")
                .fontWeight(.bold)
                .font(.title)
            ScrollView {
                cards
            }
            Spacer()
            //            cardCountAdjusters
            cardTheme
            Spacer()
            //            resetButton
            
        }
        .padding()
    }
    
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<theme.count, id: \.self) { index in
                CardView(content: theme[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardTheme: some View {
        HStack {
            cardTheme1
            Spacer()
            cardTheme2
            Spacer()
            cardTheme3
        }
        .imageScale(.large)
        .font(.title)
        .foregroundColor(.red)
    }
    
    func cardThemeAdjuster(theme: [String] ,symbol: String, name: String) -> some View {
        Button(action: {
            self.theme = theme.shuffled()
            self.selectedTheme = name
        }, label: {
            Image(systemName: symbol)
        })
    }
    
    var cardTheme1: some View {
        VStack{
            cardThemeAdjuster(theme: emojis1, symbol: "pawprint", name: "Animals")
            
            Text("Animals")
                .font(selectedTheme == "Animals" ? .title2 : .footnote)
        }
    }
    
    var cardTheme2: some View {
        VStack{
            cardThemeAdjuster(theme: emojis2,symbol: "flag.filled.and.flag.crossed", name: "Country")
            Text("Country")
                .font(selectedTheme == "Country" ? .title2: .footnote)
        }
        
    }
    var cardTheme3: some View {
        VStack{
            cardThemeAdjuster(theme: emojis3,symbol: "graduationcap", name: "School")
            Text("School")
                .font(selectedTheme == "School" ? .title2 : .footnote)
        }
    }
    
    var resetButton: some View {
        Button(action: {
            resetGame()
        }, label: {
            Image(systemName: "arrow.clockwise")
                .font(.headline)
                .padding()
                .foregroundColor(.blue)
        })
    }
    
    func resetGame() {
        self.theme = theme.shuffled()
        
    }
    
    
    
    struct CardView: View {
        let content: String
        @State var isFaceUp = true
        @Environment(\.colorScheme) var colorSchema
        
        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.foregroundColor(colorSchema == .dark ? .black
                                         : .white)
                    base.strokeBorder(lineWidth: 2)
                    Text(content).font(.largeTitle)
                }
                .opacity(isFaceUp ? 1 : 0)
                base.opacity(isFaceUp ? 0 : 1)
            }
            .onTapGesture {
                isFaceUp.toggle()
            }
        }
    }
}
