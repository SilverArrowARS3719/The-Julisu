import Foundation
import Combine

class QuotesManager: ObservableObject {
    @Published var currentQuote: String = ""

    private var timer: Timer?

    let quotes: [String] = [
        "With great power comes great responsibility.",
        "The only way to do great work is to love what you do.",
        "Success is not final, failure is not fatal: it is the courage to continue that counts.",
        "Believe you can and you're halfway there.",
        "It always seems impossible until it's done.",
        "The future belongs to those who believe in the beauty of their dreams.",
        "Do what you can, with what you have, where you are.",
        "Your time is limited, so don't waste it living someone else's life.",
        "The only limit to our realization of tomorrow is our doubts of today.",
        "Act as if what you do makes a difference. It does.",
        "Everything you've ever wanted is on the other side of fear.",
        "Hardships often prepare ordinary people for an extraordinary destiny.",
        "Success usually comes to those who are too busy to be looking for it.",
        "Don't watch the clock; do what it does. Keep going.",
        "Whether you think you can or you think you can't, you're right.",
        "The secret of getting ahead is getting started.",
        "It does not matter how slowly you go as long as you do not stop.",
        "Quality is not an act, it is a habit.",
        "The harder you work for something, the greater you'll feel when you achieve it.",
        "Dream it. Wish it. Do it.",
        "Great things never come from comfort zones.",
        "Push yourself, because no one else is going to do it for you.",
        "Little things make big days.",
        "Don't stop when you're tired. Stop when you're done.",
        "Wake up with determination. Go to bed with satisfaction.",
        "Do something today that your future self will thank you for.",
        "Little by little, one travels far.",
        "It's going to be hard, but hard does not mean impossible.",
        "Don't wait for opportunity. Create it.",
        "Sometimes we're tested not to show our weaknesses, but to discover our strengths.",
        "The key to success is to focus on goals, not obstacles.",
        "Dream bigger. Do bigger.",
        "Discipline is the bridge between goals and accomplishment.",
        "A river cuts through rock, not because of its power, but its persistence.",
        "Start where you are. Use what you have. Do what you can.",
        "The expert in anything was once a beginner.",
        "You don't have to be great to start, but you have to start to be great.",
        "Opportunities don't happen. You create them.",
        "The only person you should try to be better than is the person you were yesterday.",
        "Difficulties in life are intended to make us better, not bitter.",
        "Try not to become a person of success, but a person of value.",
        "Life is 10% what happens to us and 90% how we react to it.",
        "The best way to predict the future is to create it.",
        "Strive not to be a success, but rather to be of value.",
        "You are never too old to set another goal or to dream a new dream.",
        "What lies behind us and what lies before us are tiny matters compared to what lies within us.",
        "Knowing yourself is the beginning of all wisdom.",
        "Well done is better than well said.",
        "Either you run the day, or the day runs you.",
        "You miss 100% of the shots you don't take.",
        "Whatever the mind can conceive and believe, it can achieve.",
        "I find that the harder I work, the more luck I seem to have.",
        "Change your thoughts and you change your world.",
        "The only way to have a good day is to start it right.",
        "Focus on your goal. Don't look in any direction but ahead.",
        "Small steps in the right direction can turn out to be the biggest step of your life.",
        "You are capable of more than you know.",
        "A goal without a plan is just a wish.",
        "The pain of discipline is far less than the pain of regret.",
        "Every accomplishment starts with the decision to try.",
        "You don't need to see the whole staircase, just take the first step.",
        "There is no substitute for hard work.",
        "Do the hard jobs first. The easy jobs will take care of themselves.",
        "Motivation is what gets you started. Habit is what keeps you going.",
        "You can't build a reputation on what you're going to do.",
        "Never leave that till tomorrow which you can do today.",
        "Perseverance is not a long race; it is many short races one after another.",
        "The distance between dreams and reality is called action.",
        "Consistency is what transforms average into excellence.",
        "Winners are not people who never fail, but people who never quit.",
        "Nothing will work unless you do.",
        "Effort only fully releases its reward after a person refuses to quit.",
        "The successful warrior is the average man, with laser-like focus.",
        "Doubt kills more dreams than failure ever will.",
        "Amateurs sit and wait for inspiration. The rest of us just get up and go to work.",
        "You are your only limit.",
        "Never give up, for that is just the place and time that the tide will turn.",
        "It's not that I'm so smart, it's just that I stay with problems longer.",
        "Nothing happens until something moves.",
        "Learning never exhausts the mind.",
        "The beautiful thing about learning is that no one can take it away from you.",
        "Education is the most powerful weapon which you can use to change the world.",
        "An investment in knowledge pays the best interest.",
        "The more that you read, the more things you will know.",
        "Live as if you were to die tomorrow. Learn as if you were to live forever.",
        "Study hard what interests you the most in the most undisciplined, irreverent way possible.",
        "Once you stop learning, you start dying.",
        "Anyone who stops learning is old, whether at twenty or eighty.",
        "The mind is not a vessel to be filled, but a fire to be kindled.",
        "Genius is 1% inspiration and 99% perspiration.",
        "I have not failed. I've just found 10,000 ways that won't work.",
        "There are no shortcuts to any place worth going.",
        "The journey of a thousand miles begins with a single step.",
        "Fall seven times, stand up eight.",
        "In the middle of every difficulty lies opportunity.",
        "You must do the things you think you cannot do.",
        "Courage doesn't always roar. Sometimes it's the quiet voice saying I will try again tomorrow.",
        "Turn your wounds into wisdom.",
        "What you get by achieving your goals is not as important as what you become by achieving your goals.",
        "The only limit to our realization of tomorrow will be our doubts of today.",
        "Keep your face always toward the sunshine, and shadows will fall behind you."
    ]

    init() {
        currentQuote = quotes.randomElement() ?? ""
        startRotating()
    }

    func startRotating() {
        let interval = Double.random(in: 300...600) // 5 to 10 minutes
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
            self?.currentQuote = self?.quotes.randomElement() ?? ""
            self?.startRotating()
        }
    }

    func nextQuote() {
        currentQuote = quotes.randomElement() ?? currentQuote
    }
}
