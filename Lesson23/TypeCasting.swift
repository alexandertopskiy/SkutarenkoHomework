import Foundation

// MARK: - Type Casting

class MediaFile {
    var name : String
    init(name: String) {
        self.name = name
    }
}

class Movie : MediaFile {
    var director : String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song : MediaFile {
    var artist : String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let mediaLibrary = [ // [MediaFile]
    Movie(name: "Green Mile", director: "Frank Darabont"),
    Movie(name: "Once Upon a Time... in Hollywood", director: "Quentin Tarantino"),
    Song(name: "WATAFAK", artist: "MORGENSTERN"),
    Song(name: "My name is", artist: "Eminem")
]

var (movieCount,songCount) = (0,0)

for mediaFile in mediaLibrary {
    if mediaFile is Movie {
        movieCount += 1
    } else if mediaFile is Song {
        songCount += 1
    }
}
print("There's \(movieCount) movies and \(songCount) songs in library") // There's 2 movies and 2 songs in library

for mediaFile in mediaLibrary {
    if let item = mediaFile as? Movie {
        print("Movie: '\(item.name)' by \(item.director)")
        item.name = "some new"
    } else if let item = mediaFile as? Song {
        print("Song: '\(item.name)' by \(item.artist)")
    }
}
print("===")
for mediaFile in mediaLibrary {
    if let item = mediaFile as? Movie {
        print("Movie: '\(item.name)' by \(item.director)")
    } else if let item = mediaFile as? Song {
        print("Song: '\(item.name)' by \(item.artist)")
    }
}


// MARK: - Приведение типов для Any и AnyObject

print("===")

var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int: print("Zero as Int")
    case 0 as Double: print("Zero as Double")
    case let someInt as Int: print("Integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0: print("Positive Double value of \(someDouble)")
    case is Double: print("Some other Double value of \(thing)")
    case let someString as String: print("String '\(someString)'")
    case let(x,y) as (Double,Double): print("Tuple: (x,y) point at (\(x),\(y))")
    case let movie as Movie: print("Movie \(movie.name) by \(movie.director)")
    case let stringConverter as (String) -> String : print(stringConverter("Bob"))
    default: print("something else")
    }
}


let optionalNumber: Int? = 3
things.append(optionalNumber)        // Warning
things.append(optionalNumber as Any) // No Warning

