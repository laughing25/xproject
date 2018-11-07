//
//  MyOrderListTableViewCell.m
//  XProject
//
//  Created by 610715 on 2018/9/3.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "MyOrderListTableViewCell.h"
#import "ProductModel.h"

@interface MyOrderListTableViewCell ()

@property (nonatomic, strong) UILabel *orderTimeLabel;
@property (nonatomic, strong) UILabel *orderStatusLabel;

@property (nonatomic, strong) UIView *middleContentView;
@property (nonatomic, strong) YYAnimatedImageView *productImageView;
@property (nonatomic, strong) UILabel *productLabel;


@property (nonatomic, strong) UILabel *conteLabel;

@end

@implementation MyOrderListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.orderTimeLabel];
        [self.contentView addSubview:self.orderStatusLabel];
        
        [self.contentView addSubview:self.middleContentView];
        [self.middleContentView addSubview:self.productImageView];
        [self.middleContentView addSubview:self.productLabel];
        
        [self.contentView addSubview:self.conteLabel];
        
        CGFloat padding = 10;
        UIView *contentView = self.contentView;
        [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.orderStatusLabel);
            make.top.mas_equalTo(self.orderStatusLabel.mas_bottom).mas_offset(5);
        }];
        
        [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(contentView.mas_leading).mas_offset(padding);
            make.top.mas_equalTo(contentView.mas_top).mas_offset(padding);
        }];
        
        [self.middleContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.orderTimeLabel.mas_bottom).mas_offset(padding);
            make.leading.trailing.mas_equalTo(contentView);
            make.height.mas_offset(110);
        }];
        
        [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.middleContentView).mas_offset(padding+5);
            make.centerY.mas_equalTo(self.middleContentView);
            make.height.mas_offset(80);
            make.width.mas_equalTo(self.productImageView.mas_height);
        }];
        
        [self.productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.productImageView.mas_trailing).mas_offset(padding/2);
            make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(-padding/2);
            make.top.mas_equalTo(self.productImageView.mas_top);
        }];
        
        self.productLabel.preferredMaxLayoutWidth = KScreenWidth - 80 - padding*2;
        
        [self.conteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(contentView.mas_trailing).mas_offset(-padding);
            make.top.mas_equalTo(self.middleContentView.mas_bottom).mas_offset(padding);
            make.bottom.mas_equalTo(contentView.mas_bottom).mas_offset(-padding);
        }];
    }
    return self;
}

#pragma mark - setter and getter

-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    if (_orderModel.message.length) {
        NSData *jsonData = [_orderModel.message dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSArray *attrList = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSDictionary *attrParams = [attrList firstObject];
        if ([attrParams isKindOfClass:[NSDictionary class]]) {
            NSString *quantity = attrParams[@"Quantity"];
            NSString *price = attrParams[@"Price"];
            self.conteLabel.text = [NSString stringWithFormat:@"共%@件商品  价格: ¥%@", quantity, price];
            
            NSArray *paramList = attrParams[@"AttrList"];
            if ([paramList isKindOfClass:[NSArray class]]) {
                NSMutableString *skuString = [[NSMutableString alloc] init];
                [paramList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *param = obj;
                    NSString *skuName = param[@"AttrValue"];
                    NSString *skuValue = param[@"AttrPrice"];
                    [skuString appendFormat:@"%@(¥%@)", skuName, skuValue];
                }];
                self.productLabel.text = skuString;
            }
        }
    }
    
    [self.productImageView yy_setImageWithURL:[NSURL URLWithString:_orderModel.focusImgUrl] placeholder:nil];
    self.orderTimeLabel.text = [NSString stringWithFormat:@"下单日期: %@", _orderModel.add_time];
    self.orderStatusLabel.text = [NSString stringWithFormat:@"订单号: %@", _orderModel.order_no];
}

-(UILabel *)orderTimeLabel
{
    if (!_orderTimeLabel) {
        _orderTimeLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:12];
            label;
        });
    }
    return _orderTimeLabel;
}

-(UILabel *)orderStatusLabel
{
    if (!_orderStatusLabel) {
        _orderStatusLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14];
            label;
        });
    }
    return _orderStatusLabel;
}

-(UIView *)middleContentView
{
    if (!_middleContentView) {
        _middleContentView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor groupTableViewBackgroundColor];
            view;
        });
    }
    return _middleContentView;
}

-(YYAnimatedImageView *)productImageView
{
    if (!_productImageView) {
        _productImageView = ({
            YYAnimatedImageView *image = [[YYAnimatedImageView alloc] init];
//            image.layer.borderWidth = 1;
//            image.layer.borderColor = [UIColor blackColor].CGColor;
            image;
        });
    }
    return _productImageView;
}

-(UILabel *)productLabel
{
    if (!_productLabel) {
        _productLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:13];
            label.numberOfLines = 0;
            label;
        });
    }
    return _productLabel;
}

-(UILabel *)conteLabel
{
    if (!_conteLabel) {
        _conteLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14];
            label;
        });
    }
    return _conteLabel;
}

@end
