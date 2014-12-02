//
//  SHCBoardTest.m
//  SHCReversiGame
//
//  Created by Frankie on 12/1/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SHCBoard.h"
#import "SHCReversiBoard.h"

@interface SHCBoardTest : XCTestCase

@end

@implementation SHCBoardTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)test_setCellState_setWithValidCoords_cellStateIsChanged
{
    SHCBoard* board = [[SHCBoard alloc] init];
    
    // set the state of one of the cells
    [board setCellState:BoardCellStateWhitePiece forColumn:4 andRow:5];
    
    // verify
    BoardCellState retrievedState = [board cellStateAtColumn:4 andRow:5];
    XCTAssertEqual(BoardCellStateWhitePiece, retrievedState, @"The cell should have been white!");
}

- (void)test_setCellState_setWithInvalidCoords_exceptionWasThrown
{
    SHCBoard* board = [[SHCBoard alloc] init];
    
    @try {
        // set the state of a cell at an invalid coordinate
        [board setCellState:BoardCellStateBlackPiece forColumn:10 andRow:5];
        
        // if an exception was not thrown, this line will be reached
        XCTFail(@"An exception should have been thrown!");
    }
    @catch (NSException* e) {
        
    }
}

- (void)test_readInitialCellState
{
    /*Initial State (w - white, b - black, . - empty space)
     
     _  0   1   2   3   4   5   6   7
     0  .   .   .   .   .   .   .   .
     1  .   .   .   .   .   .   .   .
     2  .   .   .   .   .   .   .   .
     3  .   .   .   w   b   .   .   .
     4  .   .   .   b   w   .   .   .
     5  .   .   .   .   .   .   .   .
     6  .   .   .   .   .   .   .   .
     7  .   .   .   .   .   .   .   .
     
     */
    
    SHCReversiBoard *reversiBoard = [[SHCReversiBoard alloc]init];
    
    [reversiBoard setToInitialState];
    
    XCTAssertEqual(BoardCellStateWhitePiece, [reversiBoard cellStateAtColumn:3 andRow:3], @"The cell should have been white!");
    
    XCTAssertEqual(BoardCellStateWhitePiece, [reversiBoard cellStateAtColumn:4 andRow:4], @"The cell should have been white!");
    
    XCTAssertEqual(BoardCellStateBlackPiece, [reversiBoard cellStateAtColumn:3 andRow:4], @"The cell should have been black!");
    
    XCTAssertEqual(BoardCellStateBlackPiece, [reversiBoard cellStateAtColumn:4 andRow:3], @"The cell should have been black!");
}

@end
