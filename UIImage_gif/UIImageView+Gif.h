//
//  UIImageView+Gif.h
//  UIImage_gif
//
//  Created by libo on 2017/2/10.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Gif)

/** 解析gif文件数据的方法 block中会将解析的数据传递出来 */
- (void)getGifImageWithUrl:(NSURL *)url retrurnData:(void(^)(NSArray<UIImage *>* imageArray,NSArray<NSNumber *>* timeArray,CGFloat totalTime,NSArray<NSNumber *>* widths,NSArray <NSNumber *>* heights))dataBlock;

/** 为UIImageView 添加一个设置gif图内容的方法 */
- (void)zl_setImage:(NSURL *)imageUrl;


@end
