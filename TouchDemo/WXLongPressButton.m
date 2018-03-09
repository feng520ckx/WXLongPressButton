//
//  WXLongPressButton.m
//  TouchDemo
//
//  Created by caikaixuan on 2018/3/6.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

#import "WXLongPressButton.h"

@interface WXLongPressButton()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *whiteLayer;

@property (nonatomic, strong) CAShapeLayer *grayLayer;

@property (nonatomic, strong) CAShapeLayer *cicleLayer;

@property (nonatomic, strong) NSTimer *circleTimer;

@property (nonatomic, assign) CGFloat endStrokeValue;

@end

@implementation WXLongPressButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI:frame];
        [self setupEvent];
        [self setupInitData];
    }
    return self;
}

- (void)setupUI:(CGRect)frame{
    
    CGPoint center=CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
    
    self.grayLayer = [[CAShapeLayer alloc]init];
    self.grayLayer.fillColor=[UIColor colorWithRed:189/255.0 green:187/255.0 blue:188/255.0 alpha:1.0f].CGColor;
    self.grayLayer.frame=self.bounds;
    UIBezierPath *bPath = [UIBezierPath bezierPathWithArcCenter:center radius:frame.size.width/3.0
                                                     startAngle:0 endAngle:M_PI*2 clockwise:YES];
    self.grayLayer.path=bPath.CGPath;
    [self.layer addSublayer:self.grayLayer];
    
    self.whiteLayer = [[CAShapeLayer alloc]init];
    self.whiteLayer.fillColor=[UIColor whiteColor].CGColor;
    self.whiteLayer.frame=self.bounds;
    UIBezierPath *bwPath = [UIBezierPath bezierPathWithArcCenter:center radius:frame.size.width/4.0
                                                     startAngle:0 endAngle:M_PI*2 clockwise:YES];
    self.whiteLayer.path=bwPath.CGPath;
    [self.layer addSublayer:self.whiteLayer];
    
    self.cicleLayer=[[CAShapeLayer alloc]init];
    self.cicleLayer.fillColor = [UIColor clearColor].CGColor;
    self.cicleLayer.strokeColor = [UIColor colorWithRed:90/255.0 green:184/25.0 blue:87/255.0 alpha:1.0f].CGColor;
    self.cicleLayer.lineCap = kCALineCapRound;
    self.cicleLayer.lineJoin = kCALineJoinRound;
    self.cicleLayer.lineWidth = 5;
    self.cicleLayer.strokeEnd=0;
    self.cicleLayer.affineTransform=CGAffineTransformRotate(self.cicleLayer.affineTransform, -M_PI/2.0f);
    UIBezierPath *bCirclePath = [UIBezierPath bezierPathWithArcCenter:center radius:frame.size.width/2.0f-5
                                                     startAngle:0 endAngle:M_PI*2 clockwise:YES];
    self.cicleLayer.path=bCirclePath.CGPath;
    self.cicleLayer.frame = self.bounds;
    [self.layer addSublayer:self.cicleLayer];
    
}

- (void)setupEvent{
    
    UILongPressGestureRecognizer *longPressEvent=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressEvent:)];
    [self addGestureRecognizer:longPressEvent];
    
}

- (void)setupInitData{
    self.totalTimeInterval=10;
}

- (void)startAnimation{
    
    CABasicAnimation *grayAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    grayAnimation.toValue=@(1.4);
    grayAnimation.duration=0.25;
    grayAnimation.removedOnCompletion = NO;
    grayAnimation.fillMode = kCAFillModeForwards;
    grayAnimation.delegate=self;
    [self.grayLayer addAnimation:grayAnimation forKey:@"grayAnimation"];
    
    CABasicAnimation *whiteAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    whiteAnimation.toValue=@(0.66);
    whiteAnimation.duration=0.25;
    whiteAnimation.removedOnCompletion = NO;
    whiteAnimation.fillMode = kCAFillModeForwards;
    [self.whiteLayer addAnimation:whiteAnimation forKey:@"whiteAnimation"];
    
}

- (void)resetState{
    
    [self.grayLayer removeAnimationForKey:@"grayAnimation"];
    [self.whiteLayer removeAnimationForKey:@"whiteAnimation"];
    self.cicleLayer.strokeEnd=0;
    self.endStrokeValue=0.0;
    
}

#pragma mark event

- (void)longPressEvent:(UILongPressGestureRecognizer *)gesture{
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self startAnimation];
            break;
        case UIGestureRecognizerStateEnded:
            [self stopCircleAnimation];
        default:
            break;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        //开启计时
        self.circleTimer=[NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(startCircleAnimation) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.circleTimer forMode:NSDefaultRunLoopMode];
    }
}

- (void)startCircleAnimation{
    self.endStrokeValue+=(1/(self.totalTimeInterval*100));
    if (self.endStrokeValue==1) {
        [self.circleTimer invalidate];
        self.circleTimer=nil;
        self.endStrokeValue=1.0f;
    }
    self.cicleLayer.strokeEnd=self.endStrokeValue;
}

- (void)stopCircleAnimation{
    [self.circleTimer invalidate];
    self.circleTimer=nil;
    if (self.complete) {
        self.complete(self.totalTimeInterval*self.endStrokeValue);
    }
}

@end
