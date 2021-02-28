# NSAttribeautiful

NSAttribeautiful is an iOS and MacOS framework that provides an easy way of using multiple styles (fonts, sizes and colors) in one string

## How It Works

1. Choose some text (a _document_) that requires multiple formatting styles.

<p align="center"><code>Here is my document that needs to be formatted</code></p>

2. Choose a pair of unique _tokens_ that will enclose any NSAttribeautiful arguments. By default the prefix token is `≤` and the suffix token `≥`. All examples in this README will use the default tokens.

3. Define the _GroupContainer_ and add it to the beginning of any document. Each _Group_ within the container is enclosed by brackets and follows the format `fontName:fontSize:fontColor`:

<p align="center"><code>≤[Copperplate:18:blue][Arial:18:red]≥ Here is my document that needs to be formatted`</code></p>

4. Enclose any words (_Arguments_) that should styled with your unique tokens 

<p align="center">
  <code>≤[Copperplate:18:blue][Arial:18:red]≥ Here is my ≤document≥ that ≤needs≥ to be ≤formatted≥</code>
  <img src="/Assets/formatted0.png" />
</p>

5. By default, each _Group_ will be applied to an _Argument_ once before moving on to the next one. If there are more _Arguments_ than _Groups_ (like in the example above), the last _Group_ will be applied to any extra arguments. You can override this by adding a _GroupIndexContainer_ to the end of your document.<p>This is similar to the _GroupContainer_ but enclosed in the brackets are indexes of the _Group_ you wish to apply to a particular _Argument_. Each index must be separated by a comma.</p><p>In the example below, _Group_ '0' (Copperplate) will be applied to the first and second arguments ("document" & "needs") and _Group_ '1' will be applied to the last argument.</p>

<p align="center">
  <code>≤[Copperplate:18:blue][Arial:18:red]≥ Here is my ≤document≥ that ≤needs≥ to be ≤formatted≥ ≤[0,0,1]≥</code>
  <img src="/Assets/formatted1.png" />
</p>
