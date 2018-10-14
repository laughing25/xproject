//
//  YSCollectionViewBannerCell.m
//  YoshopPro
//
//  Created by 610715 on 2018/5/30.
//  Copyright © 2018年 yoshop. All rights reserved.
//

#import "YSCollectionViewBannerCell.h"
#import "SDCycleScrollView.h"
#import "ProductModel.h"

@interface YSCollectionViewBannerCell ()
<
    SDCycleScrollViewDelegate
>
@property (nonatomic, strong) SDCycleScrollView *bannerView;
@end

@implementation YSCollectionViewBannerCell
@synthesize model = _model;
@synthesize delegate = _delegate;

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.bannerView];
        
        [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([self.model.dataSource isKindOfClass:[NSArray class]]) {
        NSArray *list = (NSArray *)self.model.dataSource;
        if (list.count > index) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(ysCollectionViewBannerCell:jumpModel:)]) {
                [self.delegate ysCollectionViewBannerCell:self jumpModel:list[index]];
            }
        }
    }
}

+(NSString *)cellIdentifierl
{
    return NSStringFromClass(self.class);
}

#pragma mark - setter and getter

-(void)setModel:(id<CollectionDatasourceProtocol>)model
{
    if (model == _model) return;
    
    _model = model;
    NSMutableArray *imageUrls = [[NSMutableArray alloc] init];
    if ([model.dataSource isKindOfClass:[NSArray class]]) {
        NSArray *list = (NSArray *)model.dataSource;
        
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[AdInfoModel class]]) {
                AdInfoModel *model = obj;
                [imageUrls addObject:model.img_url];
            }
//            [imageUrls addObject:@"https://gloimg.zaful.com/zaful/pdm-product-pic/Clothing/2018/08/01/goods-grid-app/1533583378560336120.jpg"];
        }];
    }
    
    if ([model.dataSource isKindOfClass:[ProductModel class]]) {
        ProductModel *productModel = (ProductModel *)model.dataSource;
        NSArray *urlList = [productModel.thumbnailsUrll componentsSeparatedByString:@","];
        [imageUrls addObjectsFromArray:urlList];
    }
    self.bannerView.imageURLStringsGroup = [imageUrls copy];
}

-(SDCycleScrollView *)bannerView
{
    if (!_bannerView) {
        _bannerView = ({
            SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"placeholder_banner_pdf"]];
            scrollView.autoScrollTimeInterval = 3.0; // 间隔时间
            scrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
            scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            scrollView;
        });
    }
    return _bannerView;
}

@end
