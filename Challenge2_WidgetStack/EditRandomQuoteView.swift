////  EditRandomQuoteView.swift
//  Challenge2_WidgetStack
//
//  Created by Chan Yap Long on 30/8/25.
//

import SwiftUI
import Foundation

let famousQuotes: [String] = [
    "The only limit to our realization of tomorrow is our doubts of today. – Franklin D. Roosevelt",
    "In the middle of every difficulty lies opportunity. – Albert Einstein",
    "Do what you can, with what you have, where you are. – Theodore Roosevelt",
    "Success is not final, failure is not fatal: It is the courage to continue that counts. – Winston Churchill",
    "Happiness depends upon ourselves. – Aristotle",
    "It always seems impossible until it's done. – Nelson Mandela",
    "Turn your wounds into wisdom. – Oprah Winfrey",
    "The best way to predict the future is to invent it. – Alan Kay",
    "Don't count the days, make the days count. – Muhammad Ali",
    "Act as if what you do makes a difference. It does. – William James",
    "The journey of a thousand miles begins with a single step. – Lao Tzu",
    "Believe you can and you're halfway there. – Theodore Roosevelt",
    "Don't watch the clock; do what it does. Keep going. – Sam Levenson",
    "Keep your face always toward the sunshine—and shadows will fall behind you. – Walt Whitman",
    "Strive not to be a success, but rather to be of value. – Albert Einstein",
    "Your time is limited, so don't waste it living someone else's life. – Steve Jobs",
    "Life is what happens when you're busy making other plans. – John Lennon",
    "The mind is everything. What you think you become. – Buddha",
    "I have not failed. I've just found 10,000 ways that won't work. – Thomas Edison",
    "Do one thing every day that scares you. – Eleanor Roosevelt",
    "Dream big and dare to fail. – Norman Vaughan",
    "Opportunities don't happen, you create them. – Chris Grosser",
    "Don't be pushed around by the fears in your mind. Be led by the dreams in your heart. – Roy T. Bennett",
    "Go confidently in the direction of your dreams! Live the life you've imagined. – Henry David Thoreau",
    "What you get by achieving your goals is not as important as what you become by achieving your goals. – Zig Ziglar",
    "Everything you've ever wanted is on the other side of fear. – George Addair",
    "Difficulties in life are intended to make us better, not bitter. – Dan Reeves",
    "If opportunity doesn't knock, build a door. – Milton Berle",
    "Be yourself; everyone else is already taken. – Oscar Wilde",
    "To live is the rarest thing in the world. Most people exist, that is all. – Oscar Wilde",
    "Do what makes your soul shine. – Unknown",
    "Courage is grace under pressure. – Ernest Hemingway",
    "Stay hungry, stay foolish. – Steve Jobs",
    "Fall seven times and stand up eight. – Japanese Proverb",
    "No pressure, no diamonds. – Thomas Carlyle",
    "Make each day your masterpiece. – John Wooden",
    "Turn your cant's into cans and your dreams into plans. – Unknown",
    "Don't let yesterday take up too much of today. – Will Rogers",
    "If you want to lift yourself up, lift up someone else. – Booker T. Washington",
    "The secret of getting ahead is getting started. – Mark Twain",
    "A person who never made a mistake never tried anything new. – Albert Einstein",
    "Success usually comes to those who are too busy to be looking for it. – Henry David Thoreau",
    "Limit your 'always' and your 'nevers.' – Amy Poehler",
    "Nothing will work unless you do. – Maya Angelou",
    "Whether you think you can or you think you can't, you're right. – Henry Ford",
    "Keep going. Be all in. – Bryan Hutchinson",
    "Do not wait to strike till the iron is hot, but make it hot by striking. – William Butler Yeats",
    "I would rather die of passion than of boredom. – Vincent van Gogh",
    "The future belongs to those who believe in the beauty of their dreams. – Eleanor Roosevelt",
    "If you can dream it, you can do it. – Walt Disney",
    "Act as if what you do makes a difference. It does. – William James",
    "We are what we repeatedly do. Excellence, then, is not an act, but a habit. – Aristotle",
    "Life is really simple, but we insist on making it complicated. – Confucius",
    "The purpose of our lives is to be happy. – Dalai Lama",
    "Success is how high you bounce when you hit bottom. – George S. Patton",
    "Don't let the fear of losing be greater than the excitement of winning. – Robert Kiyosaki",
    "Do what you love and the money will follow. – Marsha Sinetar",
    "We become what we think about. – Earl Nightingale",
    "To handle yourself, use your head; to handle others, use your heart. – Eleanor Roosevelt",
    "It's not whether you get knocked down, it's whether you get up. – Vince Lombardi",
    "Work hard in silence, let your success be your noise. – Frank Ocean",
    "Don't quit. Suffer now and live the rest of your life as a champion. – Muhammad Ali",
    "Live as if you were to die tomorrow. Learn as if you were to live forever. – Mahatma Gandhi",
    "Do small things with great love. – Mother Teresa",
    "He who has a why to live can bear almost any how. – Friedrich Nietzsche",
    "The man who has confidence in himself gains the confidence of others. – Hasidic Proverb",
    "If you're going through hell, keep going. – Winston Churchill",
    "Go the extra mile. It's never crowded there. – Dr. Wayne D. Dyer",
    "Don't wish it were easier. Wish you were better. – Jim Rohn",
    "Try to be a rainbow in someone's cloud. – Maya Angelou",
    "You miss 100% of the shots you don't take. – Wayne Gretzky",
    "The best revenge is massive success. – Frank Sinatra",
    "Be the change that you wish to see in the world. – Mahatma Gandhi",
    "Life isn't about getting and having, it's about giving and being. – Kevin Kruse",
    "The best preparation for tomorrow is doing your best today. – H. Jackson Brown Jr.",
    "Failure is simply the opportunity to begin again, this time more intelligently. – Henry Ford",
    "Success is walking from failure to failure with no loss of enthusiasm. – Winston Churchill",
    "Hold the vision, trust the process. – Unknown",
    "Don't dream your life, live your dream. – Unknown",
    "A winner is a dreamer who never gives up. – Nelson Mandela",
    "Everything has beauty, but not everyone sees it. – Confucius",
    "I never dreamed about success. I worked for it. – Estée Lauder",
    "Do not go where the path may lead, go instead where there is no path and leave a trail. – Ralph Waldo Emerson",
    "Dream as if you'll live forever, live as if you'll die today. – James Dean",
    "The harder you work for something, the greater you'll feel when you achieve it. – Unknown",
    "Push yourself, because no one else is going to do it for you. – Unknown",
    "Great things never come from comfort zones. – Unknown",
    "Wake up with determination. Go to bed with satisfaction. – Unknown",
    "Little things make big days. – Unknown",
    "Don't stop when you're tired. Stop when you're done. – Unknown",
    "The key to success is to focus on goals, not obstacles. – Unknown",
    "Dream bigger. Do bigger. – Unknown",
    "Discipline is the bridge between goals and accomplishment. – Jim Rohn",
    "Hard work beats talent when talent doesn't work hard. – Tim Notke",
    "Success is the sum of small efforts, repeated day in and day out. – Robert Collier",
    "Motivation is what gets you started. Habit is what keeps you going. – Jim Ryun",
    "You are never too old to set another goal or to dream a new dream. – C.S. Lewis",
    "Your limitation—it's only your imagination. – Unknown",
    "Sometimes later becomes never. Do it now. – Unknown",
    "Great minds discuss ideas; average minds discuss events; small minds discuss people. – Eleanor Roosevelt"
]

