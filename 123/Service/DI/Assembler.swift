//
//  Assembler.swift
//  123
//
//  Created by Andrey on 22/10/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import Swinject

extension Assembler {
    static let sharedAssembler: Assembler = {
        let container = Container()

        let assembler = Assembler(
            [
                Injector()
            ],
            container: container)

        return assembler
    }()
}
