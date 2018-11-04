//
//  ProductSkuCollectionViewCell.m
//  XProject
//
//  Created by laughing on 2018/11/1.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ProductSkuCollectionViewCell.h"
#import "ProductDetailSkuCellModel.h"

@interface ProductSkuCollectionViewCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *SKULabel;
@end

@implementation ProductSkuCollectionViewCell
@synthesize model = _model;
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexColorString:@"f4f4f4"];
        [self addSubview:self.nameLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

+(NSString *)cellIdentifierl
{
    return NSStringFromClass(self.class);
}

-(void)setModel:(id<CollectionDatasourceProtocol>)model
{
    _model = model;
    
    if ([_model isKindOfClass:[ProductDetailSkuCellModel class]]) {
        ProductDetailSkuCellModel *cellModel = _model;
        self.nameLabel.text = cellModel.skuName;
        if (cellModel.isSelect) {
            self.backgroundColor = [UIColor colorWithHexColorString:@"ff4873"];
        }else{
            self.backgroundColor = [UIColor colorWithHexColorString:@"f4f4f4"];
        }
    }
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor colorWithHexColorString:@"666666"];
            label.font = [UIFont systemFontOfSize:13];
            label;
        });
    }
    return _nameLabel;
}

-(UILabel *)SKULabel
{
    if (!_SKULabel) {
        _SKULabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:12];
            label;
        });
    }
    return _SKULabel;
}
@end
