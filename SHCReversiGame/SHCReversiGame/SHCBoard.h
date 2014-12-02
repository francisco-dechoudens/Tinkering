//
//  SHCBoard.h
//  SHCReversiGame
//
//  Created by Frankie on 12/1/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardCellState.h"
#import "SHCMulticastDelegate.h"

/*This will be the interface for working with your gameboard*/

/** An 8x8 playing board. */
@interface SHCBoard : NSObject

// multicasts changes in cell state. Each delegate is informed of changes in state of individual cells.
@property (readonly) SHCMulticastDelegate* boardDelegate;

// gets the state of the cell at the given location
- (BoardCellState) cellStateAtColumn:(NSInteger)column andRow:(NSInteger)row;

// sets the state of the cell at the given location
- (void) setCellState:(BoardCellState)state forColumn:(NSInteger)column andRow:(NSInteger)row;

// clears the entire board
- (void) clearBoard;

// counts the number of cells with the given state
- (NSUInteger) countCellsWithState:(BoardCellState)state;

@end
