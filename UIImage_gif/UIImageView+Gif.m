//
//  UIImageView+Gif.m
//  UIImage_gif
//
//  Created by libo on 2017/2/10.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "UIImageView+Gif.h"

#import <ImageIO/ImageIO.h> //引入ImageIO库

@implementation UIImageView (Gif)

- (void)getGifImageWithUrl:(NSURL *)url retrurnData:(void (^)(NSArray<UIImage *> *, NSArray<NSNumber *> *, CGFloat, NSArray<NSNumber *> *, NSArray<NSNumber *> *))dataBlock {

    //通过文件的url来将gif文件读取为图片数据引用
    CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    //获取gif文件中图片的个数
    size_t count = CGImageSourceGetCount(source);
    //定义一个变量记录gif播放一轮的时间
    float allTime = 0;
    //存放所有图片
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    //存放每一帧播放的时间
    NSMutableArray *timeArray = [[NSMutableArray alloc]init];
    //存放每张图片的宽度 (一般在一个gif文件中,所有图片尺寸都会一样)
    NSMutableArray *widthArray = [[NSMutableArray alloc]init];
    //存放每张图片的高度
    NSMutableArray *heightArray = [[NSMutableArray alloc]init];
    //遍历
    for (size_t i = 0; i < count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        [imageArray addObject:(__bridge UIImage *)(image)];
        CGImageRelease(image);
        //获取图片信息
        NSDictionary *info = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
        CGFloat width = [[info objectForKey:(__bridge NSString *)kCGImagePropertyPixelWidth]floatValue];
        CGFloat height = [[info objectForKey:(__bridge NSString *)kCGImagePropertyPixelHeight]floatValue];
        [widthArray addObject:[NSNumber numberWithFloat:width]];
        [heightArray addObject:[NSNumber numberWithFloat:height]];
        
        NSDictionary *timeDic = [info objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        CGFloat time = [[timeDic objectForKey:(__bridge NSString *)kCGImagePropertyGIFDelayTime]floatValue];
        allTime += time;
        [timeArray addObject:[NSNumber numberWithFloat:time]];
    }
    dataBlock(imageArray,timeArray,allTime,widthArray,heightArray);
}

//为UIImageView添加一个设置gif图内容的方法
- (void)zl_setImage:(NSURL *)imageUrl {
    
    __weak id __self = self;
    [self getGifImageWithUrl:imageUrl retrurnData:^(NSArray<UIImage *> *imageArray, NSArray<NSNumber *> *timeArray, CGFloat totalTime, NSArray<NSNumber *> *widths, NSArray<NSNumber *> *heights) {
       //添加帧动画
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
        NSMutableArray *times = [[NSMutableArray alloc]init];
        float currentTime = 0;
        //设置每一帧的时间占比
        for (int i = 0; i < imageArray.count; i++) {
            [times addObject:[NSNumber numberWithFloat:currentTime/totalTime]];
            currentTime += [timeArray[i] floatValue];
        }
        [animation setKeyTimes:times];
        [animation setValues:imageArray];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        //设置循环
        animation.repeatCount = INFINITY;
        //设置播放总时长
        animation.duration = totalTime;
        //Layer层添加
        [[(UIImageView *) __self layer] addAnimation:animation forKey:@"gifAnimation"];
    }];
}


@end
