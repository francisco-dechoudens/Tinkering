//
//  JasperAndZotBoard.m
//  JasperAndZotGame
//
//  Created by Frankie on 12/3/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "JasperAndZotBoard.h"

// A 'navigation' function. This takes the given row / column values and navigates in one of the 8 possible directions across the playing board.
typedef void (^BoardNavigationFunction)(NSInteger*, NSInteger*);

BoardNavigationFunction BoardNavigationFunctionRight = ^(NSInteger* c, NSInteger* r) {
    (*c)++;
};

BoardNavigationFunction BoardNavigationFunctionLeft = ^(NSInteger* c, NSInteger* r) {
    (*c)--;
};

BoardNavigationFunction BoardNavigationFunctionUp = ^(NSInteger* c, NSInteger* r) {
    (*r)--;
};

BoardNavigationFunction BoardNavigationFunctionDown = ^(NSInteger* c, NSInteger* r) {
    (*r)++;
};

BoardNavigationFunction BoardNavigationFunctionRightUp = ^(NSInteger* c, NSInteger* r) {
    (*c)++;
    (*r)--;
};

BoardNavigationFunction BoardNavigationFunctionRightDown = ^(NSInteger* c, NSInteger* r) {
    (*c)++;
    (*r)++;
};

BoardNavigationFunction BoardNavigationFunctionLeftUp = ^(NSInteger* c, NSInteger* r) {
    (*c)--;
    (*r)++;
};

BoardNavigationFunction BoardNavigationFunctionLeftDown = ^(NSInteger* c, NSInteger* r) {
    (*c)--;
    (*r)--;
};

@implementation JasperAndZotBoard
{
    BoardNavigationFunction _boardNavigationFunctions[8];
    int dieCounter;
}

- (id)init
{
    if (self = [super init]) {
        [self commonInit];
        [self setToInitialState];
    }
    return self;
}

- (void)setToInitialState
{
    // clear the board
    [super clearBoard];
    dieCounter = 0;
    
    // add initial play counters
   
    [super setCellState:BoardCellStatePumpkinPiece forColumn:0 andRow:9];
    [super setCellState:BoardCellStatePumpkinPiece forColumn:1 andRow:9];
    [super setCellState:BoardCellStatePumpkinPiece forColumn:2 andRow:9];
    [super setCellState:BoardCellStatePumpkinPiece forColumn:3 andRow:9];
    [super setCellState:BoardCellStatePumpkinPiece forColumn:4 andRow:9];
    [super setCellState:BoardCellStatePumpkinPiece forColumn:5 andRow:9];
    
    [super setCellState:BoardCellStateDiceField forColumn:3 andRow:0];
    
    [self clearJasperSpaces];
    
    [super setCellState:BoardCellStateJasperPiece forColumn:2 andRow:10];
    
    _jasperScore = 0;
    _zotScore = 0;
    
    // Black gets the first turn
    _turnPlayer = BoardCellStateJasperPiece;
}

- (void)commonInit
{
    // create an array of all 8 navigation functions
    _boardNavigationFunctions[0] = BoardNavigationFunctionUp;
    _boardNavigationFunctions[1] = BoardNavigationFunctionDown;
    _boardNavigationFunctions[2] = BoardNavigationFunctionLeft;
    _boardNavigationFunctions[3] = BoardNavigationFunctionRight;
    _boardNavigationFunctions[4] = BoardNavigationFunctionLeftDown;
    _boardNavigationFunctions[5] = BoardNavigationFunctionLeftUp;
    _boardNavigationFunctions[6] = BoardNavigationFunctionRightDown;
    _boardNavigationFunctions[7] = BoardNavigationFunctionRightUp;
    
}

-(void)clearJasperSpaces{
    [super setCellState:BoardCellStateJasperEmptyPiece forColumn:0 andRow:10];
    [super setCellState:BoardCellStateJasperEmptyPiece forColumn:1 andRow:10];
    [super setCellState:BoardCellStateJasperEmptyPiece forColumn:2 andRow:10];
    [super setCellState:BoardCellStateJasperEmptyPiece forColumn:3 andRow:10];
    [super setCellState:BoardCellStateJasperEmptyPiece forColumn:4 andRow:10];
    [super setCellState:BoardCellStateJasperEmptyPiece forColumn:5 andRow:10];
}

-(BOOL)isValidMoveToColumn:(NSInteger)column andRow:(NSInteger)row
{
    // check the cell is empty
    if ([super cellStateAtColumn:column andRow:row] != BoardCellStateJasperEmptyPiece)
        return NO;
    
    return YES;
}

