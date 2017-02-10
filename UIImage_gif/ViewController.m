//
//  ViewController.m
//  UIImage_gif
//
//  Created by libo on 2017/2/10.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+Gif.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView+WebCache.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self playGIFWithWebView]; //占用内存最大 效果最好
//    [self playGIFWithSDWebImage];
//    [self showGifImageWithImageView]; //占用内存 第二 效果比webView播放稍微差一点
    [self showGifImageWithFLAnimatedImage];//占用内存 最少 但效果最不好 FLAnimatedImageView+WebCache 有缓存机制 二次播放无需加载
}


//使用UIWebView的弊端在于,不能设置Gif动画的播放时间
- (void)playGIFWithWebView {
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"]];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 400, 400)];
    webView.center = self.view.center;
    [webView loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
}

//不能播放gif
- (void)playGIFWithSDWebImage {

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 400, 400)];
    imageView.center = self.view.center;
    imageView.backgroundColor = [UIColor cyanColor];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"]];
//    [imageView zl_setImage:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"]];
    [self.view addSubview:imageView];
}

- (void)showGifImageWithImageView {

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 400, 400)];
    imageView.center = self.view.center;

    imageView.backgroundColor = [UIColor cyanColor];
    [imageView zl_setImage:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"]];
    [self.view addSubview:imageView];
}

- (void)showGifImageWithFLAnimatedImage {

//    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"]]];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc]init];
//    imageView.animatedImage = image;
    //http://s3.amazonaws.com/fast-image-cache/demo-images/FICDDemoImage012.jpg
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"]];
    imageView.frame = CGRectMake(0, 0, 400, 400);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
