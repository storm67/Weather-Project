////MIT License
////
////Copyright (c) 2019 Michel Anderson Lüz Teixeira
////
////Permission is hereby granted, free of charge, to any person obtaining a copy
////of this software and associated documentation files (the "Software"), to deal
////in the Software without restriction, including without limitation the rights
////to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
////copies of the Software, and to permit persons to whom the Software is
////furnished to do so, subject to the following conditions:
////
////The above copyright notice and this permission notice shall be included in all
////copies or substantial portions of the Software.
////
////THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
////IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
////FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
////AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
////LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
////OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
////SOFTWARE.

import UIKit

public struct MLDotConfig {
    public var color: UIColor = .lightGray
    public var innerRadius: CGFloat = 10
    public var outerRadius: CGFloat = 10
    public var animate: Bool = true

    public init(color: UIColor?, innerRadius: CGFloat?,
                outerRadius: CGFloat?, animate: Bool?) {
        if let color = color {
            self.color = color
        }

        if let innerRadius = innerRadius {
            self.innerRadius = innerRadius
        }

        if let outerRadius = outerRadius {
            self.outerRadius = outerRadius
        }

        if let animate = animate {
            self.animate = animate
        }
    }

     public init() {}
}
