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

import XCTest

@testable import Elm

extension Tests {

    //
    // MARK: -
    // MARK: Broadcast views
    //

    func testBroadcastViews1() {

        // Arrange
        let recorder1 = Recorder()
        let recorder2 = Recorder()
        let counter = Counter.makeProgram()
        counter.subscribe(recorder1)
        counter.subscribe(recorder2)

        // Act
        counter.dispatch(.userDidTapIncrementButton)
        counter.dispatch(.userDidTapDecrementButton)

        // Assert
        let expectedView1 = View(counterText: "0")
        let expectedView2 = View(counterText: "1")
        let expectedView3 = View(counterText: "0")
        XCTAssertEqual(recorder1.capturedViews, [expectedView1, expectedView2, expectedView3])
        XCTAssertEqual(recorder2.capturedViews, recorder1.capturedViews)

    }

    func testBroadcastViews2() {

        // Arrange
        let recorder1 = Recorder()
        let recorder2 = Recorder()
        let counter = Counter.makeProgram()
        counter.subscribe(recorder1)
        counter.subscribe(recorder2)

        // Act
        counter.dispatch(.userDidTapDecrementButton)
        counter.dispatch(.userDidTapIncrementButton)

        // Assert
        let expectedView1 = View(counterText: "0")
        let expectedView2 = View(counterText: "-1")
        let expectedView3 = View(counterText: "0")
        XCTAssertEqual(recorder1.capturedViews, [expectedView1, expectedView2, expectedView3])
        XCTAssertEqual(recorder2.capturedViews, recorder1.capturedViews)
        
    }

    //
    // MARK: -
    // MARK: Broadcast commands
    //

    func testBroadcastCommands1() {

        // Arrange
        let recorder1 = Recorder()
        let recorder2 = Recorder()
        let counter = Counter.makeProgram()
        counter.subscribe(recorder1)
        counter.subscribe(recorder2)

        // Act
        counter.dispatch(.userDidTapIncrementButton)
        counter.dispatch(.userDidTapDecrementButton)

        // Assert
        let expectedCommand1 = Command.log("Increment button tapped")
        let expectedCommand2 = Command.log("Decrement button tapped")
        XCTAssertEqual(recorder1.capturedCommands, [expectedCommand1, expectedCommand2])
        XCTAssertEqual(recorder2.capturedCommands, recorder1.capturedCommands)
        
    }

    func testBroadcastCommands2() {

        // Arrange
        let recorder1 = Recorder()
        let recorder2 = Recorder()
        let counter = Counter.makeProgram()
        counter.subscribe(recorder1)
        counter.subscribe(recorder2)

        // Act
        counter.dispatch(.userDidTapDecrementButton)
        counter.dispatch(.userDidTapIncrementButton)

        // Assert
        let expectedCommand1 = Command.log("Decrement button tapped")
        let expectedCommand2 = Command.log("Increment button tapped")
        XCTAssertEqual(recorder1.capturedCommands, [expectedCommand1, expectedCommand2])
        XCTAssertEqual(recorder2.capturedCommands, recorder1.capturedCommands)

    }

}
