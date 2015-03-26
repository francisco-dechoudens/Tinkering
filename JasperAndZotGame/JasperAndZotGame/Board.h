//
//  Board.h
//  JasperAndZotGame
//
//  Created by Frankie on 12/3/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardCellState.h"
#import "SHCMulticastDelegate.h"

@interface Board : NSObject

// gets the state of the cell at the given location
- (BoardCellState) cellStateAtColumn:(NSInteger)column andRow:(NSInteger)row;

// sets the state of the cell at the given location
- (void) setCellState:(BoardCellState)state forColumn:(NSInteger)column andRow:(NSInteger)row;

- (BoardCellState)cellLastStateAtColumn:(NSInteger)column andRow:(NSInteger)row;

// clears the entire board
- (void) clearBoard;

// multicasts changes in cell state. Each delegate is informed of changes in state of individual cells.
@property (readonly) SHCMulticastDelegate* boardDelegate;

@end
