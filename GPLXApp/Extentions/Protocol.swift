//
//  Protocal.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/14/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation
protocol TableViewCellProtocal : class {
    associatedtype T
    var data : T? {
        get  set
    }
}
