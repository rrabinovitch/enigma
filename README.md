# Enigma
Turing Mod1 final solo project - specs [here](https://backend.turing.io/module1/projects/enigma/index)

This was project encrypts and decrypts messages via the command line. These functions are executed using a shift (consisting of a key and an offset), which determines how many indexes each letter should be shifted. When given an encryption command with a key and offset, the program will generate the shift based on those inputs; and when not provided with those inputs, they will be generated automatically by the program. Decryption requires a key and date in order to identify the shift and decode the message.

This project is the culmination of my learnings from Mod1 of the Turing School of Software & Design Backend Program. It demonstrates proficiency with:
* OOP Principles:
  * Aside from the required `Enigma` class, a `Key` class and a `Cipher` class are each implemented. `Key` contains a class method that simply returns a randomly generated key to be implemented if the user has not provided a key themselves. This is separated from `Enigma` because it is an object of its own, not intrinsically tied to `Enigma`. 
  * `Cipher` represents a generic encryption/decryption framework from which `Enigma` - a specific type of encryption/decryption framework - inherits its attributes and methods. Ideally `Cipher` would allow for flexibility in the number/type of shifts it can generate, but because this project only involves `Enigma` and not other types of ciphers and with the YAGNI principle in mind, I have not built out that flexible functionality. Though in the grand scheme it might not be the perfect use-case, this implementation makes sense given the context.
* Ruby Conventions and Mechanisms
  * Well-organized code, properly indented, spaced, and lines kept reasonable in length
  * Hashes are utilized to create the A-D keys, offsets, and shifts, as well as the A-D shifted alphabets referenced in the encryption and decryption process. Creating a hash with `:A` - `:D` as keys and the respective shifted alphabets allowed for a more straightforward process of translating each character than using the `Array#zip` method, as the approach ultimately implemented simply required referencing a key, which is known based on the original character - rather than needing to reference multiple indexes.
  * Each alphabet within that hash was created using `#reduce`, which seems appropriate considering the array `@alphabet` was used as the basis for creating a hash. I also used `#map.with_index` to execute the shifting of message characters, which seems appropriate considering the index was necessary in order to identify which shift needed to be used for which character, and the resulting collection was simply a transformation of the original collection of characters.
  * Longest method is 7 lines
* Test Driven Development
  * Every method is tested at both unit and integration level and expected behavior is completely verified, including 100% coverage.
  * The `#encrypt` and `#decrypt` methods test edge cases like encrypting or decrypting messages that include punctuation. Except for in a few cases during the process of refactoring and separating out helper methods, all methods had tests composed before the methods themselves were composed.
  * Stubs are used to ensure even methods that involve randomization are tested (e.g., `Key::generate`) and to allow for testing without relying on functionality from other methods (e.g., stubbed `Enigma#format_date` and `Key::generate` when testing `Enigma#encrypt` without user-provided date).
* Version Control
  * Project includes >120 commits and 12 branches, broken down by method and related functionality or editing.
  * Most - if not all - commits cover limited individual pieces of functionality
  * Commit messages are (subjectively ¯\_(ツ)_/¯ ) clear
  

## Local Set Up
```ruby
# clone repository to your local machine
$ git clone git@github.com:rrabinovitch/enigma.git

# required gems
$ gem install minitest
$ gem install mocha
$ gem install simplecov
$ gem install date
$ gem install rake
```
Follow the interaction patterns displayed [here](https://backend.turing.io/module1/projects/enigma/requirements) to try out encryption and decryption.
