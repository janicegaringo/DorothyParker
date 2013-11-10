// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Recipe.h instead.

#import <CoreData/CoreData.h>


extern const struct RecipeAttributes {
	__unsafe_unretained NSString *ingredients;
	__unsafe_unretained NSString *recipedescription;
	__unsafe_unretained NSString *thumbnail;
	__unsafe_unretained NSString *thumbnailretina;
	__unsafe_unretained NSString *title;
} RecipeAttributes;

extern const struct RecipeRelationships {
} RecipeRelationships;

extern const struct RecipeFetchedProperties {
} RecipeFetchedProperties;








@interface RecipeID : NSManagedObjectID {}
@end

@interface _Recipe : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RecipeID*)objectID;





@property (nonatomic, strong) NSString* ingredients;



//- (BOOL)validateIngredients:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* recipedescription;



//- (BOOL)validateRecipedescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* thumbnail;



//- (BOOL)validateThumbnail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* thumbnailretina;



//- (BOOL)validateThumbnailretina:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;






@end

@interface _Recipe (CoreDataGeneratedAccessors)

@end

@interface _Recipe (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveIngredients;
- (void)setPrimitiveIngredients:(NSString*)value;




- (NSString*)primitiveRecipedescription;
- (void)setPrimitiveRecipedescription:(NSString*)value;




- (NSString*)primitiveThumbnail;
- (void)setPrimitiveThumbnail:(NSString*)value;




- (NSString*)primitiveThumbnailretina;
- (void)setPrimitiveThumbnailretina:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




@end
