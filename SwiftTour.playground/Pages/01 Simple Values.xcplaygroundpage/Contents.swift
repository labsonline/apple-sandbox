//: [Previous](@previous)
var myVariable = 42
myVariable = 50
let myConstant = 42

let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70

let label =  "The width is "
let width = 94
let widthLabel = label + String(width)

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

let quotation = """
  Even though there's whitespace to the left,
  the actual lines aren't indented.
      Except for this line.
  Double quotes (") can appear without being escaped.
  
  I still have \(apples + oranges) pieces of fruit.
  """

var fruits = ["strawberries", "limes", "tangerines"]
fruits[1] = "grapes"

var occupations = [
  "Malcom": "Captain",
  "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"

fruits.append("blueberries")
print(fruits)

let emptyArray: [String] = []
let emptyDictionary: [String: Float] = [:]


//: [Next](@next)