struct EditRandomQuoteView: View {
    @State private var widgetColor: Color = .blue
    @State private var widgetText: String = ""
    @State private var widgetTextXAxis: Double = 200
    @State private var widgetTextYAxis: Double = 100
    @State private var widgetTextSize: Double = 50
    @State private var widgetTextColor: Color = .black
    @State private var isWidgetRandomQuoteEnabled = false
    @State private var widgetImage: String = "quote-background" // Add this for ExampleWidgetView
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // Fixed: Added missing WidgetImage parameter
                    ExampleWidgetView(
                        WidgetImage: widgetImage,
                        WidgetColor: $widgetColor,
                        WidgetText: $widgetText,
                        WidgetTextXAxis: $widgetTextXAxis,
                        WidgetTextYAxis: $widgetTextYAxis,
                        WidgetTextSize: $widgetTextSize,
                        WidgetTextColor: $widgetTextColor,
                        WidgetRandomQuote: $isWidgetRandomQuoteEnabled
                    )
                    
                    VStack(spacing: 20) {
                        HStack {
                            Toggle("Generate Random Quote", isOn: $isWidgetRandomQuoteEnabled)
                                .onChange(of: isWidgetRandomQuoteEnabled) { oldValue, newValue in
                                    if newValue {
                                        widgetText = famousQuotes.randomElement() ?? "No quote found"
                                    } else {
                                        widgetText = ""
                                    }
                                }
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        // Button to generate new random quote when toggle is on
                        if isWidgetRandomQuoteEnabled {
                            Button("Generate New Quote") {
                                widgetText = famousQuotes.randomElement() ?? "No quote found"
                            }
                            .buttonStyle(.bordered)
                        }
                        
                        Divider()
                        
                        VStack {
                            Text("Text Size: \(Int(widgetTextSize))")
                            Slider(value: $widgetTextSize, in: 8...50, step: 1)
                                .padding(.horizontal)
                        }
                        
                        Divider()
                        
                        VStack {
                            Text("X Position: \(Int(widgetTextXAxis))")
                            Slider(value: $widgetTextXAxis, in: 50...350, step: 10)
                                .padding(.horizontal)
                        }
                        
                        VStack {
                            Text("Y Position: \(Int(widgetTextYAxis))")
                            Slider(value: $widgetTextYAxis, in: 30...170, step: 10)
                                .padding(.horizontal)
                        }
                        
                        Divider()
                        
                        ColorPicker("Text Color", selection: $widgetTextColor)
                            .padding(.horizontal)
                    }
                    .padding()
                }
            }
            .navigationTitle("Random Quote Widget")
        }
    }
}

#Preview {
    EditRandomQuoteView()
}