- (void)makeMoveToColumn:(NSInteger)column andRow:(NSInteger)row
{
    // place the playing piece at the given location
    [self clearJasperSpaces];
    [self setCellState:self.turnPlayer forColumn:column andRow:row];//Move Jasper
    
    //Shoot
    // check the 8 play directions and flip pieces
    
    [self shootType:1
              forColumn:column andRow:row withNavigationFunction:_boardNavigationFunctions[0] toState:self.turnPlayer];
    
    
    [self decentPhase];
    [self diceFieldChanging];
    //dice formation changing
    //Enter zombie in field +  formation
}

-(void)shootType:(int)magicType forColumn:(NSInteger) column andRow:(NSInteger)row withNavigationFunction:(BoardNavigationFunction) navigationFunction toState:(BoardCellState) state
{
    
        BoardCellState opponentsState = [self invertState:state];
        BoardCellState currentCellState;
        
        // flip counters until the edge of the boards is reached, or
        // a piece of the current state is reached
        navigationFunction(&column, &row);//pass the pumkin
        do
        {
            // advance to the next cell
            navigationFunction(&column, &row);
            
            
            currentCellState = [super cellStateAtColumn:column andRow:row];
            if (currentCellState == BoardCellStateZombiePiece) {
                [self setCellState:BoardCellStateFlowerPiece forColumn:column  andRow:row];
                break;
            }
            
        }
        while(column>=0 && column<=5 &&
              row>=6 && row<=10);
        
}


-(void)decentPhase{
    
    
    NSMutableArray *needUpdateArray = [NSMutableArray new];
    
    for (int row = 0; row < 11; row++)
    {
        for (int col = 0; col < 6; col++)
        {
            if ([self cellStateAtColumn:col andRow:row] == BoardCellStateZombiePiece)
            {
                NSDictionary *needUpdate = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSNumber numberWithInt:col], @"col",[NSNumber numberWithInt:row], @"row", nil];
                
                [needUpdateArray addObject:needUpdate];
            }
        }
    }
    
    for (NSMutableDictionary* object in [needUpdateArray reverseObjectEnumerator]) {
        
        int row = [(NSNumber*)object[@"row"] intValue];
        int col = [(NSNumber*)object[@"col"] intValue];
        
        if ([self cellStateAtColumn:col andRow:row+1] == BoardCellStateZombiePiece || [self cellStateAtColumn:col andRow:row+1] == BoardCellStatePumpkinPiece || [self cellStateAtColumn:col andRow:row+1] == BoardCellStateFlowerPiece) {
  
        }
        else if ([self cellStateAtColumn:col andRow:row+2] == BoardCellStateZombiePiece || [self cellStateAtColumn:col andRow:row+2] == BoardCellStatePumpkinPiece || [self cellStateAtColumn:col andRow:row+2] == BoardCellStateFlowerPiece) {
            [self setCellState:BoardCellStateZombiePiece forColumn:col andRow:row+1];//esta es la vel cuanto se mueve
            [self setCellState:BoardCellStateEmpty forColumn:col andRow:row];
        }
        else{
            [self setCellState:BoardCellStateZombiePiece forColumn:col andRow:row+2];//esta es la vel cuanto se mueve
            [self setCellState:BoardCellStateEmpty forColumn:col andRow:row];
        }
        
    }
}

-(void)diceFieldChanging {
   
    if (dieCounter < [self getRandomNumberBetween:14 to:20]) {
        dieCounter += 1;
        [super setCellState:BoardCellStateEmpty forColumn:0 andRow:0];
        [super setCellState:BoardCellStateEmpty forColumn:1 andRow:0];
        [super setCellState:BoardCellStateEmpty forColumn:2 andRow:0];
        [super setCellState:BoardCellStateEmpty forColumn:3 andRow:0];
        [super setCellState:BoardCellStateEmpty forColumn:4 andRow:0];
        [super setCellState:BoardCellStateEmpty forColumn:5 andRow:0];
        [super setCellState:BoardCellStateDiceField forColumn:dieCounter%6 andRow:0];
        [self performSelector:@selector(diceFieldChanging) withObject:@"sleep 0.10 worked" afterDelay:.10];
       
    }
    else{
        dieCounter = 0;
        
        int index2Enter = [self getPositionToEnterZombies];
        
        [self formationsNumber:arc4random_uniform(6) levelDifficulty:1 positionToEnter:index2Enter];
        
    }
}

