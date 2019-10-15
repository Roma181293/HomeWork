/*:
 ## Exercise - Methods
 
 A `Book` struct has been created for you below. Add an instance method on `Book` called `description` that will print out facts about the book. Then create an instance of `Book` and call this method on that instance.
 */
struct Book {
    var title: String
    var author: String
    var pages: Int
    var price: Double
    
    func Description() {
        print(" \"\(title)\" - \(author), \(pages)p., \(price)UAH")
    }
}

var fav = Book(title: "Picture of Dorian Grey", author: "Oscar Wilde", pages: 234, price: 543)
fav.Description()
/*:
 A `Post` struct has been created for you below, representing a generic social media post. Add a mutating method on `Post` called `like` that will increment `likes` by one. Then create an instance of `Post` and call `like()` on it. Print out the `likes` property before and after calling the method to see whether or not the value was incremented.
 */
struct Post {
    var message: String
    var likes: Int
    var numberOfComments: Int
    mutating func like() {
        likes += 1
    }
    
}

var foodPost = Post(message: "Food that we eat", likes: 0, numberOfComments: 0)
print(foodPost)
foodPost.like()
print(foodPost)
//: [Previous](@previous)  |  page 5 of 10  |  [Next: App Exercise - Workout Functions](@next)
