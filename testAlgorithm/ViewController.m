//
//  ViewController.m
//  testAlgorithm
//
//  Created by cherrydemo M on 2019/3/22.
//  Copyright © 2019 cherrydemo M. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self logMatrixWithLength:3 width:3];
}

#pragma mark - 顺时针打印矩阵
- (void)logMatrixWithLength:(NSInteger)length width:(NSInteger)width{
    //构造数据源数组，例如 3*3 的矩阵，那么数组就装 1，2，3，4，5，6，7，8，9
    NSMutableArray *originArray = [NSMutableArray arrayWithCapacity:length * width];
    for (int i = 1; i <= length*width; i++) {
        [originArray addObject:@(i)];
    }
    
    //构造 log 用的容器二维数组
    NSMutableArray *logArr = [NSMutableArray arrayWithCapacity:width];
    for (int i = 0; i < width; i++) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:length];
        for (int j = 0; j < length; j++) {
            [arr addObject:@"w"];
        }
        [logArr addObject:arr];
    }
    
    //二维数组填充，并 log
    [self logWithTwoDimensionArray:[self arrangeWithLength:length width:width originArray:originArray logArray:logArr]];
}

// 构造顺时针螺旋的二维数组
- (NSArray *)arrangeWithLength:(NSInteger)length width:(NSInteger)width originArray:(NSArray *)originArray logArray:(NSMutableArray *)logArr {
    NSInteger j = 1;
    NSInteger x = 0;
    NSInteger y = 0;
    BOOL coordinateX = YES;
    BOOL inCrease = YES;
    
    for (NSNumber *num in originArray) {
        logArr[y][x] = num;
        
        if ([originArray lastObject] == num) { //若已是最后一个，则直接 break
            break;
        }
        
        if (coordinateX) { //坐标 x
            if (j % length == 0) {
                coordinateX = NO;
                j = 1;
                width--;
                inCrease ? y++ : y--;
            } else {
                j++;
                inCrease ? x++ : x--;
            }
            
        } else { //坐标 y
            if (j % width == 0) {
                coordinateX = YES;
                j = 1;
                length--;
                inCrease ? x-- : x++;
                inCrease = !inCrease;
            } else {
                j++;
                inCrease ? y++ : y--;
            }
        }
    }
    
    return [logArr copy];
}

// 输出二维数组
- (void)logWithTwoDimensionArray:(NSArray *)twoDimensionArray {
    for (NSArray *arr in twoDimensionArray) {
        NSMutableString *str = [NSMutableString string];
        for (NSNumber *num in arr) {
            [str appendFormat:@"%2d ",num.integerValue];
        }
        NSLog(@"%@",str);
    }
}

#pragma mark - 没优化逻辑前的：
- (NSArray *)beforeOptimizeVersionArrangeWithLength:(NSInteger)length width:(NSInteger)width originArray:(NSArray *)originArray logArray:(NSMutableArray *)logArr {
    NSInteger j = 1;
    NSInteger x = 0;
    NSInteger y = 0;
    BOOL coordinateX = YES;
    BOOL inCrease = YES;
    
    for (NSNumber *num in originArray) {
        logArr[y][x] = num;
        
        if ([originArray lastObject] == num) { //若已是最后一个，则直接 break
            break;
        }
        
        if (coordinateX) { //坐标 x
            if (inCrease) { //递增层
                if (j % length == 0) {
                    coordinateX = NO;
                    y++;
                    j = 1;
                    width--;
                } else {
                    x++;
                    j++;
                }
            } else { //递减层
                if (j % length == 0) {
                    coordinateX = NO;
                    y--;
                    j = 1;
                    width--;
                } else {
                    x--;
                    j++;
                }
            }
            
        } else { //坐标 y
            if (inCrease) { //递增层
                if (j % width == 0) {
                    coordinateX = YES;
                    x--;
                    j = 1;
                    length--;
                    inCrease = NO;
                } else {
                    y++;
                    j++;
                }
            } else { //递减层
                if (j % width == 0) {
                    coordinateX = YES;
                    x++;
                    j = 1;
                    length--;
                    inCrease = YES;
                } else {
                    y--;
                    j++;
                }
            }
            
        }
    }
    
    return [logArr copy];
}


@end
