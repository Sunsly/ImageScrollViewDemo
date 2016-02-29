//
//  SunshineScrollView.m
//  ImageScrollViewDemo
//
//  Created by 辉 on 16/1/28.
//  Copyright © 2016年 辉. All rights reserved.
//

#import "SunshineScrollView.h"

#import "UIView+Frame.h"

@interface SunshineScrollView () <UIScrollViewDelegate>

@property (nonatomic,weak)    UIScrollView *scrollview; //滚动视图

@property (nonatomic,assign)  NSInteger imageCount;//图片数量数据源个数

@property (nonatomic,assign)  NSInteger currentImageIndex;// 当前图片index

@property (nonatomic,strong)  NSMutableArray *imageArrays;//  存储数据源

@property (nonatomic,weak)   UIImageView *leftImage;// left image

@property (nonatomic,weak)   UIImageView *centerImage;// center image

@property (nonatomic,weak)   UIImageView *rightImage;// right image


@property (nonatomic,assign) CGFloat selfHeight;//当前view高度
@property (nonatomic,assign) CGFloat selfWidth;//当前view宽度

@property (nonatomic,strong) NSTimer *timer;//定时器

@property (nonatomic,weak)   UIPageControl *pageControll;//

@property (nonatomic,weak)   UILabel *indexLabel;//第几张

@end

