//
//  ShoperPhotoView.m
//  ETravel
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//

#import "ShoperPhotoView.h"
#import "MerchantsCateModel.h"
#import "MctCateModel.h"
#import "MyCollectionViewCell.h"
#import "UIImageView+WebCache.h"

#define DeviceWidth     [UIScreen mainScreen].bounds.size.width
#define DeviceHeight    [UIScreen mainScreen].bounds.size.height

#define selfWidth self.frame.size.width
#define selfHeight self.frame.size.height

#define normalColor  [self colorWithHexString:@"#333333"]
#define selectedColor  [self colorWithHexString:@"#2591ff"]

static NSString * const kvcell=@"MyCollectionViewCell";
static NSString * const kvhead=@"MyCollectionViewHeader";

@implementation ShoperPhotoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
        [self creatScrollView];//创建滚动视图
        
    }
    
    return self;
}

//创建滚动视图
-(void)creatScrollView
{
    self.topScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 40)];
    self.topScrollView.backgroundColor=[UIColor whiteColor];
    self.topScrollView.showsHorizontalScrollIndicator=NO;
    self.topScrollView.delegate=self;
    [self addSubview:self.topScrollView];
    
    self.topScrollLine=[[UIView alloc]initWithFrame:CGRectMake(0, 39.5, selfWidth, 0.5)];
    self.topScrollLine.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:self.topScrollLine];
    
    self.bottomScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, DeviceWidth, selfHeight-40)];
    self.bottomScrollView.backgroundColor=[UIColor whiteColor];
    self.bottomScrollView.showsHorizontalScrollIndicator=NO;
    self.bottomScrollView.pagingEnabled=YES;
    self.bottomScrollView.delegate=self;
    [self addSubview:self.bottomScrollView];
}

-(void)setDataArray:(NSArray *)dataArray
{
    if (dataArray!=nil) {
        _dataArray=dataArray;
        
        [self upDateScrollView];//更新滚动视图
    }
}

//更新滚动视图
-(void)upDateScrollView
{
    CGFloat theMinWidth=60;
    if (self.minWidth!=0) {
        theMinWidth=self.minWidth;
    }
    self.topScrollView.contentSize=CGSizeMake(theMinWidth*(self.dataArray.count+1), 40);
    self.bottomScrollView.contentSize=CGSizeMake(selfWidth*(self.dataArray.count+1), selfHeight-40);
    
    for (int i=0; i<self.dataArray.count+1; i++) {
        
        MerchantsCateModel * merchantsCate;
        if (i>=1) {
            merchantsCate=self.dataArray[i-1];
        }
        
        //创建顶部滚动视图子控件
        UIButton * topButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [topButton setTitle:merchantsCate.album_cate_name forState:UIControlStateNormal];
        topButton.titleLabel.font=[UIFont systemFontOfSize:13];
        [topButton setTitleColor:normalColor forState:UIControlStateNormal];
        [topButton setTitleColor:selectedColor forState:UIControlStateSelected];
        topButton.tag=10+i;
        topButton.frame=CGRectMake(theMinWidth*i, 0, theMinWidth, 40);
        [topButton addTarget:self action:@selector(topButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.topScrollView addSubview:topButton];
        
        
        if (i==0) {
            
            topButton.selected=YES;
            [topButton setTitle:@"全部" forState:UIControlStateNormal];
            
            self.lineView=[[UIView alloc]init];
            self.lineView.backgroundColor=selectedColor;
            self.lineView.center=CGPointMake(topButton.center.x, 39);
            self.lineView.bounds=CGRectMake(0, 0, 40, 2);
            [self.topScrollView addSubview:self.lineView];
            
        }
        
        //创建底部滚动视图子控件
        UICollectionViewFlowLayout * layout=[[UICollectionViewFlowLayout alloc]init];
        layout.itemSize=CGSizeMake((DeviceWidth-36)/2, (DeviceWidth-38)/2*0.56);
        layout.minimumLineSpacing=11;
        layout.minimumInteritemSpacing=12;
        
        UICollectionView * myCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(12+(selfWidth*i), 0, selfWidth-24, selfHeight-40) collectionViewLayout:layout];
        myCollectionView.delegate=self;
        myCollectionView.dataSource=self;
        myCollectionView.backgroundColor=[UIColor whiteColor];
        myCollectionView.tag=100+i;
        [self.bottomScrollView addSubview:myCollectionView];
        
        [myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kvcell];
        
        [myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kvhead];
        
    }    
    
}

