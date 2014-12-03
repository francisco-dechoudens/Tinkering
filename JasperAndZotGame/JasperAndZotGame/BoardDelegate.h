//
//  BoardDelegate.h
//  JasperAndZotGame
//
//  Created by Frankie on 12/3/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardCellState.h"

@protocol BoardDelegate <NSObject>

- (void)cellStateChanged:(BoardCellState)state forColumn:(int)column andRow:(int) row;

@end
