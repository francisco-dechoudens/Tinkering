//
//  MinuteSetupViewController.m
//  Christian Prayers
//
//  Created by Frankie on 3/23/15.
//  Copyright (c) 2015 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "MinuteSetupViewController.h"
#import "PlayerViewController.h"

#define   DEGREES_TO_RADIANS(degrees)  ((3.14159265359 * degrees)/ 180)

@interface MinuteSetupViewController ()
@property float pushCounter;
@property int counter;
@end

@implementation MinuteSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setCircleFigure];
    [self plus:self];
    
    _plusButton.layer.cornerRadius = _plusButton.frame.size.width / 2;
    _plusButton.layer.borderWidth = 3.0f;
    _plusButton.layer.borderColor = [UIColor blueColor].CGColor;
    _plusButton.clipsToBounds = YES;
    
    _minusButton.layer.cornerRadius = _plusButton.frame.size.width / 2;
    _minusButton.layer.borderWidth = 3.0f;
    _minusButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _minusButton.clipsToBounds = YES;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setCircleFigure{
    
    UIBezierPath *aPath;
    
    aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake((self.circleView.bounds.origin.x + self.circleView.bounds.size.width)/2, (self.circleView.bounds.origin.y + self.circleView.bounds.size.height)/2)
                                           radius:self.circleView.bounds.size.width/2
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
    
    self.numberMinuteLabel.text = [NSString stringWithFormat:@"%d",_counter*5];
    
    _pushCounter = ((540.0/2) + _counter*(540.0/2)/9.0);
    
    aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake((self.circleView.bounds.origin.x + self.circleView.bounds.size.width)/2, (self.circleView.bounds.origin.y + self.circleView.bounds.size.height)/2)
                                           radius:self.circleView.bounds.size.width/2
                                       startAngle:DEGREES_TO_RADIANS(540/2)
                                         endAngle:DEGREES_TO_RADIANS(_pushCounter)
                                        clockwise:YES];
    
    
    
    
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [aPath CGPath];
    shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
    shapeLayer.lineWidth = 3.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [self.circleView.layer addSublayer:shapeLayer];
    
    [self checkButtonConditions];
}

- (IBAction)minusBtn:(id)sender {
    
    [self setCircleFigure];
    UIBezierPath *aPath;
    
    _counter--;
    self.numberMinuteLabel.text = [NSString stringWithFormat:@"%d",_counter*5];
    
    _pushCounter = ((540.0/2) + _counter*(540.0/2)/9.0);
    
    aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake((self.circleView.bounds.origin.x + self.circleView.bounds.size.width)/2, (self.circleView.bounds.origin.y + self.circleView.bounds.size.height)/2)
                                           radius:self.circleView.bounds.size.width/2
                                       startAngle:DEGREES_TO_RADIANS(540/2)
                                         endAngle:DEGREES_TO_RADIANS(_pushCounter)
                                        clockwise:YES];
    
    
    
    
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [aPath CGPath];
    shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
    shapeLayer.lineWidth = 3.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [self.circleView.layer addSublayer:shapeLayer];
    
    [self checkButtonConditions];
}

-(void)checkButtonConditions{
    if (_counter <= 1) {
        self.minusButton.enabled = false;
        _minusButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    else{
        self.minusButton.enabled = true;
        _minusButton.layer.borderColor = [UIColor blueColor].CGColor;
    }
    
    if (_counter >= 12) {
        self.plusButton.enabled = false;
        _plusButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    else{
        self.plusButton.enabled = true;
        _plusButton.layer.borderColor = [UIColor blueColor].CGColor;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UINavigationController *nav = [segue destinationViewController];
    PlayerViewController *vc = nav.childViewControllers.firstObject;
    
    vc.prayerTypeObject = self.prayerTypeObject;
    
    vc.timeSelected = _counter*5;
}


@end
