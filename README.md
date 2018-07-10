# CBORSwift
![build status](https://travis-ci.org/Hassaniiii/CBORSwift.svg?branch=master)
![cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)
![Licence](https://img.shields.io/github/license/Hassaniiii/CBORSwift.svg)

The Concise Binary Object Representation (CBOR) is a data format whose design goals include the possibility of extremely small code size, fairly small message size, and extensibility without the need for version negotiation.

*CBORSwift* has implemented CBOR with Swift useful for **both iOS and macOS projects**.

## Getting Started
These instructions will help you to add `CBORSwift` to your current Xcode project in a few lines.

**Please note that currently, major 7 is supported for only Simple Values (True, False). Other majors are completed.** 

### Installation
#### Cocoapods
The easiest way to import *CBORSwift* to your current project is to use `Cocoapods`. Just add the following to your `Podfile`

`pod 'CBORSwift'`

#### Manual
You can also download the whole code manually and copy the following classes to your project based on your needs
```
CBOR.swift
Decoder.swift
Encoder.swift
Extensions.swift
MajorTypes.swift
```
## Usage
Using `CBORSwift` is as simple as possible. You'll need to call 2 functions for *encoding* and *decoding*. The most important point is that **You have to use `NSObject` instances and subclasses for encoding and decoding parameters.** You can find more useful use cases in [Encoder](https://github.com/Hassaniiii/CBORSwift/blob/master/CBORSwiftTests/CBOREncoderTests.swift) and [Decoder](https://github.com/Hassaniiii/CBORSwift/blob/master/CBORSwiftTests/CBORDecoderTests.swift) unit tests. There is also a comprehensive CBOR example in the [General](https://github.com/Hassaniiii/CBORSwift/blob/master/CBORSwiftTests/CBORSwiftTests.swift) unit test. 

**All tests are verified using [CBOR official tool](http://cbor.me/)**

For all *Encoding* and *Decoding* situations, you can use `encode`-`decode` either as a function, or as an extension:
```swift
var encoded = CBOR.encode(NSOBJECT_ITEM)
var decoded = CBOR.decode(NSOBJECT_ITEM)

var encoded = NSOBJECT_ITEM.encode()
var decoded = NSOBJECT_ITEM.decode()
```


#### Numbers (Positive, Negative) - *major 0 and 1*
Just create `NSNumber` instance and pass it to `encode`- `decode` function. Or, you can call `encode`-`decode` directly from the instance:

```swift
var encoded = CBOR.encode(NSNumber(value: 30))
var encoded = NSNumber(value: 3428).encode()

var encoded = CBOR.encode(NSNumber(value: -15))
var encoded = NSNumber(value: -42949295).encode()

var decoded = CBOR.decode([0x0A])
var decoded = [0x0A].decode()

var decoded = CBOR.decode([0x39, 0x01, 0x00])
var decoded = [0x39, 0x01, 0x00].decode()
```

#### Byte Strings - *major 2*
You'll need to create an instance of `NSByteString` class, and start playing with it:

```swift
var str = NSByteString("2525")

var encoded = CBOR.encode(str)
var encoded = str.encode()

var decoded = CBOR.decode([0x42, 0x25, 0x25])
var decoded = [0x42, 0x25, 0x25].decode()
```

#### Text Strings - *major 3*
New an instance of `NSString`, and that's it:

```swift
var encoded = CBOR.encode("hello" as NSString)
var encoded = ("hello" as NSString).encode()

var decoded = CBOR.decode([0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F])
var decoded = [0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F].decode()
```

#### Array - *major 4*
New an instance of `NSArray`:

```swift
var encoded = CBOR.encode([10] as NSArray)
var encoded = ([10, 15, -9] as NSArray).encode()

var decoded = CBOR.decode([0x81, 0x0A])
var decoded = [0x81, 0x0A].decode()
```

#### Map - *major 5*
Map actually is same as `NSDictionary`  in Apple programming systems:

```swift
var encoded = CBOR.encode(["sure":"shahbazi", "name":"hassan"] as NSDictionary)
var encoded = (["sure":"shahbazi", "name":"hassan"] as NSDictionary).encode()

var decoded = CBOR.decode([0xA1, 0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F, 0x65, 0x77, 0x6F, 0x72, 0x6C, 0x64])
var decoded = [0xA1, 0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F, 0x65, 0x77, 0x6F, 0x72, 0x6C, 0x64].decode()
```

#### Tagged values - *major 6*
If you want to encode and decode a tagged value, you can easily. The type of tagged values are in `NSTag` type.

```swift
var encoded = CBOR.encode(NSTag(tag: 5, NSNumber(value: 10))
var encoded =  NSTag(tag: 5, NSNumber(value: 10)).encode()

var decoded = CBOR.decode([0xC5, 0x0A])
var decoded = [0xC5, 0x0A].decode()
```

#### Bool - *major 7*
Boolian values are `major7` and known as the *Simple Values*:

````swift
var encoded = CBOR.encode(NSSimpleValue(false))
var encoded = CBOR.encode(NSSimpleValue(true))

var decoded = CBOR.decode([0xF4])
var decoded = CBOR.decode([0xF5])
````


## Contribution
Please ensure your pull request adheres to the following guidelines:

* Alphabetize your entry.
* Search previous suggestions before making a new one, as yours may be a duplicate.
* Suggested READMEs should be beautiful or stand out in some way.
* Make an individual pull request for each suggestion.
* New categories, or improvements to the existing categorization are welcome.
* Keep descriptions short and simple, but descriptive.
* Start the description with a capital and end with a full stop/period.
* Check your spelling and grammar.
* Make sure your text editor is set to remove trailing whitespace.

Thank you for your suggestions!

## Authors

* **Hassan Shahbazi** - [Hassaniiii](https://github.com/Hassaniiii)

## License
This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/Hassaniiii/CBORSwift/blob/master/LICENSE.md) file for details
