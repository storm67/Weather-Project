//
//  SwinjectStoryboard.swift
//  123
//
//  Created by Andrey on 22/10/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import SwinjectStoryboard
import Swinject

extension SwinjectStoryboard {
    class func setup() {
      let assembler = Assembler(container: defaultContainer)
      assembler.apply(assemblies: [Injector()])
    }
}
