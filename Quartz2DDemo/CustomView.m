//
//  CustomView.m
//  Quartz2DDemo
//
//  Created by zpf on 2017/6/30.
//  Copyright © 2017年 XiHeLaoBo. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

/*
 基本绘图
 在iOS中绘图一般分为以下几个步骤:
 
 1.获取绘图上下文
 2.创建并设置路径
 3.将路径添加到上下文
 4.设置上下文状态
 5.绘制路径
 6.释放路径
 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

//绘图只能在此方法中调用,否则无法得到当前图形的上下文
- (void)drawRect:(CGRect)rect {
    //1.获取到图像上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.创建路径对象
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGAffineTransform transform = CGAffineTransformScale(self.transform, 1, 1);
    
    CGPathMoveToPoint(path, &transform, rect.origin.x, rect.origin.y + 50);//移动到指定位置(设置路径起点)
    CGPathAddLineToPoint(path, &transform, rect.origin.x + 50, rect.origin.y + 100);//绘制直线（从起始位置开始）
    CGPathAddLineToPoint(path, &transform, [UIScreen mainScreen].bounds.size.width - 50, rect.origin.y + 100);//绘制另外一条直线（从上一直线终点开始绘制）
    CGPathAddLineToPoint(path, &transform, [UIScreen mainScreen].bounds.size.width, rect.origin.y + 50);
    
    //3.将路径添加到上下文
    CGContextAddPath(context, path);
    
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1.0);//设置笔触颜色
    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1.0);//设置填充颜色
    CGContextSetLineWidth(context, 2);//设置线条宽度
    CGContextSetLineCap(context, kCGLineCapRound);//设置顶点样式
    CGContextSetLineJoin(context, kCGLineJoinRound);//设置连接点样式
    
    //封闭路径
    CGContextClosePath(context);
    
    /*
     4.设置线段样式
     phase:虚线开始的位置
     lengths:虚线长度间隔 lengths值为｛10, 20, 10｝，则表示先绘制10个点，跳过20个点，绘制10个点，跳过10个点，再绘制20个点，如此反复
     lengths的值｛10,10｝表示先绘制10个点，再跳过10个点，如此反复
     count:虚线数组元素个数(count的值等于lengths数组的长度)
     */
    CGFloat lengths[3] = {10, 20, 10};
    CGContextSetLineDash(context, 50, lengths, 3);
    
    /*设置阴影
     context:图形上下文
     offset:偏移量
     blur:模糊度
     color:阴影颜色
     */
    CGColorRef color = [UIColor grayColor].CGColor;//颜色转化，由于Quartz 2D跨平台，所以其中不能使用UIKit中的对象，但是UIkit提供了转化方法
    CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0.8, color);
    
    //5.绘制图像到指定图形上下文
    /*CGPathDrawingMode是填充方式,枚举类型
     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     kCGPathStroke:只有边框
     kCGPathFillStroke：既有边框又有填充
     kCGPathEOFillStroke：奇偶填充并绘制边框
     */
    CGContextDrawPath(context, kCGPathFillStroke);//最后一个参数是填充类型
    
    //6.释放对象
    CGPathRelease(path);
    
    
    //----------------------------简化绘图方式-----------------------
    
    
    //上面的绘图方式未免显得有些麻烦，其实Core Graphics 内部对创建对象添加到上下文这两步操作进行了封装，可以一步完成。另外前面也说过UIKit内部其实封装了一些以“UI”开头的方法帮助大家进行图形绘制。就拿前面的例子来说我们改进一些绘制方法
    
    //绘制路径(相当于前面创建路径并添加路径到图形上下文两步操作)
    CGContextMoveToPoint(context, 0, rect.origin.y + 120);
    CGContextAddLineToPoint(context, 50, rect.origin.y + 220);
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width, rect.origin.y + 220);
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width - 50, rect.origin.y + 120);
    
    //封闭路径:直接调用路径封闭方法
    CGContextClosePath(context);
    
    //设置图形上下文属性
    [[UIColor yellowColor] setFill];
    [[UIColor blueColor] setStroke];
    CGContextSetLineWidth(context, 0);
    CGContextSetShadow(context, CGSizeMake(0, 0), 0);
    
    //开始绘制
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    //画椭圆(加阴影)
    CGContextAddEllipseInRect(context, CGRectMake(0, 250, 300, 150));
    
    [[UIColor redColor] setFill];
    
    CGContextSetShadowWithColor(context, CGSizeMake(20, 30), 30, [UIColor yellowColor].CGColor);
    
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //绘制弧形
    /*添加弧形对象
     x:中心点x坐标
     y:中心点y坐标
     radius:半径
     startAngle:起始弧度
     endAngle:终止弧度
     closewise:是否逆时针绘制，0则顺时针绘制
     */
    CGContextAddArc(context, [UIScreen mainScreen].bounds.size.width / 2, 550, 100, 0.0, -M_PI_2, 0);
    
    CGContextSetShadow(context, CGSizeMake(0, 0), 0);
    
    [[UIColor blueColor] set];
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //注:矩形就不列出来了   方法都是一样的大家可以尝试一下
}

@end