//顶部按钮点击事件
-(void)topButtonClicked:(UIButton *)btn
{
    [self setCurrentClickedButton:btn];
    self.bottomScrollView.contentOffset=CGPointMake((btn.tag-10)*selfWidth, 0);
}

//设置当前选中的button及横线
-(void)setCurrentClickedButton:(UIButton *)btn
{
    CGFloat theMinWidth=60;
    if (self.minWidth!=0) {
        theMinWidth=self.minWidth;
    }
    
    for (int i=0; i<self.dataArray.count+1; i++) {
        
        UIButton * button=[self.topScrollView viewWithTag:10+i];
        button.selected=NO;
        
    }
    
    btn.selected=YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.center=CGPointMake(btn.center.x, 39);
        self.lineView.bounds=CGRectMake(0, 0, 40, 2);
    }];
    
}

#pragma mark - scrollView代理方法

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==self.bottomScrollView) {
        
        int index=self.bottomScrollView.contentOffset.x/selfWidth;
        UIButton * button=[self.topScrollView viewWithTag:10+index];
        [self setCurrentClickedButton:button];
        
    }
}


#pragma mark - myCollectionView的代理方法

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView.tag==100) {
        return self.dataArray.count;
    } else {
        return 1;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag==100) {
        MerchantsCateModel * merchantsCate=self.dataArray[section];
        return merchantsCate.album_list.count;
    } else {
        MerchantsCateModel * merchantsCate=self.dataArray[collectionView.tag-101];
        return merchantsCate.album_list.count;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((DeviceWidth-38)/2, (DeviceWidth-38)/2*0.51);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(11, 0, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (collectionView.tag==100) {
        return CGSizeMake(DeviceWidth, 28);
    } else {
        return CGSizeMake(0, 0);
    }
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag==100) {
        UICollectionReusableView * headView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kvhead forIndexPath:indexPath];
        
        MerchantsCateModel * merchantsCate=self.dataArray[indexPath.section];
        
        UILabel * lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, selfWidth, 40)];
        lable.textColor=[UIColor lightGrayColor];
        lable.text=[NSString stringWithFormat:@"%@（%lu）",merchantsCate.album_cate_name,(unsigned long)merchantsCate.album_list.count];
        lable.font=[UIFont systemFontOfSize:14];
        [headView addSubview:lable];
        
        
        return headView;
    } else {
        UICollectionReusableView * headView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kvhead forIndexPath:indexPath];
        
        return headView;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:kvcell forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    
    if (collectionView.tag==100) {
        
        MerchantsCateModel * merchantsCate=self.dataArray[indexPath.section];
        MctCateModel * mctCate=merchantsCate.album_list[indexPath.item];
        [cell.theImageView sd_setImageWithURL:[NSURL URLWithString:mctCate.picture]];
        
    } else {
        
        MerchantsCateModel * merchantsCate=self.dataArray[collectionView.tag-101];
        MctCateModel * mctCate=merchantsCate.album_list[indexPath.item];
        [cell.theImageView sd_setImageWithURL:[NSURL URLWithString:mctCate.picture]];
        
    }

    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag==100) {
        
        self.picClicked(indexPath.section,indexPath.item);
        
    } else {
        
        self.picClicked(collectionView.tag-101,indexPath.item);
        
    }
}

/**
 *  将十六进制颜色转换为 UIColor 对象
 *  color:        要转换的十六进制字符串
 */
- (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip "0X" or "#" if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end
