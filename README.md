# NSAttribeautiful

NSAttribeautiful is an iOS and MacOS framework that provides an easy way of using multiple styles (fonts, sizes and colors) in one string

## How It Works

1. Choose a document you wish to be formatted. (`Here is my document that needs to be formatted`)
2. Choose a pair of unique _tokens_ that will enclose any NSAttribeautiful arguments. By default the prefix token is `≤` and the suffix token `≥`. All examples in this README will use the default tokens.
3. Define any styles that will be used in the format `≤[myFirstFont:myFirstSize:myFirstColor][mySecondFont:mySecondSize:mySecondColor]≥`. This is known as the _GroupContainer_ and it must be present at the beginning of any document. 
