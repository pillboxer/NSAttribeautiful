# NSAttribeautiful

NSAttribeautiful is an iOS and MacOS framework that provides an easy way of using multiple styles (fonts, sizes and colors) in one string

## How It Works

1. Choose some text (a _document_) that requires multiple formatting styles.

<p align="center"><code>Here is my document that needs to be formatted</code></p>

2. Choose a pair of unique _tokens_ that will enclose any NSAttribeautiful arguments. By default the prefix token is `≤` and the suffix token `≥`. All examples in this README will use the default tokens.

3. Define the _GroupContainer_ and add it to the beginning of any document. Each _Group_ within the container is enclosed by brackets and follows the format `fontName:fontSize:fontColor`:

<p align="center"><code>≤[Copperplate:12:blue][Arial:8:red]≥ Here is my document that needs to be formatted`</code></p>

4. Enclose any words that should styled with your unique tokens 

<p align="center">
  <code>≤[Copperplate:12:blue][Arial:8:red]≥ Here is my ≤document≥ that ≤needs≥ to be ≤formatted≥</code>
  <img src="/Assets/formatted0.png" />
</p>

