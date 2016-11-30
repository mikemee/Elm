// The MIT License (MIT)
//
// Copyright (c) 2016 Rudolf Adamkovič
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Elm

//
// MARK: -
// MARK: Shortcuts
//

typealias Message = Counter.Message
typealias View = Counter.View
typealias Model = Counter.Model
typealias Command = Counter.Command

//
// MARK: -
// MARK: Module
//

struct Counter: Module {

    enum Message {
        case userDidTapIncrementButton
        case userDidTapDecrementButton
    }

    struct Model: Initable {
        var count = 0
    }

    struct View {
        let counterText: String
    }

    enum Command {
        case log(String)
    }

    static func update(for message: Message, model: inout Model) -> [Command] {
        switch message {
        case .userDidTapIncrementButton:
            model.count += 1
            return [.log("Increment button tapped")]
        case .userDidTapDecrementButton:
            model.count -= 1
            return [.log("Decrement button tapped")]
        }
    }

    static func view(for model: Model) -> View {
        let counterText = String(model.count)
        return View(counterText: counterText)
    }

}

//
// MARK: -
// MARK: Equatable
//

extension Command: Equatable {
    static func ==(lhs: Command, rhs: Command) -> Bool {
        return String(describing: lhs) == String(describing: rhs)
    }
}

extension View: Equatable {
    static func ==(lhs: View, rhs: View) -> Bool {
        return String(describing: lhs) == String(describing: rhs)
    }
}