-(int)getPositionToEnterZombies{
    int index = 0;
    for (int i = 0; i < 6; i++) {
        if ([super cellStateAtColumn:i andRow:0] == BoardCellStateDiceField) {
            index = i;
        }
    }
    return index;
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

- (BoardCellState) invertState: (BoardCellState)state
{
    if (state == BoardCellStateZombiePiece)
        return BoardCellStateFlowerPiece;
    
    return BoardCellStateEmpty;
}

-(void)formationsNumber:(int)dieResult levelDifficulty:(int)level positionToEnter:(int)positionDie{
    switch (dieResult) {
        case 0:
            [super setCellState:BoardCellStateZombiePiece forColumn:positionDie andRow:0];
            break;
        case 1:
            [super setCellState:BoardCellStateZombiePiece forColumn:positionDie andRow:0];
            @try {
                [super setCellState:BoardCellStateZombiePiece forColumn:positionDie+1 andRow:0];
                ;
            }
            @catch (NSException * e) {
                NSLog(@"Exception: %@ , ignore", e);
                @try {
                    [super setCellState:BoardCellStateZombiePiece forColumn:positionDie-1 andRow:0];
                    ;
                }
                @catch (NSException * e) {
                    NSLog(@"Exception: %@ , ignore", e);
                }
            }
            break;
        case 2:
            [super setCellState:BoardCellStateZombiePiece forColumn:positionDie andRow:0];
            [super setCellState:BoardCellStateZombiePiece forColumn:positionDie andRow:1];
            break;
        case 3:
            [super setCellState:BoardCellStateZombiePiece forColumn:positionDie andRow:0];
            [super setCellState:BoardCellStateZombiePiece forColumn:positionDie andRow:1];
            @try {
                [super setCellState:BoardCellStateZombiePiece forColumn:positionDie+1 andRow:0];
                ;
            }
            @catch (NSException * e) {
                NSLog(@"Exception: %@ , ignore", e);
                @try {
                    [super setCellState:BoardCellStateZombiePiece forColumn:positionDie-1 andRow:0];
                    ;
                    [super setCellState:BoardCellStateEmpty forColumn:positionDie andRow:1];
                    [super setCellState:BoardCellStateZombiePiece forColumn:positionDie-1 andRow:1];
                }
                @catch (NSException * e) {
                    NSLog(@"Exception: %@ , ignore", e);
                }
            }
            break;
        case 4:
            [super setCellState:BoardCellStateZombiePiece forColumn:positionDie andRow:0];
            [super setCellState:BoardCellStateZombiePiece forColumn:positionDie andRow:1];
            @try {
                [super setCellState:BoardCellStateZombiePiece forColumn:positionDie-1 andRow:0];
                ;
            }
            @catch (NSException * e) {
                NSLog(@"Exception: %@ , ignore", e);
                @try {
                    [super setCellState:BoardCellStateZombiePiece forColumn:positionDie+1 andRow:0];
                    ;
                    [super setCellState:BoardCellStateEmpty forColumn:positionDie andRow:1];
                    [super setCellState:BoardCellStateZombiePiece forColumn:positionDie+1 andRow:1];
                }
                @catch (NSException * e) {
                    NSLog(@"Exception: %@ , ignore", e);
                }
            }
            break;
        case 5:
            [super setCellState:BoardCellStateZombiePiece forColumn:positionDie andRow:0];
            @try {
                [super setCellState:BoardCellStateZombiePiece forColumn:positionDie-1 andRow:0];
                ;
            }
            @catch (NSException * e) {
                NSLog(@"Exception: %@ , ignore", e);
                @try {
                    [super setCellState:BoardCellStateZombiePiece forColumn:positionDie+1 andRow:0];
                    ;
                    [super setCellState:BoardCellStateZombiePiece forColumn:positionDie+2 andRow:0];
                    ;
                    break;
                }
                @catch (NSException * e) {
                    NSLog(@"Exception: %@ , ignore", e);
                }
            }
            @try {
                [super setCellState:BoardCellStateZombiePiece forColumn:positionDie+1 andRow:0];
                ;
            }
            @catch (NSException * e) {
                NSLog(@"Exception: %@ , ignore", e);
                @try {
                    [super setCellState:BoardCellStateZombiePiece forColumn:positionDie-1 andRow:0];
                    ;
                    [super setCellState:BoardCellStateZombiePiece forColumn:positionDie-2 andRow:0];
                    ;
                    break;
                }
                @catch (NSException * e) {
                    NSLog(@"Exception: %@ , ignore", e);
                }
            }
            break;
        default:
            NSLog(@"Outside Value %d",dieResult);
            break;
    }
}

@end
