//
//  SunshineScrollView.h
//  ImageScrollViewDemo
//
//  Created by 辉 on 16/1/28.
//  Copyright © 2016年 辉. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SunshineScrollViewDelegate <NSObject>
/**
 *  SunshineScrollViewDelegate
 *
 *  @param imageIndex 返回数据源的index
 */
- (void)clickImageIndex:(NSInteger)imageIndex;

@end
@interface SunshineScrollView : UIView

@property (nonatomic,assign) id<SunshineScrollViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame;

- (void)updateImageData:(NSArray *)array;

@end
