//
//	CategoryModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CategoryModel.h"
#import "YSTopicCollectionViewCell.h"

@interface CategoryModel ()
@end
@implementation CategoryModel
@synthesize dataSource = _dataSource;
@synthesize specialIdentifier = _specialIdentifier;

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"classContent" : @"class_content",
             @"classLayer" : @"class_layer",
             @"classList" : @"class_list",
             @"icoUrl" : @"ico_url",
             @"idField" : @"id",
             @"imgUrl" : @"img_url",
             @"linkUrl" : @"link_url",
             @"parentId" : @"parent_id",
             @"seoDescription" : @"seo_description",
             @"seoKeywords" : @"seo_keywords",
             @"seoTitle" : @"seo_title",
             @"sortId" : @"sort_id",
             };
}

-(NSString *)CollectionDatasourceCellIdentifier:(NSIndexPath *)indexPath
{
    return [YSTopicCollectionViewCell cellIdentifierl];
}

-(Class)CollectionDatasourceClass
{
    return [YSTopicCollectionViewCell class];
}

- (CGSize)dataSourceSize {
    ///传0,在module里面做了特殊的运算
    return CGSizeMake(0, 80);
}

- (void)registerCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath specialIdentifier:(NSString *)specialIdentifier {
    [collectionView registerClass:[self CollectionDatasourceClass] forCellWithReuseIdentifier:[self CollectionDatasourceCellIdentifier:indexPath]];
}

@end
