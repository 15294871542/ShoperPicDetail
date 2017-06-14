//
//  ShoperPhotoView.h
//  ETravel
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoperPhotoView : UIView <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIScrollView * topScrollView;//顶部滚动视图
@property (nonatomic,strong) UIScrollView * bottomScrollView;//底部滚动视图
@property (nonatomic,strong) UIView * topScrollLine;//顶部下划线
@property (nonatomic,strong) UIView * lineView;//底部横线

@property (nonatomic,strong) NSArray * dataArray;//数据数组
/** 顶部视图选项最小宽度 */
@property (nonatomic,assign) CGFloat minWidth;//默认60

@property (nonatomic,strong) void (^ picClicked)(NSInteger section,NSInteger row);//图片点击

@end
