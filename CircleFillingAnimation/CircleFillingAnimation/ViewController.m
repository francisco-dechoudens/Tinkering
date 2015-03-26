//
//  ViewController.m
//  CircleFillingAnimation
//
//  Created by Frankie on 3/23/15.
//  Copyright (c) 2015 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"

#define   DEGREES_TO_RADIANS(degrees)  ((3.14159265359 * degrees)/ 180)

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *circleView;
@property float pushCounter;
@property int counter;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
    self.circleView.layer.cornerRadius = self.circleView.frame.size.width / 2;
    self.circleView.clipsToBounds = YES;
    self.circleView.layer.borderWidth = 3.0f;
    self.circleView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    */
    
    [self initialFigure];
    
}

-(void) initialFigure{
    
    UIBezierPath *aPath;
    
    aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake((self.circleView.frame.origin.x + self.circleView.frame.size.width)/2, (self.circleView.frame.origin.y + self.circleView.frame.size.height)/2)
                                           radius:self.circleView.frame.size.width/2
                                       startAngle:DEGREES_TO_RADIANS(0)
                                         endAngle:DEGREES_TO_RADIANS(360)
                                        clockwise:YES];
    
    
    
    
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [aPath CGPath];
    shapeLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
    shapeLayer.lineWidth = 3.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [self.circleView.layer addSublayer:shapeLayer];
}

- (IBAction)plus:(id)sender {
    
    UIBezierPath *aPath;

    _counter++;
    
    
    _pushCounter = ((540.0/2) + _counter*(540.0/2)/12.0);
        
    aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake((self.circleView.frame.origin.x + self.circleView.frame.size.width)/2, (self.circleView.frame.origin.y + self.circleView.frame.size.height)/2)
                                                             radius:self.circleView.frame.size.width/2
                                                         startAngle:DEGREES_TO_RADIANS(540/2)
                                                           endAngle:DEGREES_TO_RADIANS(_pushCounter)
                                                          clockwise:YES];

    
    
    
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [aPath CGPath];
    shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
    shapeLayer.lineWidth = 3.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [self.circleView.layer addSublayer:shapeLayer];
}
- (IBAction)minusBtn:(id)sender {
    
    [self initialFigure];
    UIBezierPath *aPath;
    
    _counter--;
    
    
    _pushCounter = ((540.0/2) + _counter*(540.0/2)/12.0);
    
    aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake((self.circleView.frame.origin.x + self.circleView.frame.size.width)/2, (self.circleView.frame.origin.y + self.circleView.frame.size.height)/2)
                                           radius:self.circleView.frame.size.width/2
                                       startAngle:DEGREES_TO_RADIANS(540/2)
                                         endAngle:DEGREES_TO_RADIANS(_pushCounter)
                                        clockwise:YES];
    
    
    
    
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [aPath CGPath];
    shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
    shapeLayer.lineWidth = 3.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [self.circleView.layer addSublayer:shapeLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