@implementation SunshineScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    //大于等于2 ；图片个数
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageArrays = [[NSMutableArray alloc]initWithObjects:[UIColor lightGrayColor],[UIColor purpleColor],[UIColor yellowColor], nil];
        
        _selfHeight = frame.size.height;
        _selfWidth  = frame.size.width;
        
        [self initScrollView];
        
        _currentImageIndex = 0;//默认为0
        
        _imageCount = 3;//默认3个
        
        [self initImageView];
        
        [self updateImageIndex:_imageCount-1 center:_currentImageIndex right:1];//默认  2 ，0， 1
        
        [self initTimer];
    }
    return self;
}
#pragma mark ----- >init滚动视图
- (void)initScrollView
{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _selfWidth, _selfHeight)];
    scroll.contentSize = CGSizeMake(_selfWidth*3, _selfHeight);
    scroll.bounces = NO;
    scroll.delegate = self;
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    _scrollview = scroll;
    [self addSubview:_scrollview];
    
    
    UIPageControl  * page = [[UIPageControl alloc]initWithFrame:CGRectMake(self.centerX - 50, _selfHeight - 40, 100, 40)];
    _pageControll = page;
    _pageControll.pageIndicatorTintColor = [UIColor redColor];
    _pageControll.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControll.numberOfPages  = 3;
    [self addSubview:_pageControll];
    
    //显示第几张
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, _selfHeight - 40, 100, 40)];
    [self addSubview:label];
    _indexLabel = label;
    _indexLabel.font = [UIFont systemFontOfSize:14.0f];
    _indexLabel.textColor = [UIColor whiteColor];
    _indexLabel.backgroundColor = [UIColor clearColor];
    _indexLabel.text = @"0";
    _indexLabel.textAlignment = NSTextAlignmentCenter;
    
}
#pragma mark -------> init imageview
- (void)initImageView
{
    UIImageView *left = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _selfWidth, _selfHeight)];
    _leftImage = left;
    
    
    UIImageView *center = [[UIImageView alloc]initWithFrame:CGRectMake(_selfWidth, 0, _selfWidth, _selfHeight)];
    _centerImage = center;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageImdex:)];
    _centerImage.userInteractionEnabled = YES;
    [_centerImage addGestureRecognizer:tap];
    
    
    
    UIImageView *right = [[UIImageView alloc]initWithFrame:CGRectMake(_selfWidth*2, 0, _selfWidth, _selfHeight)];
    _rightImage = right;
    
    [_scrollview addSubview:_leftImage];
    [_scrollview addSubview:_centerImage];
    [_scrollview addSubview:_rightImage];
    
    
}
- (void)tapImageImdex:(UITapGestureRecognizer *)tap
{
    
    [self.delegate clickImageIndex:_currentImageIndex];
    
}
#pragma mark ---------> 更新 滚动视图上的 图片
- (void)updateImageIndex:(NSInteger)leftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex
{
    _leftImage.backgroundColor = _imageArrays[leftIndex];
    _centerImage.backgroundColor = _imageArrays[centerIndex];
    _rightImage.backgroundColor = _imageArrays[rightIndex];
    
    _scrollview.contentOffset = CGPointMake(_selfWidth, 0);//初始化设置滚动视图的位置;
}
#pragma mark --------->滚动视图的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self changeScrollViewContentOffset:_scrollview.contentOffset.x];//
    
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    //开始拖拽滚动视图的时候  关闭定时器；
    [self releaseTimer];
}
#pragma mark ----------> 销毁定时器
- (void)releaseTimer
{
    //销毁定时器
    if (_timer == nil) {
        NSLog(@"---->>");
        return;
    } else {
        if (_timer.isValid) {
            [_timer invalidate];
            _timer  = nil;
            NSLog(@"---s->>");

        }
    }
    NSLog(@"--d-->>");

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //结束拖拽滚动视图的时候  打开定时器；
    [self initTimer];
}
#pragma mark --------- > update 图片
- (void)changeScrollViewContentOffset:(CGFloat)offset
{
    /*
     获取 scrollview的contentoffset.x
     默认当前 _currentImageIndex
     
     当offset 大于等于  scrollview的宽＊2 的时候
     
     _currentImageIndex ++
     
     当_currentImageIndex  == 数据源个数  即中心的centerimage 索取的图片为第一张（当前）0  ** （左）为最后一张
     **     （右）第二张
     当 _currentImageIndex < 数据源个数－1 即中心点的center 索取的图片 为最后一张 (当前)   ** （左）为第倒数第二张 **（右）第一张
     其他情况依次为 （左）_currentImageIndex － 1 ；(当前)_currentImageIndex ;(右)_currentImageIndex＋1；
     
     */
    if (offset >= _selfWidth*2) {
        _currentImageIndex ++;
        if (_currentImageIndex == _imageCount) {
            _currentImageIndex = 0;
            [self updateImageIndex:_imageCount - 1 center:0 right:1];
        } else if (_currentImageIndex == _imageCount - 1){
            [self updateImageIndex:_currentImageIndex - 1 center:_currentImageIndex  right:0];
        } else {
            [self updateImageIndex:_currentImageIndex - 1 center:_currentImageIndex right:_currentImageIndex + 1];
        }
    }
    
    if (offset <= 0) {
        _currentImageIndex --;
        if (_currentImageIndex == 0) {
            [self updateImageIndex:_imageCount - 1 center:_currentImageIndex right:_currentImageIndex + 1];
        } else if (_currentImageIndex == -1) {
            _currentImageIndex = _imageCount - 1;//
            [self updateImageIndex:_currentImageIndex - 1 center:_currentImageIndex right:0];
            
        } else {
            [self updateImageIndex:_currentImageIndex - 1 center:_currentImageIndex right:_currentImageIndex+1];
        }
        
    }
    _pageControll.currentPage = _currentImageIndex;
    _indexLabel.text = [NSString stringWithFormat:@"第%ld张",_currentImageIndex];
    
}
#pragma mark ---------->init 定时器
- (void)initTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollViewTimer) userInfo:nil repeats:YES];
    //[_timer setFireDate:[NSDate distantFuture]];
    // [self performSelector:@selector(after) withObject:nil afterDelay:3];
}
//
- (void)after
{
    //[_timer setFireDate:[NSDate distantPast]]; //启动
}
#pragma mark --------->  定时器
- (void)scrollViewTimer
{
    NSLog(@"--%lf",_scrollview.contentOffset.x);
    
    [_scrollview setContentOffset:CGPointMake(_scrollview.contentOffset.x + _selfWidth, 0) animated:YES];
}
#pragma mark ---------- > 获取数据源
-(void)updateImageData:(NSArray *)array
{
    
    
    [_imageArrays removeAllObjects];
    [_imageArrays addObjectsFromArray:array];;
    
    _imageCount = _imageArrays.count;
    
    _pageControll.numberOfPages = _imageCount;
    _currentImageIndex = 0;
    [self changeScrollViewContentOffset:_scrollview.contentOffset.x];// 重新获取
}

#pragma mark ---------->dealloc
-(void)dealloc
{
    NSLog(@"dealloc");
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
