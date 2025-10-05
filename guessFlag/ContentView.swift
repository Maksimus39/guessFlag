import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland",
                                     "Italy", "Nigeria", "Poland", "Spain", "UK",
                                     "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingGameOver = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var questionNumber = 1
    @State private var selectedFlag = ""
    
    let totalQuestions = 8
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.4, blue: 0.8), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack (spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button {
                            flagTapped(number)
                        } label:{
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 15))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Text("Question: \(questionNumber)/\(totalQuestions)")
                    .foregroundStyle(.white)
                    .font(.subheadline)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Correct" {
                Text("Your score is \(userScore)")
            } else {
                Text("Wrong! That's the flag of \(selectedFlag)")
            }
        }
        .alert("Game Over", isPresented: $showingGameOver){
            Button("Play Again", action: resetGame)
        } message: {
            Text("Your final score is \(userScore)/\(totalQuestions)")
        }
    }
    
    func flagTapped(_ number: Int){
        selectedFlag = countries[number]
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        if questionNumber == totalQuestions {
            showingGameOver = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionNumber += 1
    }
    
    func resetGame(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionNumber = 1
        userScore = 0
    }
}

#Preview {
    ContentView()
}
